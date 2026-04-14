# Customer Segmentation & Revenue Analysis (SQL)

## Obejctive
Analyze customer purchase behavior to identify high value users, understand spending patterns, and evaluate how revenue is distributed across different customer segments.

## Tools
- SQL (SQLite Online)
- CSV dataset

## Dataset
Sample of e-commerceevent data focused on purchase activity:
- event_time
- event_type
- product_id
- category_code
- brand
- price
- user_id
- user_session

## Key Questions
- Which users spend make the most purchases?
- Which users spend the most?
- What is the average purchase value?
- How can customer be segmented based on their spending?
- How is revenue distributed across customer segments?

## Key Metrics
- total purchasing users: **144**
- Average purchase value: **4.55**

### Customer Segmentation
- High Value: **1 user**
- Medium Value: **18 users**
- Low Value: **125 users**

### Revenue by Segment
- Low Value: **5,250.53**
- Medium Value: **2,739.52**
- High Value: **371.84**

## Key Findings
- The majority of customers (125 out of 144) belong to the low-value segment, representing approximately 87% of purchasing users.
- Only one user qualifies as high-value, indicating a very limited presence of top customers.
- Revenue is primarily driven by a large number of low-value users rather than a small group of high spenders.
- The medium-value segment contributes a significant portion of total revenue despite representing a smaller group of users.
- The average purchase value is relatively low (4.55), suggesting that most transactions are small.
- Customer spending is widely distributed, with no strong concentration among high-value users.

## Project Structure
- ecommerce_sample.csv -> dataset
- queries_customer_segmentation.sql -> SQL queries
- insights.txt -> detailed insights

## Conclusion
This analysis shows that revenue is driven by a high volume of low-value customers rather than a small number of high-value users. 
The results highlight opportunities for increasing customer value through retention strategies, upselling, and improving average purchase size.
