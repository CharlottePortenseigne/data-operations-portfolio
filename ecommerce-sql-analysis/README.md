# 📊 E-commerce Funnel & User Behavior Analysis (SQL)

---

## 🚀 Project Summary

This project analyzes user behavior across an e-commerce funnel to understand how engagement translates into conversion — and where it breaks.

👉 Key finding:

- **3,946 users viewed products**
- **948 users added items to cart (24.02%)**
- **144 users generated purchase events (3.44% overall conversion)**

Despite strong user activity, conversion remains low, revealing a **structural gap between intent and purchase**.

This project complements my Sales & Marketing analysis by focusing on **behavior, decision-making, and conversion dynamics**, rather than pricing and profitability.

---

## 📌 Business Context

In e-commerce, revenue is not driven by traffic alone.

Users move through multiple stages:
- exploration (view)
- evaluation (cart)
- decision (purchase)

At each stage, users reassess value, trust, and risk.

👉 This project investigates how user interactions translate into purchase — and where confidence breaks.

---

## 🎯 Objectives

- Analyze funnel performance (view → cart → purchase)
- Identify major drop-off points
- Detect behavioral signals of hesitation
- Evaluate revenue generation
- Connect user behavior to CRM and business strategy

---

## 📊 Data Overview

Dataset: Kaggle e-commerce event dataset

Total activity:
- **4,190 unique users**
- **5,898 unique sessions**
- **24,000+ total events**

Key columns:
- `event_type` (view, cart, purchase, remove_from_cart)
- `user_id`
- `user_session`
- `product_id`
- `brand`
- `price`

---

## 📊 Key Metrics

### Funnel Performance

- Viewers: **3,946**
- Cart users: **948**
- Purchasing users: **144**

Conversion rates:
- View → Cart: **24.02%**
- Cart → Purchase: **15.19%**
- Overall conversion: **3.44%**

Drop-offs:
- View → Cart: **75.98%**
- Cart → Purchase: **84.81%**

---

### Revenue Performance

- Total revenue: **8,361.89**
- Total purchase events: **1,836**
- Average price per purchase event: **4.55**

👉 Revenue is generated through **many low-value transactions**, not high-value purchases.

---

### Revenue by Month

- 2019-10 → **2,425.44** (537 purchases)
- 2019-11 → **1,795.85** (466 purchases)
- 2019-12 → **1,782.69** (403 purchases)
- 2020-01 → **1,093.84** (219 purchases)
- 2020-02 → **1,264.07** (211 purchases)

👉 Revenue declines over time, with slight recovery in February.

---

### Cart Friction

- Remove-from-cart events: **4,690**
- Users removing items: **529**
- Remove-from-cart rate: **55.80% of cart users**
- Users who carted but never purchased: **825**

👉 More than half of cart users show hesitation.

---

### Session Behavior

- Avg events (non-purchasing sessions): **3.50**
- Avg events (purchasing sessions): **33.37**

Conversion by engagement:
- 1 interaction → **0%**
- 2 interactions → **0.20%**
- 3–4 interactions → **2.10%**
- 5+ interactions → **13.80%**

👉 Conversion increases significantly with interaction depth.

---

## 🔍 Key Insights

### 📊 1. Funnel Breakdown

The funnel shows a steep decline at every stage:

- Only **24.02%** of users move from view to cart  
- Only **15.19%** of cart users purchase  
- Final conversion is only **3.44%**

👉 The main issue is not traffic — it is **conversion efficiency**.

---

### 🛒 2. Cart is the Critical Friction Point

- **825 users** show clear purchase intent (cart) but do not convert  
- **55.80%** of cart users remove items  

👉 This indicates:
- hesitation
- price sensitivity
- lack of trust or clarity

---

### 👤 3. Engagement Drives Conversion

Users who purchase behave very differently:

- Non-buyers → **3.5 interactions**
- Buyers → **33.37 interactions**

👉 Conversion is not immediate — it is built through repeated exposure and interaction.

---

### 💰 4. Revenue is Highly Concentrated

- Only **144 users** generate revenue
- Total revenue: **8,361.89**

👉 A very small segment drives business performance.

---

### 🏷️ 5. Brand Trust Influences Conversion

Top brands:
- **Runail → 700.25 revenue**
- **Irisk → 649.56 revenue**

👉 Strong brands convert better, suggesting trust plays a key role in decision-making.

---

## ⚠️ Data & Methodology Notes

This is an **event-based dataset**, not a transactional system.

Important clarifications:
- A `purchase` = purchase event, not necessarily a unique order
- **4.55** = average price per purchase event (not average order value per user)
- Users may generate multiple purchase events
- Category data is incomplete → limited category insights

---

## 🧠 Behavioral Interpretation (My Approach)

This project reflects my approach to data:

👉 I analyze user actions not only as metrics, but as **signals of cognition and decision-making**.

User journey can be interpreted as:

- **View → Exploration (information gathering)**
- **Cart → Evaluation (comparison, hesitation)**
- **Purchase → Decision (confidence threshold reached)**

With a background in linguistics and NLP, I approach behavior as:
- intent signals
- decision patterns
- value perception

👉 The funnel becomes a **semantic journey**, not just a numerical one.

---

## 🤝 CRM & Customer Journey Perspective

High-intent users who do not convert represent the biggest opportunity:

- cart abandoners (**825 users**)
- users removing items (**529 users**)
- high-interaction non-buyers

👉 These users should be targeted with:
- cart recovery flows
- retargeting campaigns
- trust-building messaging

---

## 💡 Strategic Recommendations

### Funnel Optimization
- Reduce friction at checkout
- Improve clarity (pricing, delivery, trust signals)

### User Engagement
- Encourage repeated interaction
- Improve product discovery

### CRM Strategy
- Target high-intent users
- Build multi-touch journeys
- Leverage behavioral signals

---

## 📁 Project Structure
ecommerce-sql-analysis/
├── ecommerce_sample.csv
├── queries.sql
├── README.md
└── insights.md

---

## 💎 Final Thought

The gap between **3,946 users and 144 buyers** shows that conversion is not a traffic issue.

👉 It is a **behavioral, cognitive, and trust-driven challenge**.

Understanding how users think — not just what they do — is key to improving performance.

---
