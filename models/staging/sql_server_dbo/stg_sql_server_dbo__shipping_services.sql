{{
  config(
    materialized='view', 
    alias='shipping_services'
  )
}}

SELECT DISTINCT
    md5(lower(replace(trim(replace(shipping_service, '-', '_')), ' ', '_'))) as shipping_service_id,
    case 
        when shipping_service = '' then 'no shipping service selected'
        else lower(replace(trim(replace(shipping_service, '-', '_')), ' ', '_')) 
    end as shipping_service_name
FROM  {{ source('sql_server_dbo', 'orders') }}


