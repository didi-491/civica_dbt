{{
  config(
    materialized='view'
  )
}}

WITH cte AS (
    SELECT 
        *,
        CONVERT_TIMEZONE('Europe/Madrid', updated_at)::TIMESTAMP_NTZ as updated_at_utc
        CONVERT_TIMEZONE('Europe/Madrid', created_at)::TIMESTAMP_NTZ as created_at_utc
        CONVERT_TIMEZONE('Europe/Madrid', _fivetran_synced)::TIMESTAMP_NTZ as _fivetran_synced_utc
        
    FROM  {{ source('sql_server_dbo', 'users') }}
)

SELECT  
    a.user_id,
    addressed_id,
    created_at_utc,
    updated_at_utc,
    phone_number,
    email,
    _fivetran_deleted,
    _fivetran_synced_utc

FROM cte a
LEFT JOIN total_orders b
    ON a.user_id = b.user_id
