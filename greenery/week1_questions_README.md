How many users do we have? 130
select
    count(USER_ID)
from
    DEV_DB.DBT_JLONGOGLOBALPCOM.STG_POSTGRES__USERS

------------------------------------------------------------------
On average, how many orders do we receive per hour? 7.52
select
    count(order_id),
    timestampdiff(hour,min(created_at),max(created_at))+1 as total_hours,
    count(order_id) / (timestampdiff(hour,min(created_at),max(created_at))+1) as avg_orders_per_hour
from
    DEV_DB.DBT_JLONGOGLOBALPCOM.STG_POSTGRES__ORDERS

-------------------------------------------------------------------
On average, how long does an order take from being placed to being delivered? 93.4 hours

select
    count(order_id) as order_count,
    sum(timestampdiff(hour,created_at,delivered_at)) as total_hours_to_delivery,
    sum(timestampdiff(hour,created_at,delivered_at)) / count(order_id) as avg_order_delivery_hours
from
    DEV_DB.DBT_JLONGOGLOBALPCOM.STG_POSTGRES__ORDERS
where
    delivered_at is not NULL

-------------------------------------------------------------------
How many users have only made one purchase? 25
select count(user_id) as total_users
from ( 
    select
        user_id
    from
        DEV_DB.DBT_JLONGOGLOBALPCOM.STG_POSTGRES__ORDERS
    group by
        user_id
    having
        count(order_id) = 1
    )

-------------------------------------------------------------------
Two purchases? 28 
select count(user_id) as total_users
from ( 
    select
        user_id
    from
        DEV_DB.DBT_JLONGOGLOBALPCOM.STG_POSTGRES__ORDERS
    group by
        user_id
    having
        count(order_id) = 2
    )

-------------------------------------------------------------------
Three+ purchases? 71
select count(user_id) as total_users
from ( 
    select
        user_id
    from
        DEV_DB.DBT_JLONGOGLOBALPCOM.STG_POSTGRES__ORDERS
    group by
        user_id
    having
        count(order_id) > 2
    )

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

-------------------------------------------------------------------
On average, how many unique sessions do we have per hour? 16.33
select sum (unique_session_per_hour) / count(session_hour)
from 
    (
    select 
        count (distinct session_id) as unique_session_per_hour,
        DATE_TRUNC('Hour',CREATED_AT) session_hour
        
    from
        DEV_DB.DBT_JLONGOGLOBALPCOM.stg_postgres__events
    group by
            session_hour
    )
