-- ============================================
-- CUSTOMER SEGMENTATION & REVENUE ANALYSIS
-- ============================================

-- Dataset: ecommerce
-- Columns:
-- event_time, event_type, product_id, category_id,
-- category_code, brand, price, user_id, user_session

-- ============================================
-- 1. Preview purchase data
-- Prompt: What do purchase events look like?
-- Why: Validate dataset structure and filtering
-- ============================================

SELECT *
FROM ecommerce
WHERE event_type = 'purchase'
LIMIT 10;

-- ============================================
-- 2. Data quality check (full dataset)
-- Prompt: Are there missing values in the dataset?
-- Why: Ensure data reliability
-- ============================================

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN user_id IS NULL OR user_id = '' THEN 1 ELSE 0 END) AS missing_user_id,
    SUM(CASE WHEN price IS NULL OR price = '' THEN 1 ELSE 0 END) AS missing_price,
    SUM(CASE WHEN category_code IS NULL OR category_code = '' THEN 1 ELSE 0 END) AS missing_category_code,
    SUM(CASE WHEN brand IS NULL OR brand = '' THEN 1 ELSE 0 END) AS missing_brand
FROM ecommerce;

-- ============================================
-- 3. Purchase data quality check
-- Prompt: Is purchase data valid?
-- Why: Ensure revenue calculations are correct
-- ============================================

SELECT
    COUNT(*) AS purchase_rows,
    SUM(CASE WHEN user_id IS NULL OR user_id = '' THEN 1 ELSE 0 END) AS missing_user_id,
    SUM(CASE WHEN price IS NULL OR price = '' THEN 1 ELSE 0 END) AS missing_price,
    SUM(CASE WHEN CAST(price AS REAL) <= 0 THEN 1 ELSE 0 END) AS invalid_price
FROM ecommerce
WHERE event_type = 'purchase';

-- ============================================
-- 4. Total purchasing users
-- Prompt: How many users made a purchase?
-- Why: Define customer base
-- ============================================

SELECT 
    COUNT(DISTINCT user_id) AS total_purchasing_users
FROM ecommerce
WHERE event_type = 'purchase';

-- ============================================
-- 5. Total revenue
-- Prompt: What is the total revenue?
-- Why: Measure business performance
-- ============================================

SELECT 
    ROUND(SUM(CAST(price AS REAL)), 2) AS total_revenue
FROM ecommerce
WHERE event_type = 'purchase';

-- ============================================
-- 6. Average purchase value
-- Prompt: What is the average purchase value?
-- Why: Understand transaction size
-- ============================================

SELECT 
    ROUND(AVG(CAST(price AS REAL)), 2) AS avg_purchase_value
FROM ecommerce
WHERE event_type = 'purchase';

-- ============================================
-- 7. Median purchase value
-- Prompt: What is the median purchase value?
-- Why: Identify distribution skewness
-- ============================================

SELECT 
    ROUND(AVG(price), 2) AS median_purchase_value
FROM (
    SELECT CAST(price AS REAL) AS price
    FROM ecommerce
    WHERE event_type = 'purchase'
    ORDER BY price
    LIMIT 2 - (
        SELECT COUNT(*) 
        FROM ecommerce 
        WHERE event_type = 'purchase'
    ) % 2
    OFFSET (
        SELECT (COUNT(*) - 1) / 2
        FROM ecommerce 
        WHERE event_type = 'purchase'
    )
);

-- ============================================
-- 8. Top users by purchase count
-- Prompt: Which users make the most purchases?
-- Why: Identify highly active customers
-- ============================================

SELECT 
    user_id,
    COUNT(*) AS total_purchases
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY user_id
ORDER BY total_purchases DESC
LIMIT 10;

-- ============================================
-- 9. Top users by spending
-- Prompt: Which users spend the most?
-- Why: Identify top revenue contributors
-- ============================================

SELECT 
    user_id,
    ROUND(SUM(CAST(price AS REAL)), 2) AS total_spent
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY user_id
ORDER BY total_spent DESC
LIMIT 10;

-- ============================================
-- 10. Customer summary
-- Prompt: What is each customer's purchase behavior?
-- Why: Build base dataset for segmentation
-- ============================================

SELECT
    user_id,
    COUNT(*) AS total_purchases,
    ROUND(SUM(CAST(price AS REAL)), 2) AS total_spent,
    ROUND(AVG(CAST(price AS REAL)), 2) AS avg_order_value,
    MIN(event_time) AS first_purchase,
    MAX(event_time) AS last_purchase
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY user_id;

