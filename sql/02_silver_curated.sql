-- SILVER (CURATED) — Enforced schema + partitioned Parquet output (CTAS)

CREATE TABLE IF NOT EXISTS nyc_taxi_db.yellow_taxi_curated
WITH (
    format = 'PARQUET',
    parquet_compression = 'SNAPPY',
    partitioned_by = ARRAY['year','month'],
    external_location = 's3://anandh-analytics-platform/silver/nyc_taxi/yellow/'
) AS
SELECT
    CAST(vendorid AS BIGINT) AS vendorid,
    tpep_pickup_datetime,
    tpep_dropoff_datetime,

    -- keep as-is (Parquet is DOUBLE); enforce later in Gold if you want strict INTs
    passenger_count,
    trip_distance,
    ratecodeid,

    store_and_fwd_flag,
    pulocationid,
    dolocationid,
    payment_type,

    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    total_amount,
    congestion_surcharge,
    airport_fee,

    year,
    month
FROM nyc_taxi_db.yellow_taxi_trips
WHERE year = 2023 AND month = 1;

-- Optional analytics-friendly view
CREATE OR REPLACE VIEW nyc_taxi_db.yellow_taxi_analytics AS
SELECT
    vendorid,
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    date(tpep_pickup_datetime) AS pickup_date,
    hour(tpep_pickup_datetime) AS pickup_hour,
    passenger_count,
    trip_distance,
    ratecodeid,
    payment_type,
    fare_amount,
    tip_amount,
    tolls_amount,
    total_amount,
    congestion_surcharge,
    airport_fee,
    year,
    month
FROM nyc_taxi_db.yellow_taxi_curated;

-- test
SELECT COUNT(*) AS curated_rows
FROM nyc_taxi_db.yellow_taxi_curated;

SELECT *
FROM nyc_taxi_db.yellow_taxi_analytics
LIMIT 10;
