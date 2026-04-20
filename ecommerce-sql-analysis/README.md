# 📊 E-commerce Funnel & User Behavior Analysis (SQL)

## 🚀 Project Summary

This project analyzes user behavior in an e-commerce dataset to understand how users move through the purchase journey and where conversion is lost.

👉 Key insight: despite 3,946 users viewing products, only 144 complete a purchase (3.4% conversion rate), highlighting a strong gap between engagement and conversion.

This project complements my Sales & Marketing analysis by focusing on user behavior and conversion dynamics rather than pricing and profitability.

---

## 📌 Business Context

Understanding conversion is critical in e-commerce.

Even with strong traffic, revenue remains limited if users do not complete purchases.

This project explores how user interactions translate (or fail to translate) into actual conversion.

---

## 🎯 Objectives

- Analyze the conversion funnel  
- Identify major drop-off points  
- Understand user behavior patterns  
- Evaluate revenue performance  
- Connect data insights to business and customer journey decisions  

---

## 🗂️ Dataset

The dataset comes from Kaggle and includes:

- event_time  
- event_type (view, cart, purchase, remove_from_cart)  
- product_id  
- category_code  
- brand  
- price  
- user_id  
- user_session  

---

## 📊 Key Metrics

### Funnel Performance
- Product viewers: **3,946**
- Add to cart: **948** (**24% conversion**)
- Purchases: **144** (**15.2% from cart**)
- Overall conversion rate: **3.4%**

### Revenue
- Total revenue: **8,361.89**

### Revenue by Month
- 2019-10 → **2,425.44**
- 2019-11 → **1,795.85**
- 2020-01 → **1,093.84**
- 2020-02 → **1,264.07**

---

## 🔍 Key Insights

### 📊 Funnel Performance
There are major drop-offs at each stage:

- ~76% drop from view → cart  
- ~85% drop from cart → purchase  

👉 Only a small proportion of users complete the full journey.

---

### 👤 User Behavior
Sessions with more interactions show higher conversion.

👉 Users typically:
- explore  
- compare  
- return  

before purchasing.

---

### 💰 Revenue Efficiency
Revenue (8,361.89) is generated from only 144 purchases.

👉 This means each conversion has significant value.

---

### 🏷️ Brand Influence
A small number of brands dominate purchase activity.

👉 Suggests that trust and familiarity influence decisions.

---

### 🛒 Cart Friction
- 948 users add to cart  
- only 144 purchase  

👉 ~804 users drop before completing purchase.

---

### ⏱️ Time Trends
Revenue fluctuates without consistent growth.

👉 Suggests variability in performance over time.

---

## ⚠️ Core Business Diagnosis

The analysis reveals a clear gap between user activity and conversion:

- 3,946 users view products  
- only 144 complete a purchase  

👉 The business faces an **intent-to-conversion gap**, where users engage but do not reach sufficient confidence to purchase.

---

## 🧠 Behavioral Interpretation

Conversion reflects a multi-step decision-making process.

Users:
- explore products  
- compare options  
- hesitate before committing  

👉 The large drop-off indicates that most users do not reach sufficient confidence to purchase.

---

## 🤝 CRM & Customer Journey Perspective

Non-converting users still represent strong intent signals.

With ~804 abandoned cart users, there is significant opportunity for:

- retargeting  
- cart recovery  
- follow-up engagement  

---

## 🧠 Personal Approach (Data × Behavior × CRM)

This project reflects my approach to combining:

- data analysis (SQL)  
- marketing thinking  
- customer behavior understanding  

With a background in linguistics, I analyze user actions not only as data points, but as signals of:

- decision-making  
- perception of value  
- hesitation and trust  

---

## 💡 Strategic Recommendations

### Funnel Optimization
- Reduce drop-off between cart and purchase  
- Improve clarity at checkout  

---

### User Engagement
- Encourage multiple interactions  
- Improve product visibility  

---

### CRM Strategy
- Target ~804 cart abandoners  
- Retarget engaged users  
- Build trust through repeated touchpoints  

---

## 📁 Additional Analysis

👉 See `insights.md` for detailed analysis.

---

## 💎 Final Thought

The gap between **3,946 users and 144 buyers** shows that conversion is not only a technical issue.

👉 It is a behavioral and perception challenge.

Improving conversion requires understanding how users think, not just what they click.
