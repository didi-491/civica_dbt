{{
  config(
    materialized='view'
  )
}}

WITH cte AS (
    SELECT 
        *,
        discount as discount_dollar,
        lower(replace(trim(replace(promo_id, '-', '_')), ' ', '_')) as promo_name
        CONVERT_TIMEZONE('Europe/Madrid', _fivetran_synced)::TIMESTAMP_NTZ as _fivetran_synced_UTC
    FROM  {{ source('sql_server_dbo', 'promos') }}
)

SELECT 
    md5(promo_name) as promo_id, 
    promo_name,
    discount_dollar,
    status,
    _fivetran_deleted,
    _fivetran_synced_UTC
FROM cte
UNION
SELECT 
    md5('no_promo') as promo_id,
    'no_promo' as promo_name,
    0 as discount,
    'inactive' as status,
    null as _fivetran_deleted,
    CONVERT_TIMEZONE('Europe/Madrid', CURRENT_TIMESTAMP())::TIMESTAMP_NTZ as _fivetran_synced_UTC