-- ============================================
-- 11. Customer segmentation
-- Prompt: How can customers be grouped by value?
-- Why: Classify customers based on spending
-- ============================================

SELECT 
    user_id,
    ROUND(SUM(CAST(price AS REAL)), 2) AS total_spent,
    CASE 
        WHEN SUM(CAST(price AS REAL)) > 300 THEN 'High Value'
        WHEN SUM(CAST(price AS REAL)) > 100 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY user_id;

-- ============================================
-- 12. Segment distribution
-- Prompt: How many users per segment?
-- Why: Understand customer composition
-- ============================================

SELECT 
    customer_segment,
    COUNT(*) AS users
FROM (
    SELECT 
        user_id,
        CASE 
            WHEN SUM(CAST(price AS REAL)) > 300 THEN 'High Value'
            WHEN SUM(CAST(price AS REAL)) > 100 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM ecommerce
    WHERE event_type = 'purchase'
    GROUP BY user_id
)
GROUP BY customer_segment;

-- ============================================
-- 13. Revenue by segment
-- Prompt: How much revenue per segment?
-- Why: Identify revenue drivers
-- ============================================

SELECT 
    customer_segment,
    ROUND(SUM(total_spent), 2) AS revenue
FROM (
    SELECT 
        user_id,
        SUM

-- ============================================
-- 14. Average spend per segment
-- ============================================

SELECT segment,
COUNT(*) AS users,
ROUND(AVG(total_spent),2) AS avg_spent
FROM (
SELECT user_id,
SUM(CAST(price AS REAL)) AS total_spent,
CASE
WHEN SUM(CAST(price AS REAL)) > 300 THEN 'High Value'
WHEN SUM(CAST(price AS REAL)) > 100 THEN 'Medium Value'
ELSE 'Low Value'
END AS segment
FROM ecommerce
WHERE event_type='purchase'
GROUP BY user_id
)
GROUP BY segment;

-- ============================================
-- 15. Final segmentation summary
-- ============================================

WITH base AS (
SELECT user_id, SUM(CAST(price AS REAL)) AS total_spent
FROM ecommerce
WHERE event_type='purchase'
GROUP BY user_id
)
SELECT
CASE
WHEN total_spent > 300 THEN 'High Value'
WHEN total_spent > 100 THEN 'Medium Value'
ELSE 'Low Value'
END AS segment,
COUNT(*) AS users,
ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM base),2) AS pct_users,
ROUND(SUM(total_spent),2) AS revenue,
ROUND(SUM(total_spent)*100.0/(SELECT SUM(total_spent) FROM base),2) AS pct_revenue
FROM base
GROUP BY segment;

-- ============================================
-- 16. Frequency segmentation
-- ============================================

SELECT
CASE
WHEN COUNT(*)>=5 THEN 'Frequent'
WHEN COUNT(*)>=2 THEN 'Occasional'
ELSE 'One-time'
END AS frequency,
COUNT(*) AS users
FROM ecommerce
WHERE event_type='purchase'
GROUP BY user_id;

-- ============================================
-- 17. Revenue by frequency
-- ============================================

SELECT frequency, SUM(total_spent) AS revenue
FROM (
SELECT user_id,
COUNT(*) AS purchases,
SUM(CAST(price AS REAL)) AS total_spent,
CASE
WHEN COUNT(*)>=5 THEN 'Frequent'
WHEN COUNT(*)>=2 THEN 'Occasional'
ELSE 'One-time'
END AS frequency
FROM ecommerce
WHERE event_type='purchase'
GROUP BY user_id
)
GROUP BY frequency;

-- ============================================
-- 18. Repeat vs one-time customers
-- ============================================

SELECT customer_type, COUNT(*) AS users
FROM (
SELECT user_id,
CASE WHEN COUNT(*)=1 THEN 'One-time' ELSE 'Repeat' END AS customer_type
FROM ecommerce
WHERE event_type='purchase'
GROUP BY user_id
)
GROUP BY customer_type;

-- ============================================
-- 19. Revenue by repeat vs one-time
-- ============================================

SELECT customer_type, SUM(total_spent) AS revenue
FROM (
SELECT user_id,
SUM(CAST(price AS REAL)) AS total_spent,
CASE WHEN COUNT(*)=1 THEN 'One-time' ELSE 'Repeat' END AS customer_type
FROM ecommerce
WHERE event_type='purchase'
GROUP BY user_id
)
GROUP BY customer_type;

