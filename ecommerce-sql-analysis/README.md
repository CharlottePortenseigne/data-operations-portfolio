# 📊 E-commerce Funnel & User Behavior Analysis (SQL)

## 🚀 Project Summary

This project analyzes user behavior in an e-commerce dataset to understand how users move through the purchase journey and where conversion is lost.

👉 Key insight: despite 3,946 users viewing products, only 144 complete a purchase (3.4% conversion rate), highlighting a strong gap between engagement and conversion.

Using SQL, this project explores funnel performance, purchase behavior, revenue trends, and session-level interaction patterns to generate actionable business insights.

---

## 🎯 Objective

The goal of this project is to:

- analyze the e-commerce conversion funnel
- identify major drop-off points
- understand how user behavior relates to purchasing
- evaluate revenue performance
- connect data insights to business, marketing, and customer journey decisions

---

## 🗂️ Dataset

The dataset used in this project is stored in `ecommerce_sample.csv`.

It comes from Kaggle and contains anonymized e-commerce interaction data, including:

- `event_time`
- `event_type` (`view`, `cart`, `purchase`, `remove_from_cart`)
- `product_id`
- `category_code`
- `brand`
- `price`
- `user_id`
- `user_session`

While this is sample data rather than production data, it provides a realistic environment for analyzing user behavior and conversion patterns.

---

## 🛠️ Tools Used

- SQL (SQLite)
- CSV dataset
- GitHub

---

## 📁 Repository Structure

- `ecommerce_sample.csv` → dataset used for the analysis  
- `queries.sql` → SQL queries used to explore funnel, behavior, and revenue  
- `insights.md` → detailed insights and business interpretation  
- `README.md` → project documentation  

---

## 📊 Key Metrics

### Funnel Performance
- Users who viewed products: **3,946**
- Users who added to cart: **948** (**24% conversion**)
- Users who completed a purchase: **144** (**15.2% from cart**)
- Overall conversion rate: **3.4%**

### Revenue
- Total revenue: **8,361.89**

### Revenue by Month
- 2019-10 → **2,425.44**
- 2019-11 → **1,795.85**
- 2020-01 → **1,093.84**
- 2020-02 → **1,264.07**

👉 This means that **only ~1 in 27 users converts**, despite consistent user activity.

---

## 🔍 Key Insights

### 🧭 Funnel Performance
Out of 3,946 users who view products, only 948 add items to cart and 144 complete a purchase.

👉 This represents:
- ~76% drop-off from view → cart  
- ~85% drop-off from cart → purchase  

👉 This shows that user intent decreases significantly at each stage of the funnel.

---

### 👤 User Behavior
Session-level analysis shows that sessions with **1 interaction do not convert**, while sessions with **3–4 interactions show the highest conversion rates**.

👉 This indicates that users require multiple touchpoints before purchasing.

---

### 💰 Revenue & Conversion
Total revenue is **8,361.89**, generated from only **144 purchases**.

👉 Average revenue per purchase is relatively high, meaning:
- each conversion has strong value  
- improving conversion rate could significantly increase revenue  

---

### 🏷️ Brand & Product Patterns
A small number of brands (e.g., Irisk, Runail) account for a large share of purchases.

👉 This suggests that:
- users rely on familiar or trusted brands  
- brand perception plays a role in conversion  

---

### 🛒 Cart Friction
With 948 users adding items to cart but only 144 completing a purchase:

👉 ~804 users abandon before purchase  

👉 This indicates strong hesitation at the final stage of the funnel.

---

### ⏱️ Time-Based Trends
Revenue decreases from **2,425.44 in October** to **1,093.84 in January**, before slightly recovering.

👉 This suggests fluctuations in performance rather than consistent growth.

---

## 🧠 Behavioral Interpretation

Conversion reflects a decision-making process where users:
- explore products  
- compare options  
- hesitate before committing  

👉 The drop from 3,946 viewers to 144 buyers suggests that most users do not reach sufficient confidence to purchase.

---

## 🤝 CRM & Customer Journey Perspective

Users who:
- view products  
- add items to cart  
- interact multiple times  

represent strong purchase intent, even if they do not convert immediately.

👉 With 804 abandoned cart users, there is significant opportunity for:
- retargeting  
- cart recovery  
- follow-up engagement  

---

## 🧠 Personal Approach

My approach combines:

- SQL-based data analysis  
- marketing and e-commerce reasoning  
- CRM and customer journey thinking  
- behavioral interpretation  

With a background in linguistics and data science, I interpret user actions not only as data points, but as signals of:
- decision-making  
- perception of value  
- hesitation and trust  

---

## 💡 Strategic Recommendations

### Funnel Optimization
- Reduce drop-off between cart (948 users) and purchase (144 users)  
- Improve clarity and reassurance at checkout  

---

### User Engagement
- Encourage multiple interactions (3–4 interactions correlate with higher conversion)  
- Improve product visibility and navigation  

---

### CRM Opportunities
- Target the ~804 users who abandon carts  
- Retarget engaged users  
- Build repeated touchpoints before purchase  

---

## 📁 Additional Analysis

👉 See `insights.md` for detailed insights and deeper interpretation.

---

## 💎 Final Thought

Conversion is not driven by a single factor.

The gap between **3,946 product viewers and 144 buyers** shows that conversion depends on:
- user intent  
- perception of value  
- interaction depth  
- confidence at the moment of purchase  

👉 Improving conversion requires understanding how users think, not just what they click.
