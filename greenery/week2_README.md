- What is our repeat user rate? 0.798387

with orders_count as (
    select
        user_id,
        count(distinct order_id) as user_orders
    from
        DEV_DB.DBT_JLONGOGLOBALPCOM.STG_POSTGRES__ORDERS
    group by 
        user_id
),
user_order_buckets as (
    select 
        user_id,
        (user_orders = 1)::int as one_purchase,
        (user_orders = 2)::int as two_purchases,
        (user_orders >= 2)::int as two_or_more_purchases            
    from 
        orders_count
),
    bucket_summary as (
    select 
        sum(one_purchase) as one_purchase,
        sum(two_purchases) as two_purchases,
        sum(two_or_more_purchases) as two_or_more_purchases,
        count(distinct user_id) as total_users_with_purchases,
    from
        user_order_buckets
)

    select 
        one_purchase,
        two_purchases,
        two_or_more_purchases,
        total_users_with_purchases,
        div0(two_or_more_purchases,total_users_with_purchases) as repeat_rate
    from
        bucket_summary

- Explain the product mart models you added. Why did you organize the models in the way you did?
    I added an intermediate model to determine page views and to get to a model to show product page views by day. I tried to organize the models in the order the data would flow best from lowest level of detail to target.

- Tests
    I added some tests for uniqueness and not null for fields in the models built in week 1. 

- Which products had their inventory change from week 1 to week 2? 
    Pothos
    Philodendron
    Monstera
    String of pearls

    select 
        * 
    from 
        DEV_DB.DBT_JLONGOGLOBALPCOM.INVENTORY_SNAPSHOT
    where
        dbt_valid_to is not null

