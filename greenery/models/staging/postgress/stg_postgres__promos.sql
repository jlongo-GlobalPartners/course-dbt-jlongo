with 
    
    source as (

        select * from {{source("postgres","promos")}}
    ),

    renamed as (

        select
            PROMO_ID,
            DISCOUNT,
            STATUS
        from
            source
    )

select * from renamed