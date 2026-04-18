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
This analysis highlights inefficiencies in the e-commerce funnel, including low conversion rates and significant drop-offs. The results suggest opportunities to improve user experience, optimize product offering, and increase revenue through better Bien sûr — voici ta version finale optimisée, cohérente avec ton dashboard Google Sheets + intégrant ta touche marketing / data / CRM / linguistique + mention Kaggle.



⸻

📊 E-commerce User Behavior & Conversion Analysis

🎯 Project Overview

This project analyzes user behavior in an e-commerce environment to understand how users interact with products and what drives (or limits) conversion.

The analysis combines:

* Data analysis (SQL)
* Marketing strategy
* CRM and user journey thinking
* Linguistic structuring of product data

👉 The goal is not only to measure performance, but to understand why users behave the way they do and identify actionable improvements.

⸻

🗂️ Dataset

The dataset used for this project was sourced from Kaggle and represents anonymized e-commerce user interaction data.

It includes:

* event_time
* event_type (view, cart, purchase)
* product_id
* category_code
* brand
* price
* user_id
* user_session

While not production data, it provides a realistic environment to simulate user behavior analysis and business decision-making.

⸻

📊 Dashboard Overview

The dashboard follows the user journey:

1. Funnel performance
2. Conversion by price
3. Time-based trends
4. Brand performance

⸻

🧭 1. Funnel Analysis

📈 Key Metrics

* Sessions: 5,898
* Product Views: 5,544
* Add to Cart: 1,122
* Purchases: 145
* View → Cart: ~20%
* Cart → Purchase: ~13%

⸻

💡 Insight

The funnel reveals two major drop-offs:

* Product View → Cart (~80%)
* Cart → Purchase (~87%)

👉 This indicates:

* weak product engagement
* strong friction at checkout

⸻

🧠 Interpretation

Conversion is not a single event, but a multi-step process.

Users need:

* engagement
* reassurance
* repeated exposure

before completing a purchase.

⸻

💰 2. Conversion Rate by Price Range

* Low: ~2.5%
* Mid: ~1.9%
* High: ~2.3%

⸻

💡 Insight

Conversion is influenced by perceived value rather than absolute price.

👉 Mid-range products underperform, suggesting unclear positioning.
👉 High-priced products can still convert if value is perceived as high.

⸻

🧠 Interpretation

User decisions are driven by perception, not just price.

⸻

⏱️ 3. User Activity vs Purchases Over Time

⸻

💡 Insight

User sessions increase over time, while purchases decrease.

👉 This reveals a misalignment between:

* traffic acquisition
* conversion performance

⸻

🧠 Interpretation

More traffic does not necessarily mean more revenue.

This suggests:

* low-quality traffic
* misaligned marketing targeting
* mismatch between expectations and product offering

⸻

🏷️ 4. Brand Performance

Conversion rates vary significantly across brands.

⸻

💡 Insight

Some brands outperform others regardless of traffic volume.

👉 This highlights the importance of:

* brand trust
* positioning
* clarity of messaging

⸻

🧠 Interpretation

Conversion is strongly influenced by perception, not just visibility.

⸻

👤 5. User Behavior Analysis

Conversion increases with the number of interactions per session.

* 1 interaction → no conversion
* 3–4 interactions → peak conversion

⸻

💡 Insight

Users require multiple touchpoints before making a purchase decision.

⸻

🧠 Interpretation

This reflects a cognitive decision-making process where users:

* explore
* compare
* validate

before committing.

⸻

🔍 6. Category & Linguistic Analysis

Product categories were simplified using linguistic structuring to improve clarity.

⸻

💡 Insight

The way products are labeled and structured directly affects user engagement.

⸻

🧠 Interpretation (Computational Linguistics)

From a linguistic perspective:

* unclear or complex labels increase cognitive load
* well-structured categories improve navigation and decision-making

👉 Language is part of the user experience.

⸻

🧠 Multidisciplinary Insights

📊 Data Analysis

Conversion must be analyzed at the session level to reflect real behavior.

* Avoid double counting
* Clean and structure data
* Use behavioral segmentation

⸻

📣 Marketing

Traffic growth does not guarantee performance.

👉 Focus should shift from:

* volume → intent-driven acquisition

⸻

💰 Sales

Low conversion but high average order value indicates strong value per transaction.

👉 Opportunity:

* convert existing traffic more effectively

⸻

🤝 Customer Experience (CX)

The checkout stage shows the highest friction.

👉 Possible issues:

* pricing perception
* hidden costs
* payment limitations
* delivery concerns

⸻

🧩 Computational Linguistics

Data structure and language influence how users process information.

👉 Better semantic structure → better engagement → better conversion

⸻

💡 Strategic Recommendations

👀 Product Engagement

* Improve product descriptions (clear, persuasive language)
* Enhance UX and navigation
* Personalize recommendations (CRM)

⸻

🛒 Checkout Optimization

* Simplify checkout flow
* Improve pricing transparency
* Offer multiple payment options
* Reduce delivery friction

⸻

🎯 Traffic Strategy

* Focus on high-intent users
* Align marketing messaging with product

⸻

🔁 CRM Optimization

* Retarget engaged users
* Recover abandoned carts
* Build trust over time

⸻

🛠️ Tools Used

* SQL (SQLite)
* Google Sheets (dashboard & visualization)
* GitHub

⸻

💎 Final Thought

This project demonstrates that conversion is not driven by a single factor, but by the alignment between user intent, product perception, user experience, and clarity of communication.

It highlights how data analysis, marketing strategy, CRM thinking, and computational linguistics can be combined to better understand and optimize user behavior in e-commerce.

⸻

🏁

👉 Cette version est :

✔ alignée avec ton dashboard
✔ cohérente
✔ stratégique
✔ différenciante

👉 = niveau top 1% portfolio

⸻

💬 Prochaine étape (très importante) :

👉 pitch entretien (2 min)
👉 ou version CV avec ce projet

👉 C’est ça qui va transformer ce projet en job 🚀







