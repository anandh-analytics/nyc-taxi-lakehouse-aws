-- GOLD (ANALYTICS READY) — Cleaned, bounded dataset in S3 gold/

CREATE TABLE IF NOT EXISTS nyc_taxi_db.yellow_taxi_gold_table
WITH (
    format = 'PARQUET',
    write_compression = 'SNAPPY',
    partitioned_by = ARRAY['pickup_date'],
    external_location = 's3://anandh-analytics-platform/gold/nyc_taxi/yellow/'
) AS
SELECT
    vendorid,
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    date(tpep_pickup_datetime) AS pickup_date,
    hour(tpep_pickup_datetime) AS pickup_hour,
    pulocationid,
    dolocationid,
    CAST(passenger_count AS INTEGER) AS passenger_count,
    trip_distance,
    payment_type,
    total_amount
FROM nyc_taxi_db.yellow_taxi_curated
WHERE total_amount > 0 AND total_amount <= 500
  AND trip_distance > 0 AND trip_distance <= 100;

-- Gold validation
SELECT
    COUNT(*) AS rows,
    MIN(pickup_date) AS min_date,
    MAX(pickup_date) AS max_date
FROM nyc_taxi_db.yellow_taxi_gold_table;
