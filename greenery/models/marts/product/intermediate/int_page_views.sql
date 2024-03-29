with 

    events as (

        select * from {{ref('stg_postgres__events')}}

    ),

    page_views as (

        select
            created_at,
            event_id,
            user_id,
            session_id,
            product_id,
            page_url
            
        from 
            events
        where 
            true
            and event_type = 'page_view'   
    )

select * from page_views

