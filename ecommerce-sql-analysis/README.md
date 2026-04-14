# E-commerce Funnel & User Behavior Analysis (SQL)

## Objective
Analyze user behavior across an e-commerce dataset to understand the conversion funnel, identify drop-off points, and evaluate revenue performance.

## Tools
- SQL (SQLite Online)
- CSV dataset

## Dataset
Sample of e-commerce event data including user interactions:
- event_time
- event_type (view, cart, purchase, remove_from_cart)
- product_id
- category_code
- brand
- price
- user_id
- user_session

## Key Questions
- What is the overall conversion rate?
- Where do users drop off in the funnel?
- How does user behavior impact purchases?
- Which categories and brands drive purchases?
- How does revenue evolve over time?

## Key Metrics
### Funnel Performance
- Users viewd products: **3,946**
- Users added to cart: **948** (**24% conversion**)
- Users completed purchase: **144** (**15.2% conversion**)
- Overall Conversion rate: **3.4%**

### Revenue Analysis
- Total revenue: **8,361.89**

### Revenue by Month
- 2019-10: **2,425.44**
- 2019-11: **1,795.85**
- 2020-01: **1,093.84**
- 2020-02: **1,264.07**

## Key Frindings
- The overall conversion rate is low, with only a small proportion of users completing a purchase.
- Significant drop-offs occur at each stage of the funnel, especially between cart and purchase.
- Only 24% of users who view products add them to cart, indicating potential issues with engagement or pricing.
- Cart abandonment behavior is observed, suggesting hesitation during the purchase process.
- Revenue peaked in October and declined in subsequent months, indicating possible seasonality or reduced user activity.
- A small number of brands (e.g., Irisk, Runail) dominate purchases, suggesting strong brand preference.
- Purchases are distributed across multiple products, with no dominant best-seller.
- Some categories contribute minimally to total revenue, indicating opportunities for optimization.

## Project Structure
-'ecommerce_sample.csv' -> dataset
- `queries.sql` -> SQL queries
- `insights.txt`-> detailed insights

## Conclusion
This analysis highlights inefficiencies in the e-commerce funnel, including low conversion rates and significant drop-offs. The results suggest opportunities to improve user experience, optimize product offering, and increase revenue through better funnel performance.
