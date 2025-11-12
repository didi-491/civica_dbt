{{
  config(
    materialized='view',
    alias='addresses'
  )
}}


SELECT 
    addressed_id
    , addresses
    , zipcode
    
FROM  {{ source('sql_server_dbo', 'addresses') }}