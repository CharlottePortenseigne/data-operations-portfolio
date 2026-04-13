# E-commerce Funnel & Customer Behavior Analysis (SQL)

## Objective
Analyze customer behavior across an e-commerce dataset to understand the conversion funnel and identify drop-off points using SQL.

## Tools
- SQL
- SQLite Online
- CSV dataset
- 
## Dataset
Sample dataset built from 5 months of e-commerce data, with 5,000 rows selected per month (approximately 25,000 rows total). Sample of e-commerce events data including:
- event_time
- event_type
- product_id
- category_code
- brand
- price
- user_id
- user_session

## Key Questions
- How many users view, cart, and purchase?
- What is the overall conversion rate?
- Where do users drop off in the purchase journey?
- Which categories generate the most revenue?
- Which products are purchased most often?

## Analysis Performed
- Count of event types
- Conversion rate calculation
- Revenue calculation
- Top purchased products
- Top purchased categories

## Key Results
- Conversion rate: ~3.4%
- Total revenue: 218,830.66
- Significant drop-off between views and purchases
- High cart removal activy suggests user hesitation

## Key Insights
- The overall conversion rate is low despite high user activity.
- A large number of users browse products without completing purchases.
- Product demand is distibuted across multiple products rather than dominated by a single bestseller.
- Some categories generate a disproportionate share of revenue. 

## Files
-'ecommerce_sample.csv' :  ecommerce dataset
- `queries.sql`: SQL queries used for the analysis
- `insights.txt`: summary of results and insights
