## S3 layout
- s3://anandh-analytics-platform/raw/nyc_taxi/yellow/ (Bronze)
- s3://anandh-analytics-platform/silver/nyc_taxi/yellow/ (Silver CTAS)
- s3://anandh-analytics-platform/gold/nyc_taxi/yellow/ (Gold CTAS)
- s3://anandh-analytics-platform/athena-results/ (Athena query results)

## Data flow
Bronze Parquet in S3 → Athena External Table (schema-on-read)  
→ Silver CTAS (enforced schema, partitioned Parquet)  
→ Gold CTAS (bounded + analytics-ready, partitioned by pickup_date)  
→ Executive views (risk + scenario simulation)

## Partitioning
- Bronze/Silver: year, month (S3 partitions)
- Gold: pickup_date (query pruning for time-based BI/reporting)
