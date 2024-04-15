## Which products had their inventory change from week 3 to week 4?

ZZ Plant
Philodendron
String of pearls
Monstera
Bamboo
Pothos

``sql
    select 
        * 
    from 
        DEV_DB.DBT_JLONGOGLOBALPCOM.INVENTORY_SNAPSHOT
    where
        dbt_valid_to is not null
        and dbt_valid_to > '2024-04-08 00:11:04.860'

## Now that we have 3 weeks of snapshot data, can you use the inventory changes to determine which products had the most fluctuations in inventory?

| Inventory Changes | Name           |
|-------------------|----------------|
| 3                 | Philodendron   |
| 3                 | String of pearls |
| 3                 | Monstera       |
| 3                 | Pothos         |
| 2                 | ZZ Plant       |
| 2                 | Bamboo         |

``sql
    select 
        count(name) as inventory_changes ,
        name
        
    from 
        DEV_DB.DBT_JLONGOGLOBALPCOM.INVENTORY_SNAPSHOT
    where
        dbt_valid_to is not null
    group by 
        name
    order by 
        1 desc

select 
    count(name) as inventory_changes ,
    name
    
from 
    DEV_DB.DBT_JLONGOGLOBALPCOM.INVENTORY_SNAPSHOT
where
    dbt_valid_to is not null
group by 
    name
order by 
    1 desc


## Did we have any items go out of stock in the last 3 weeks? 
| PRODUCT_ID                            | NAME             | PRICE | INVENTORY | DBT_UPDATED_AT              | DBT_VALID_FROM             | DBT_VALID_TO               |
|-------------------------------------- | ----------------|-------|-----------|------------------------------|----------------------------|----------------------------|
| fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80 | String of pearls | 80.5  | 0         | 2024-04-08 00:11:04.860     | 2024-04-08 00:11:04.860    | 2024-04-15 01:48:00.584   |
| 4cda01b9-62e2-46c5-830f-b7f262a58fb1 | Pothos           | 30.5  | 0         | 2024-04-08 00:11:04.860     | 2024-04-08 00:11:04.860    | 2024-04-15 01:48:00.584   |


``sql
    select 
    PRODUCT_ID, NAME, PRICE, INVENTORY, DBT_UPDATED_AT, DBT_VALID_FROM, DBT_VALID_TO
        
    from 
        DEV_DB.DBT_JLONGOGLOBALPCOM.INVENTORY_SNAPSHOT
    where
        dbt_valid_to is not null
        and inventory = 0

## How are our users moving through the product funnel?
Users move from page views to add to carts around 53% of the time. Approximately 37% of the time they checkout after they have added to cart. And finally 93% of the time their packages are shipped.



## Which steps in the funnel have largest drop off points?
The largest drop off is from pages viewed to a user adding something to their cart.