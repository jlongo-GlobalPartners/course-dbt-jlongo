with

    source as (
        
        select * from {{source('postgres','products')}}

    ),

    renamed as (
        select
            PRODUCT_ID,
            NAME,
            PRICE,
            INVENTORY
        from
            source
    )

    select * from renamed