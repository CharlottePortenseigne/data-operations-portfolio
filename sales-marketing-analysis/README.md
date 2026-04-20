# 📊 Sales, Marketing & Revenue Performance Analysis (Google Sheets)

## 📌 Business Context
This project analyzes e-commerce sales and profitability data to better understand how revenue is generated, how marketing and sales efforts translate into performance, and where opportunities exist to improve both growth and efficiency.

The objective is to connect data insights with real-world marketing, sales, and customer experience dynamics.

---

## 📊 Data Overview
The dataset spans 5 months, with approximately 5,000 records per month (~25,000 total rows).

It includes:
- Sales and profit data  
- Product categories: Technology, Office Supplies, Furniture  
- Customer segments: Consumer, Corporate, Home Office  
- Geographic performance (Region and State)  
- Order-level data  

This structure enables both cross-sectional analysis and time-based analysis.

---

## 🧹 Data Preparation & Feature Engineering

### Data Cleaning
- Standardized date formats  
- Cleaned customer names  
- Standardized product categories and sub-categories

---

### Feature Engineering
Additional variables were created to support deeper analysis:

- Month / Year  
- Customer_Lifetime_Value (CLV)  
- Customer_Segment  
- Profit_Ratio  
- Order_Size  
- Profit_Status  

These features enable more business-oriented and behavior-driven insights.

---

### Data Validation
- Error_Check column to flag:
  - Sales ≤ 0  
  - Missing customer names  

This ensures data reliability.

---

## 📈 Key Metrics
- Total Sales: $2,297,200.86  
- Total Profit: $286,397.02  
- Profit Margin: 12.03%  
- Total Orders: 5,009  
- Average Order Value (AOV): $458.61  

---

## 🔍 Key Insights

### 💰 Revenue vs Profitability
- Strong revenue ($2.29M) vs lower profit ($286K)  
- Growth driven more by volume than margin efficiency

👉 High sales do not necessarily translate into strong business performance

---

### 💸 Discount Strategy Impact

- High discounts generate significant losses  
  → Profit: -$75,559 | Profit Ratio: -113.88%  

- Medium discounts are also unprofitable  
  → Profit: -$58,817 | Profit Ratio: -21.97%  

- Low discounts remain profitable  
  → Profit: $100,785 | Profit Ratio: 17.44%  

- No-discount orders generate the highest profitability  
  → Profit: $320,987 | Profit Ratio: 34.02%

👉 Profitability is largely driven by low or no-discount transactions

---

### 👥 Customer Segment Performance

- Medium segment drives the highest revenue ($1.29M)  
  → Profit Ratio: 11.49%  

- High-value segment generates the highest profit ($140K)  
  → Profit Ratio: 13.27%  

- Low segment contributes minimal revenue and profit

👉 Revenue is driven by mid-market customers, while profitability is more efficient in higher-value segments

---

### 💡 Key Combined Insight

The current strategy appears to rely on:
- discount-driven sales
- and mid-market customer volume

👉 However, this combination significantly limits profitability.

---

### 🌍 Market & Geographic Performance
- West and East outperform in sales  
- South and Central underperform  

👉 Suggests differences in targeting, channel effectiveness, or execution

---

### 🗺️ State-Level Observations
- Strong profitability in:
  - California
  - Massachusetts
  - Washington

- Texas shows strong revenue but weaker profitability  

---

### 📅 Time-Based Analysis
- Sales remain relatively stable across months  
- No strong short-term seasonal variation observed  

👉 Suggests consistent demand but potential lack of variation in marketing or external drivers  

---

## ⚠️ Interpretation

- The gap between revenue and profit indicates margin inefficiencies  
- Discounting strategy is a major driver of losses  
- Customer mix prioritizes volume over profitability  
- Regional differences suggest inconsistent execution  

---

## 💡 Potential Actions (to be tested)

- Reduce reliance on high and medium discount levels  
- Focus on high-value customer segments  
- Optimize pricing and positioning for low-margin categories  
- Reevaluate channel and targeting strategies  
- Strengthen customer engagement and retention efforts  

