{{
  config(
    materialized='view'
  )
}}

WITH cte AS (
    SELECT 
        *,
        CONVERT_TIMEZONE('Europe/Madrid', created_at)::TIMESTAMP_NTZ as created_at_uct,
        CONVERT_TIMEZONE('Europe/Madrid', _fivetran_synced)::TIMESTAMP_NTZ as _fivetran_synced_UTC
        
    FROM  {{ source('sql_server_dbo', 'events') }}
)

SELECT 
    event_id,
    event_type,
    user_id,
    product_id,
    session_id,
    created_at_uct,
    order_id,
    _fivetran_deleted,
    _fivetran_synced_UTC
FROM cte