-- ============================================
-- 20. Final repeat summary
-- ============================================

WITH base AS (
SELECT user_id,
COUNT(*) AS purchases,
SUM(CAST(price AS REAL)) AS total_spent
FROM ecommerce
WHERE event_type='purchase'
GROUP BY user_id
)
SELECT
CASE WHEN purchases=1 THEN 'One-time' ELSE 'Repeat' END AS type,
COUNT(*) AS users,
ROUND(SUM(total_spent),2) AS revenue
FROM base
GROUP BY type;

-- ============================================
-- 21. Recency
-- ============================================

SELECT user_id, MAX(event_time) AS last_purchase
FROM ecommerce
WHERE event_type='purchase'
GROUP BY user_id;

-- ============================================
-- 22. Purchase span
-- ============================================

SELECT user_id,
MIN(event_time),
MAX(event_time),
COUNT(*) AS purchases
FROM ecommerce
WHERE event_type='purchase'
GROUP BY user_id;

-- ============================================
-- 23. Combined segmentation
-- ============================================

SELECT user_id,
SUM(price) AS total_spent,
COUNT(*) AS purchases
FROM ecommerce
WHERE event_type='purchase'
GROUP BY user_id;

-- ============================================
-- 24. Combined segment distribution
-- ============================================

SELECT COUNT(*) FROM ecommerce WHERE event_type='purchase';

-- ============================================
-- 25. Combined revenue
-- ============================================

SELECT SUM(price) FROM ecommerce WHERE event_type='purchase';

-- ============================================
-- 26. Combined summary
-- ============================================

SELECT AVG(price) FROM ecommerce WHERE event_type='purchase';

-- ============================================
-- 27. Revenue concentration (top 10)
-- ============================================

SELECT SUM(total_spent)
FROM (
SELECT user_id, SUM(price) AS total_spent
FROM ecommerce
WHERE event_type='purchase'
GROUP BY user_id
ORDER BY total_spent DESC
LIMIT 10
);

-- ============================================
-- 28. Top 10 detail
-- ============================================

SELECT user_id, SUM(price)
FROM ecommerce
WHERE event_type='purchase'
GROUP BY user_id
ORDER BY SUM(price) DESC
LIMIT 10;

-- ============================================
-- 29. Product summary
-- ============================================

SELECT product_id, COUNT(*), SUM(price)
FROM ecommerce
WHERE event_type='purchase'
GROUP BY product_id;

-- ============================================
-- 30. Brand summary
-- ============================================

SELECT brand, COUNT(*), SUM(price)
FROM ecommerce
WHERE event_type='purchase'
GROUP BY brand;

-- ============================================
-- 31. Category summary
-- ============================================

SELECT category_code, COUNT(*), SUM(price)
FROM ecommerce
WHERE event_type='purchase'
GROUP BY category_code;

-- ============================================
-- 32. Monthly revenue
-- ============================================

SELECT SUBSTR(event_time,1,7), SUM(price)
FROM ecommerce
WHERE event_type='purchase'
GROUP BY SUBSTR(event_time,1,7);

-- ============================================
-- 33. Monthly users
-- ============================================

SELECT SUBSTR(event_time,1,7), COUNT(DISTINCT user_id)
FROM ecommerce
WHERE event_type='purchase'
GROUP BY SUBSTR(event_time,1,7);

-- ============================================
-- 34. Executive summary
-- ============================================

SELECT COUNT(DISTINCT user_id), SUM(price), AVG(price)
FROM ecommerce
WHERE event_type='purchase';

-- ============================================
-- 35. Price distribution
-- ============================================

SELECT
CASE
WHEN price<2 THEN 'Very Low'
WHEN price<5 THEN 'Low'
WHEN price<10 THEN 'Medium'
ELSE 'High'
END AS bucket,
COUNT(*),
SUM(price)
FROM ecommerce
WHERE event_type='purchase'
GROUP BY bucket;

-- ============================================
-- 36. Purchase span (engagement)
-- ============================================

SELECT user_id,
MIN(event_time),
MAX(event_time),
COUNT(*),
SUM(price)
FROM ecommerce
WHERE event_type='purchase'
GROUP BY user_id
HAVING COUNT(*)>=2;

-- ============================================
-- END OF ANALYSIS
-- ===========================================================


