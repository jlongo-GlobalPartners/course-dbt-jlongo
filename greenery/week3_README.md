## What is our overall conversion rate?
0.624567
SELECT
    COUNT(
        DISTINCT CASE WHEN CHECKOUTS = 1 THEN SESSION_ID END
    ) as total_unique_sessions_with_purchase,
    
    COUNT(DISTINCT SESSION_ID) as total_unique_sessions,
    
    COUNT(
        DISTINCT CASE WHEN CHECKOUTS = 1 THEN SESSION_ID END
    ) / 
    COUNT(DISTINCT SESSION_ID) as conversion_rate
FROM
    DEV_DB.DBT_JLONGOGLOBALPCOM.FCT_EVENTS


## What is our conversion rate by product?
| Name                 | Total Unique Sessions with Purchase | Total Unique Sessions | Conversion Rate |
|----------------------|-------------------------------------|-----------------------|-----------------|
| String of pearls     | 39                                  | 64                    | 0.609375        |
| Arrow Head           | 35                                  | 63                    | 0.555556        |
| Cactus               | 30                                  | 55                    | 0.545455        |
| ZZ Plant             | 34                                  | 63                    | 0.539683        |
| Bamboo               | 36                                  | 67                    | 0.537313        |
| Rubber Plant         | 28                                  | 54                    | 0.518519        |
| Monstera             | 25                                  | 49                    | 0.510204        |
| Calathea Makoyana   | 27                                  | 53                    | 0.509434        |
| Fiddle Leaf Fig      | 28                                  | 56                    | 0.5             |
| Majesty Palm         | 33                                  | 67                    | 0.492537        |
| Aloe Vera            | 32                                  | 65                    | 0.492308        |
| Devil's Ivy          | 22                                  | 45                    | 0.488889        |
| Philodendron         | 30                                  | 62                    | 0.483871        |
| Jade Plant           | 22                                  | 46                    | 0.478261        |
| Pilea Peperomioides | 28                                  | 59                    | 0.474576        |
| Spider Plant         | 28                                  | 59                    | 0.474576        |
| Dragon Tree          | 29                                  | 62                    | 0.467742        |
| Money Tree           | 26                                  | 56                    | 0.464286        |
| Orchid               | 34                                  | 75                    | 0.453333        |
| Bird of Paradise    | 27                                  | 60                    | 0.45            |
| Ficus                | 29                                  | 68                    | 0.426471        |
| Birds Nest Fern      | 33                                  | 78                    | 0.423077        |
| Pink Anthurium       | 31                                  | 74                    | 0.418919        |
| Boston Fern          | 26                                  | 63                    | 0.412698        |
| Alocasia Polly       | 21                                  | 51                    | 0.411765        |
| Peace Lily           | 27                                  | 66                    | 0.409091        |
| Ponytail Palm        | 28                                  | 70                    | 0.4             |
| Snake Plant          | 29                                  | 73                    | 0.39726         |
| Angel Wings Begonia  | 24                                  | 61                    | 0.393443        |
| Pothos               | 21                                  | 61                    | 0.344262        |

--------------------------------------------------------------------------------------------------------
SELECT
    dp.name,
    COUNT(
        DISTINCT 
        CASE
            WHEN CHECKOUTS = 1 THEN SESSION_ID            
        END
    ) as total_unique_sessions_with_purchase,
    COUNT(DISTINCT SESSION_ID) as total_unique_sessions,
    
    COUNT(
        DISTINCT 
        CASE
            WHEN CHECKOUTS = 1 THEN SESSION_ID            
        END
        ) / COUNT(DISTINCT SESSION_ID)
        
     as conversion_rate
FROM
    DEV_DB.DBT_JLONGOGLOBALPCOM.FCT_EVENTS fe 
    LEFT JOIN DEV_DB.DBT_JLONGOGLOBALPCOM.DIM_PRODUCTS dp ON fe.PRODUCT_ID = dp.PRODUCT_ID
GROUP BY
    dp.name
order by
    conversion_rate desc
    
## Which products had their inventory change from week 2 to week 3? 

Monstera
Philodendron
Pothos
String of pearls
Bamboo
ZZ Plant

    select 
        * 
    from 
        DEV_DB.DBT_JLONGOGLOBALPCOM.INVENTORY_SNAPSHOT
    where
        dbt_valid_to is not null
        and dbt_valid_to > '2024-03-29 20:42:18.039'