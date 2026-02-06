## Data quality rules (Gold)
- trip_distance: (0, 100]
- total_amount: (0, 500]
- passenger_count: cast to integer in Gold

## Why
- Removes corrupt/rare extreme values that distort averages and volatility.
- Produces stable aggregates suitable for business KPIs and scenario simulation.
