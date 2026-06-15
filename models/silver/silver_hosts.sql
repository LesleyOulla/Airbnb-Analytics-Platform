{{ config(materialized='table') }}

SELECT
    id AS host_id,
    name AS host_name,
    CAST(is_superhost AS BOOLEAN) AS is_superhost,
    created_at,
    updated_at
FROM {{ ref('bronze_hosts') }}