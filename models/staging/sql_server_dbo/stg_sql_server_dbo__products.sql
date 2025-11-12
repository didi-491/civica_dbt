{{
  config(
    materialized='view',
    alias='products'
  )
}}


SELECT 
    product_id -- hay que historificar el precio con un snapshot
    , name
    , _fivetran_deleted
    , CONVERT_TIMEZONE('Europe/Madrid', _fivetran_synced)::TIMESTAMP_NTZ as _fivetran_synced_utc

FROM {{ source('sql_server_dbo','products') }}


