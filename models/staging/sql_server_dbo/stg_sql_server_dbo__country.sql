{{
  config(
    materialized='view',
    alias='country'
  )
}}


SELECT DISTINCT
    md5(lower(replace(trim(replace(country, '-', '_')), ' ', '_'))) as country_id
    , md5(lower(replace(trim(replace(state, '-', '_')), ' ', '_'))) as state_id
    , country
    , state
FROM  {{ source('sql_server_dbo', 'addresses') }}