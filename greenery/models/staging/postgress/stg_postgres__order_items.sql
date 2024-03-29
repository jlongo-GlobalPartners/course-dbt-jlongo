with
    
    source as (
        
        select * from {{source('postgres','order_items')}}
    ),

    renamed as (

        select
            ORDER_ID,
            PRODUCT_ID,
            QUANTITY
        from 
            source

    )

select * from renamed