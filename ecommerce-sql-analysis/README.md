# 📊 E-commerce SQL Analysis: Funnel, Behavior & Conversion

## 🚀 Project Summary

This project analyzes user behavior in an e-commerce environment to identify conversion bottlenecks and understand what drives (or limits) purchases.

👉 Key insight: user activity increases over time, but conversion decreases — highlighting a misalignment between traffic acquisition and actual purchasing behavior.

The analysis combines data analysis, marketing strategy, CRM thinking, and behavioral interpretation.

---

## 🎯 Objective

- Analyze the conversion funnel  
- Identify drop-off points  
- Understand user behavior patterns  
- Evaluate revenue performance  
- Generate actionable business insights  

---

## 🗂️ Dataset

The dataset (ecommerce_sample.csv) comes from Kaggle and contains anonymized user interaction data.

Includes:
- event_time  
- event_type (view, cart, purchase)  
- product_id  
- category_code  
- brand  
- price  
- user_id  
- user_session  

---

## 📁 Repository Structure

- `ecommerce_sample.csv` → dataset  
- `queries.sql` → SQL analysis  
- `insights.md` → detailed insights  
- `README.md` → documentation  

---

## 📊 Key Metrics

- Sessions: 5,898  
- Product Views: 5,544  
- Add to Cart: 1,122  
- Purchases: 145  

- View → Cart: ~20%  
- Cart → Purchase: ~13%  
- Overall Conversion Rate: ~3.4%  

---

## 🔍 Key Insights

### 🧭 Funnel Performance
- ~80% drop-off from view → cart  
- ~87% drop-off from cart → purchase  

👉 Indicates:
- weak product engagement  
- strong friction at checkout  

---

### 💰 Price & Conversion
- Low price → ~2.5%  
- Mid price → ~1.9%  
- High price → ~2.3%  

👉 Mid-range products underperform → unclear positioning  
👉 High prices can convert → value perception matters  

---

### ⏱️ Traffic vs Conversion
User sessions increase while purchases decrease.

👉 Indicates:
- low-quality traffic  
- misaligned targeting  
- mismatch between expectations and product  

---

### 🏷️ Brand Performance
Some brands convert significantly better than others.

👉 Conversion depends on:
- trust  
- positioning  
- perceived value  

---

### 👤 User Behavior
- 1 interaction → no conversion  
- 3–4 interactions → highest conversion  

👉 Users require multiple touchpoints before purchasing  

---

## 🧠 Behavioral Interpretation

Conversion is not a single action, but a multi-step decision process.

Users:
- explore  
- compare  
- validate  
before committing.

👉 Conversion depends on perception, not just price.

---

## 🔍 Linguistic & Data Structure Insight

Product categories were simplified using linguistic structuring.

👉 Insight:
- unclear labels increase cognitive load  
- clear structure improves navigation and conversion  

👉 Language directly impacts user experience.

---

## 💡 Strategic Recommendations

### 👀 Product Engagement
- Improve product descriptions  
- Enhance UX and navigation  
- Personalize recommendations  

---

### 🛒 Checkout Optimization
- Simplify checkout flow  
- Improve pricing transparency  
- Reduce friction  

---

### 🎯 Traffic Strategy
- Focus on high-intent users  
- Align messaging with product  

---

### 🔁 CRM Optimization
- Retarget engaged users  
- Recover abandoned carts  
- Build trust over time  

---

## 🧰 Tools Used

- SQL (SQLite)  
- Google Sheets  
- GitHub  

---

## 📁 Additional Analysis

👉 See `insights.md` for detailed insights and deeper analysis.

---

## 💎 Final Thought

Conversion is driven by the alignment between:
- user intent  
- product perception  
- user experience  
- communication clarity  

This project demonstrates how data analysis, marketing strategy, CRM thinking, and computational linguistics can be combined to better understand and optimize user behavior.
