with

    events as (

        select * from {{ref('stg_postgres__events')}}
        
    ),

    order_items as (

        select * from {{ref('stg_postgres__order_items')}}
        
    ),

    session_duration as (

        select * from {{ref('int_session_duration')}}

    ),

    {%  set event_type_list = dbt_utils.get_column_values(
            table=ref('stg_postgres__events'),
            column='event_type')    
    %}
/*
    [
            'page_view',
            'add_to_cart',
            'checkout',
            'package_shipped'
    ]
    */
    final as (

        -- This is for events with an order to get the product from the order_items table
        select 
            events.session_id,
            events.user_id,
            coalesce(events.product_id, order_items.product_id) as product_id,
            session_duration.session_started_at,
            session_duration.session_ended_at,

            {% for event_type in event_type_list %}

                {{sum_of('events.event_type', event_type)}} as {{event_type}}s,

            {% endfor %}
            
            /*
            sum(case when events.event_type = 'page_view' then 1 else 0 end) as page_views,
            sum(case when events.event_type = 'add_to_cart' then 1 else 0 end) as add_to_carts,
            sum(case when events.event_type = 'checkout' then 1 else 0 end) as checkouts,
            sum(case when events.event_type = 'package_shipped' then 1 else 0 end) as packages_shipped,
            */

            datediff('minute',session_duration.session_started_at,session_duration.session_ended_at) as session_length_minutes          
        from
            events
            join order_items on order_items.order_id = events.order_id
            join session_duration on session_duration.session_id = events.session_id
        where
            events.order_id is not null
        group by
            events.session_id,
            events.user_id,
            3,
            session_duration.session_started_at,
            session_duration.session_ended_at

        -- This is for events without an order to get the product from the event table
        
        union all 
        select 
            events.session_id,
            events.user_id,
            events.product_id,
            session_duration.session_started_at,
            session_duration.session_ended_at,

            {% for event_type in event_type_list %}

                {{sum_of('events.event_type', event_type)}} as {{event_type}}s,

            {% endfor %}
            
            /*
            sum(case when events.event_type = 'page_view' then 1 else 0 end) as page_views,
            sum(case when events.event_type = 'add_to_cart' then 1 else 0 end) as add_to_carts,
            sum(case when events.event_type = 'checkout' then 1 else 0 end) as checkouts,
            sum(case when events.event_type = 'package_shipped' then 1 else 0 end) as packages_shipped,
            */

            datediff('minute',session_duration.session_started_at,session_duration.session_ended_at) as session_length_minutes          
        from
            events
            join session_duration on session_duration.session_id = events.session_id
        where
            events.order_id is null
        group by
            events.session_id,
            events.user_id,
            3,
            session_duration.session_started_at,
            session_duration.session_ended_at
    )

select * from final