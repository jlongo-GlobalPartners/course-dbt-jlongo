with

    source as ( 
        
        select * from {{source('postgres','addresses')}}

    ),

    renamed as (
        
        select
            ADDRESS_ID,
            ADDRESS,
            ZIPCODE,
            STATE,
            COUNTRY
        from 
            source
    )

select * from renamed
