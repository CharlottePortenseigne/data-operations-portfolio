# 📊 Customer Segmentation & Revenue Analysis (SQL)

## 🚀 Project Summary

This project analyzes customer purchase behavior to uncover how revenue is distributed across users and identify high-value segments.

👉 Key finding:  
Revenue is highly concentrated among a small number of users, revealing strong inequality in customer value.

This highlights a critical opportunity to shift from volume-based growth to **value-based customer strategy**.

---

## 📌 Business Context

In e-commerce, not all customers contribute equally to revenue.

Understanding:
- Who drives revenue
- How value is distributed
- Where growth opportunities exist

…is essential for:
- CRM strategy
- Marketing targeting
- Profitability optimization

---

## 🎯 Objectives

- Identify high-value vs low-value customers
- Measure revenue concentration
- Analyze purchase behavior distribution
- Support CRM and retention strategies
- Translate data into actionable business insights

---

## 📊 Data Overview

- Dataset: E-commerce events dataset (Kaggle)
- Total sessions: ~5,898
- Purchase events: 145
- Purchasing users: 144

### Key fields:
- `user_id`
- `event_type`
- `price`
- `brand`
- `category_code`
- `user_session`

---

## 🧹 Data Preparation

- Filtered only `purchase` events
- Aggregated revenue per user
- Cast `price` as numeric
- Created customer-level dataset (`user_revenue`)

---

## 📈 Key Metrics

- Total Revenue: ~$218,830
- Total Purchasing Users: 144
- Average Revenue per User: ~$4.55 (per purchase context)

---

## 🔍 Analysis

### 1. Revenue Distribution

- Top 10 users generate a significant share of total revenue
- Majority of users contribute minimal revenue

👉 Strong **Pareto distribution effect (80/20-like dynamic)**

---

### 2. Customer Segmentation

Customers segmented based on total spend:

- **High-value:** 1 user  
- **Mid-value:** 18 users  
- **Low-value:** 125 users  

👉 Majority of users are low-value

---

### 3. Revenue by Segment

- Low-value: ~$5,250  
- Mid-value: ~$2,739  
- High-value: ~$371  

👉 Revenue is not evenly distributed, but also not dominated by many high spenders → indicates **weak monetization depth**

---

### 4. Behavioral Insight

- High drop-off between browsing and purchasing (see Funnel project)
- Low repeat purchasing behavior
- Weak customer lifetime value development

---

## 🧠 Business Insights

### 💡 Insight 1 — Revenue Concentration Risk
Revenue depends on a very small subset of users.

👉 Risk:
- Revenue instability
- Over-reliance on few customers

---

### 💡 Insight 2 — Untapped Mid-Value Segment
Mid-value users represent the **best growth opportunity**.

👉 Why:
- Already engaged
- Easier to convert than low-value users

---

### 💡 Insight 3 — Weak Customer Value Expansion
Most users stay low-value.

👉 Indicates:
- Poor retention strategy
- Weak upsell / cross-sell
- Limited personalization

---

## 🎯 Recommendations

### 1. CRM Segmentation Strategy
- Separate High / Mid / Low value users
- Build targeted campaigns per segment

---

### 2. Focus on Mid-Value Users
- Personalized offers
- Loyalty programs
- Retargeting campaigns

---

### 3. Increase Customer Lifetime Value (CLV)
- Cross-sell / upsell
- Email automation
- Behavioral targeting

---

### 4. Improve Conversion Funnel
(Link with Funnel project)

- Reduce friction between cart → purchase
- Improve pricing strategy
- Optimize product positioning

---

## 🔗 Project Structure









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

customer-segmentation-sql-analysis/

    |--- queries-customer-segmentations.sql
  
    |--- insights.md
  
    |--- README.md
  
    |--- ecommerce_sample.csv

---

# 🚀 Final Conclusion

This analysis reveals a clear pattern:

> Revenue is driven by many users buying frequently, not by a few high spenders.

👉 The real growth lever is:
- Retention  
- Frequency  
- Behavioral engagement  