---

## 🧪 Testing Approach
- Test reducing discounts in selected categories  
- Compare performance across customer segments  
- Evaluate impact of targeting higher-value customers  
- Test retention and repeat purchase strategies  

---

## ⚖️ Business Considerations
- Reducing discounts may lower sales volume but improve profitability  
- Targeting high-value customers may reduce volume but increase margins  

---

## 🧠 Additional Perspective (CRM & Customer Experience)

From a CRM perspective, performance differences may be influenced by:
- targeting decisions  
- channel selection  
- quality of customer data  

Customer experience also plays a key role. Even without immediate conversion, a positive interaction can improve retention, engagement, and brand perception.

---

## 🧠 Personal Approach (Data, Marketing &Customer Understanding)

My approach combines dataanalysis, marketing thinking, and real-world customer experience.

From a data perspective, I focus on identifying patterns, questioning assumptions, and connecting metrics to business outcomes.

From a marketing perspective, I consider how performance is influence by:
- Campaign targeting
- channel and media choices
- product positioning
- and the alignment between customer needs and what is offered

My background in linguistics also shapes how I approach problems, particularly in understanding how messaging, structure, and clarity influence customer perception and decision-making.

Additionalyy, I apply an AI-driven mindset, approaching analysis as an iteractive process: exploring data, forming hypotheses, testing ideas, and refining conclusions.

Combined with hands-on experience in CRM and customer interactions, this allows me to bridge the gab between data insights and how marketing, sales, and customer experience actually operate in practice.


---

## 🚀 Potential Impact
Improving pricing, targeting, and customer strategy could significantly increase profitability without increasing overall sales volume.

---

## 🧰 Tools Used
- Google Sheets  
- Data visualization (dashboard & charts)  
- Data analysis

---

## 🔗 Project Access

