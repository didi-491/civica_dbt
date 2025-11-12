{{
  config(
    materialized='view',
    alias='state'
  )
}}


SELECT DISTINCT
    md5(lower(replace(trim(replace(state, '-', '_')), ' ', '_'))) as state_id
    , zipcode
    , state
FROM  {{ source('sql_server_dbo', 'addresses') }}