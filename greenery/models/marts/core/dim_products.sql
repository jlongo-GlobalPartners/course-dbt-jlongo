{{
  config(
    materialized='table'
  )
}}

with 

    products as (

        select * from {{ref('stg_postgres__products')}}
    ),

    product_order_events as (

        select * from {{ref('int_product_order_event')}}

    ),

    final as (

    
        select
            p.PRODUCT_ID,
            p.NAME,
            p.PRICE,
            p.INVENTORY,
            poe.first_purchase_date,
            poe.last_purchase_date,
            poe.historical_quantity,
            poe.historical_orders,
            poe.total_views 
        from products p 
        join product_order_events poe on p.product_id = poe.product_id
    )

select * from final