- 📊 **Google Sheets Dashboard:** [https://docs.google.com/spreadsheets/d/1gzA6Ku7CxS1w-KYSprdfvAq9RMvU_k_YoeLQr71aItg/edit?usp=sharing]
- 💻 **GitHub Repository:** [https://github.com/CharlottePortenseigne/data-operations-portfolio.git]





# 📊 Sales, Marketing & Revenue Performance Analysis (Google Sheets)

## 📌 Business Context

This project analyzes e-commerce sales and profitability data to understand how revenue is generated, how marketing and pricing strategies impact performance, and where opportunities exist to improve both growth and efficiency.

The objective is not only to analyze data, but to connect insights to real-world marketing, customer behavior, and business strategy.

---

## 🎯 Objectives

- Analyze revenue vs profitability dynamics  
- Evaluate the impact of discount strategies  
- Identify high-value customer segments  
- Understand regional and product performance  
- Translate data insights into actionable business decisions  

---

## 📊 Data Overview

The dataset spans 5 months, with approximately 5,000 records per month (~25,000 total rows).

It includes:

- Sales and profit data  
- Product categories: Technology, Office Supplies, Furniture  
- Customer segments: Consumer, Corporate, Home Office  
- Geographic performance (Region and State)  
- Order-level data  

This structure enables both cross-sectional and time-based analysis.

---

## 🧹 Data Preparation & Feature Engineering

### Data Cleaning
- Standardized date formats  
- Cleaned customer names  
- Standardized product categories and sub-categories  

### Feature Engineering
- Month / Year  
- Customer_Lifetime_Value (CLV)  
- Customer_Segment  
- Profit_Ratio  
- Order_Size  
- Profit_Status  

These transformations allow for deeper business and behavioral analysis.

### Data Validation
- Error_Check column to flag:
  - Sales ≤ 0  
  - Missing customer names  

---

## 📈 Key Metrics

- **Total Revenue:** $2,297,200.86  
- **Total Profit:** $286,397.02  
- **Profit Margin:** 12.03%  
- **Total Orders:** 5,009  
- **Average Order Value (AOV):** $458.61  

---

## 🔍 Key Insights

### 💰 Revenue vs Profitability

Strong revenue ($2.29M) compared to lower profit ($286K), with a profit margin of 12.03%.

👉 Growth is driven by volume rather than margin efficiency.

---

### 💸 Discount Strategy Impact

Discounting is the primary driver of profitability loss:

- High discounts → **- $75,559 profit | -113.88% margin**  
- Medium discounts → **- $58,817 profit | -21.97% margin**  
- Low discounts → **$100,785 profit | 17.44% margin**  
- No discounts → **$320,987 profit | 34.02% margin**  

👉 Profitability is largely driven by low or no-discount transactions.

---

### 👥 Customer Segment Performance

- Mid-value segment → **~$1.29M revenue | 11.49% margin**  
- High-value segment → **~$140K profit | 13.27% margin**  
- Low-value segment → minimal contribution  

👉 Revenue is volume-driven, while profitability is value-driven.

---

### 🌍 Regional Performance

- West & East → highest performance  
- South & Central → underperform  

👉 Indicates differences in execution, targeting, or market conditions.

---

### 📅 Time-Based Analysis

Sales remain stable across the 5-month period.

👉 No strong seasonal variation observed.

---

## 🧠 Behavioral Interpretation

Beyond numerical performance, the data reveals clear customer behavior patterns:

- Heavy discount usage suggests price-sensitive purchasing behavior  
- High-value customers show more stable and profitable patterns  
- Mid-market segments are driven by volume rather than long-term value  

👉 This is not only a pricing issue, but a customer behavior and positioning challenge.

---

## ⚠️ Core Business Diagnosis

👉 The business appears to operate in a **“discount-driven growth loop”**:

- Sales volume increases through discounting  
- Profitability decreases as margins are reduced  

👉 This creates a structural inefficiency limiting long-term growth.

---

## 💡 Business Recommendations

### 🎯 Pricing Strategy
- Reduce high and medium discount levels  
- Apply discounts selectively on high-margin products  

### 👥 Customer Strategy
- Focus on high-value customers  
- Reduce dependency on discount-driven segments  

### 📦 Product Optimization
- Reassess low-profit products  
- Optimize pricing and cost structures  

### 🌍 Regional Strategy
- Invest in high-performing regions  
- Improve targeting in underperforming areas  

---

## 🧪 Testing Approach

- Test discount reduction strategies  
- Compare performance across segments  
- Evaluate targeting of high-value customers  
- Test retention and repeat purchase strategies  

---

## ⚖️ Business Considerations

- Reducing discounts may decrease sales volume but improve margins  
- Focusing on high-value customers may reduce volume but increase profitability  

---

## 🧠 Additional Perspective (CRM & Customer Experience)

From a CRM perspective, performance differences may be influenced by:

- Targeting strategy  
- Channel selection  
- Data quality  

Customer experience also plays a critical role. Even without immediate conversion, positive interactions can improve retention, engagement, and long-term value.

---

## 🧠 Personal Approach (Data × Marketing × Behavior)

This project reflects my approach to combining:

- Data analysis  
- Marketing strategy  
- Customer behavior understanding  

With a background in linguistics and computational analysis, I approach data not only as numbers, but as signals of human behavior, decision-making, and perception.

This allows me to:
- interpret patterns beyond surface-level metrics  
- connect data insights to customer psychology  
- understand how messaging, structure, and positioning influence performance  

Combined with hands-on CRM experience, I focus on translating data into actionable strategies aligned with real-world business operations.

---

## 🚀 Potential Impact

Optimizing pricing, targeting, and customer strategy could significantly improve profitability without increasing total revenue.

---

## 🧰 Tools Used

- Google Sheets  
- Data analysis & dashboarding  
- Data visualization  

---

## 🔗 Project Access

📊 Google Sheets Dashboard:  
https://docs.google.com/spreadsheets/d/1gzA6Ku7CxS1w-KYSprdfvAq9RMvU_k_YoeLQr71aItg/edit  

💻 GitHub Repository:  
https://github.com/CharlottePortenseigne/data-operations-portfolio.git  
