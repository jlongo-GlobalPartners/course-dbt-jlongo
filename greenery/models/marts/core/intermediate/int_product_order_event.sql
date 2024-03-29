
with

    product_views as (
        select
            count(PRODUCT_ID) as total_views,
            product_id
        from 
            {{ref('int_page_views')}} 
        group by
            product_id            
    ),

    product_orders as (
        select
            min(o.created_at) as first_purchase_date,
            max(o.created_at) as last_purchase_date,
            sum(oi.quantity) as historical_quantity,
            count(oi.product_id) as historical_orders,
            oi.product_id
            
        from
            {{ref('stg_postgres__orders')}} o
            join {{ref('stg_postgres__order_items')}} oi on o.order_id = oi.order_id
        group by
            oi.product_id
    
    ),

    final as (
        select 
            po.product_id,
            first_purchase_date,
            last_purchase_date,
            historical_quantity,
            historical_orders,
            total_views       
        from
            product_orders po
            JOIN product_views pv on po.product_id = pv.product_id
    )

select * from final
    
