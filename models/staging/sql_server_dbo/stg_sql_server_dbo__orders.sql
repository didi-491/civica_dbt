{{
  config(
    materialized='view'
  )
}}

WITH cte AS (
    SELECT 

        *,
        order_total as order_total_dollar,
        order_cost as order_cost_dollar,
        shipping_cost as shipping_cost_dollar,
        md5(lower(replace(trim(replace(shipping_service, '-', '_')), ' ', '_'))) as shipping_service_id,
        ifnull(lower(replace(trim(replace(promo_id, '-', '_')), ' ', '_')), 'no_promo') as promo_name,
        CONVERT_TIMEZONE('Europe/Madrid', created_at)::TIMESTAMP_NTZ as created_at_utc,
        CONVERT_TIMEZONE('Europe/Madrid', estimated_delivery_at)::TIMESTAMP_NTZ as estimated_delivery_at_utc,
        CONVERT_TIMEZONE('Europe/Madrid', delivered_at)::TIMESTAMP_NTZ as delivered_at_utc,
        CONVERT_TIMEZONE('Europe/Madrid', _fivetran_synced)::TIMESTAMP_NTZ as _fivetran_synced_utc

    FROM  {{ source('sql_server_dbo', 'orders') }}
)

SELECT 
    order_id,
    user_id
    addressed_id,
    created_at_utc
    estimated_delivery_at_utc,
    delivered_at_utc,
    shipping_service_id,
    tracking_id,
    status,
    order_total_dollar,
    order_cost_dollar,
    shipping_cost_dollar,       
    md5(promo_name) as promo_id, 
    _fivetran_deleted,
    _fivetran_synced_utc

FROM cte