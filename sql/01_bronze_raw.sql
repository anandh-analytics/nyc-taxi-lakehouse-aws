-- BRONZE (RAW) — NYC Yellow Taxi in S3 (Schema-on-Read)
-- Creates an EXTERNAL table over Parquet files in S3 partitions: year/month.

CREATE EXTERNAL TABLE IF NOT EXISTS nyc_taxi_db.yellow_taxi_trips (
    vendorid BIGINT,
    tpep_pickup_datetime TIMESTAMP,
    tpep_dropoff_datetime TIMESTAMP,
    passenger_count DOUBLE,
    trip_distance DOUBLE,
    ratecodeid DOUBLE,
    store_and_fwd_flag STRING,
    pulocationid BIGINT,
    dolocationid BIGINT,
    payment_type BIGINT,
    fare_amount DOUBLE,
    extra DOUBLE,
    mta_tax DOUBLE,
    tip_amount DOUBLE,
    tolls_amount DOUBLE,
    improvement_surcharge DOUBLE,
    total_amount DOUBLE,
    congestion_surcharge DOUBLE,
    airport_fee DOUBLE
)
PARTITIONED BY (
    year INT,
    month INT
)
STORED AS PARQUET
LOCATION 's3://anandh-analytics-platform/raw/nyc_taxi/yellow/';

-- Load partitions from S3 folder structure: year=YYYY/month=MM/
MSCK REPAIR TABLE nyc_taxi_db.yellow_taxi_trips;

--test
SELECT *
FROM nyc_taxi_db.yellow_taxi_trips
WHERE year = 2023 AND month = 1
LIMIT 10;
