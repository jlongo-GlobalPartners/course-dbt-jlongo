with 

    events as (

        select * from {{ref('stg_postgres__events')}}

    ),

    session_duration as (

        select
            session_id,
            min(created_at) as session_started_at,
            max(created_at) as session_ended_at
        from    
            events
        group by
            session_id

    )

select * from session_duration