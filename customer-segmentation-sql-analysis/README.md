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






# 📊 Customer Segmentation & Revenue Analysis (SQL)

## 🚀 Project Summary

In e-commerce, it’s often assumed that revenue is driven by a small group of high-value customers.

👉 This analysis reveals a different reality.

Using transaction-level data, this project shows that:

> Revenue is not concentrated among top spenders —  
> it is distributed across a large base of low-value customers, sustained by strong repeat behavior.

This project combines **data analysis, customer behavior, and marketing thinking** to uncover what truly drives revenue.

---

## 📌 Business Context

Once a user converts, the key question becomes:

👉 *Who actually generates revenue over time?*

This project focuses on:

- Customer value distribution  
- Repeat vs one-time behavior  
- Purchase frequency  
- Revenue concentration  

➡️ It complements funnel analysis by shifting from **conversion → retention and value**

---

## 🎯 Objectives

- Identify high-value vs low-value customers  
- Understand how revenue is distributed  
- Analyze repeat purchase behavior  
- Measure customer engagement through frequency  
- Translate data into business strategy  

---

## 📊 Dataset Overview

- Total rows: **25,000**
- Purchase events: **1,836**
- Purchasing users: **144**
- Total revenue: **$8,361.89**

### Key Variables

- `user_id` → customer identity  
- `price` → transaction value  
- `event_time` → behavioral timeline  

---

## ⚙️ Data Quality & Constraints

The dataset contains important limitations:

- `category_code` → ~98% missing  
- `brand` → ~43% missing  

👉 Product-level analysis is unreliable  

➡️ The analysis focuses on **behavioral patterns instead of product performance**

---

# 📈 From Transactions to Behavior

## 💰 Step 1 — Understanding Purchase Value

| Metric | Value |
|------|------|
| Average Purchase | $4.55 |
| Median Purchase | $2.62 |

👉 The difference between average and median indicates a **skewed distribution**:

- Many small purchases  
- Few higher transactions  

➡️ This is a **low-ticket, high-frequency model**

---

## 👤 Step 2 — Customer Value Segmentation

| Segment | Users | % Users | Revenue | % Revenue |
|--------|------|--------|--------|----------|
| Low Value | 125 | 86.81% | $5,250.53 | 62.79% |
| Medium Value | 18 | 12.50% | $2,739.52 | 32.76% |
| High Value | 1 | 0.69% | $371.84 | 4.45% |

👉 Key insight:

- The vast majority of users spend very little individually  
- High-value customers are extremely rare  

➡️ Revenue is **distributed across many users**, not concentrated

---

## 🔁 Step 3 — Repeat Behavior

| Type | Users | % Users | Revenue | % Revenue |
|------|------|--------|--------|----------|
| Repeat | 133 | 92.36% | $7,972.06 | 95.34% |
| One-time | 11 | 7.64% | $389.83 | 4.66% |

👉 Critical observation:

> Almost all revenue comes from repeat customers

➡️ The business is **retention-driven, not acquisition-driven**

---

## 🔄 Step 4 — Customer Engagement

| Segment | Users | % |
|---------|------|---|
| Frequent | 104 | 72.22% |
| Occasional | 29 | 20.14% |
| One-time | 11 | 7.64% |

👉 Interpretation:

- Most users are highly engaged  
- Customers don’t just return — they **develop behavioral patterns**

➡️ Indicates strong engagement and habit formation

---

# 🧠 Key Insights

## 1. Revenue is distributed, not concentrated

- 86.8% of users generate 62.8% of revenue  

➡️ No dependency on “whales”  
➡️ Growth requires scaling the user base  

---

## 2. Retention is the main revenue driver

- 92% repeat users  
- 95% of revenue from repeat customers  

➡️ Retention = core business engine  

---

## 3. Frequency matters more than spending

Users don’t spend more — they buy more often  

➡️ Frequency > Average Order Value  

---

## 4. Customer behavior follows patterns

With a background in computational linguistics, I interpret:

- Purchases = signals  
- Frequency = repetition  
- Users = behavioral sequences  

👉 Similar to language, customer behavior forms structured patterns

---

# 💡 Business Recommendations

## 🎯 Focus on retention
- CRM campaigns  
- Lifecycle messaging  
- Re-engagement flows  

## 🔄 Increase purchase frequency
- Bundles / subscriptions  
- Habit-forming UX  

## 📈 Upgrade low-value users
- Personalized offers  
- Targeted upsell  

---

# 🧠 Personal Approach

This project reflects my experience in:

- **Computational linguistics → pattern recognition**
- **Customer service → understanding behavior**
- **Marketing → linking behavior to value**
- **Data operations → data quality awareness**

👉 I approach data as a **behavioral system**, not just numbers.

---

# 📂 Project Structure
