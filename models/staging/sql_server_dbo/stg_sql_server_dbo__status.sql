{{
  config(
    materialized='view', 
    alias='status'
  )
}}

SELECT DISTINCT
    md5(lower(replace(trim(replace(status, '-', '_')), ' ', '_'))) as status_id,
    case 
        when shipping_service = '' then 'no status selected'
        else lower(replace(trim(replace(shipping_service, '-', '_')), ' ', '_')) 
    end as status_type
FROM  {{ source('sql_server_dbo', 'orders') }}

