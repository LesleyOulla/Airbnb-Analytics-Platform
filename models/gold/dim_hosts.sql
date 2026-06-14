{{ config(materialized='view') }}

SELECT
    CAST(host_id AS INT) AS host_id,
    COALESCE(host_name, 'Anonymous') AS host_name,
    is_superhost,
    created_at,
    updated_at
FROM {{ ref('silver_hosts') }}