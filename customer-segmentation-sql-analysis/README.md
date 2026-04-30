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
customer-segmentation-sql/\
│ \
├── queries.sql \
├── ecommerce_sample.csv \
├── README.md \
├── insights.md

---

## 🧩 Tools Used

- SQL (SQLite)
- Data analysis & aggregation
- Business & marketing interpretation

---

## 💬 Personal Insight

With a background in linguistics and data annotation, this project goes beyond numbers.

It highlights how **user behavior patterns**, like:
- hesitation before purchase
- inconsistent engagement
- fragmented sessions

…can be interpreted similarly to **language patterns**:
→ signals, intent, and decision-making structures.

This bridges **data analysis + user psychology + computational linguistics**.

---
