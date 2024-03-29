{{
  config(
    materialized='table'
  )
}}

with

page_views as (

    select * from {{ ref('int_page_views') }}

),

products as (

    select * from {{ ref('stg_postgres__products') }}

),

product_page_views as (

    select
    
        date_trunc(day, created_at) as page_view_date,
        product_id,
        count(event_id) as page_view_count,
        count(distinct user_id) as user_count
        
    from 
        page_views
    group by 
        page_view_date,
        product_id

),

final as (

    select
        pv.page_view_date,
        pv.product_id,
        p.name as product_name,
        pv.page_view_count,
        pv.user_count

    from product_page_views pv
    join products p
        on pv.product_id = p.product_id

)

select * from final
