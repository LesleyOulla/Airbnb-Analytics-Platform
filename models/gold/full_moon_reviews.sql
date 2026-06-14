{{ config(materialized='table') }}

SELECT
    r.*,
    CASE
        WHEN fm.full_moon_date IS NULL THEN 'not full moon'
        ELSE 'full moon'
    END AS is_full_moon
FROM {{ ref('silver_reviews') }} r
LEFT JOIN {{ ref('seed_full_moon_dates') }} fm
    ON CAST(r.review_date AS DATE) = CAST(fm.full_moon_date AS DATE) + INTERVAL '1 day'