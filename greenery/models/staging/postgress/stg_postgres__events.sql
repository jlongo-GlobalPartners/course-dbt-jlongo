with
    
    source as (

        select * from {{source('postgres','events')}}

    ),

    renamed as (


        select
            EVENT_ID,
            SESSION_ID,
            USER_ID,
            PAGE_URL,
            CREATED_AT,
            EVENT_TYPE,
            ORDER_ID,
            PRODUCT_ID 
        from 
            source
    )

select * from renamed