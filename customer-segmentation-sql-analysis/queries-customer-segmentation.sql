-- ============================================
-- CUSTOMER SEGMENTATION & REVENUE ANALYSIS
-- ============================================

-- Dataset: ecommerce
-- Columns:
-- event_time, event_type, product_id, category_id,
-- category_code, brand, price, user_id, user_session


-- ============================================
-- 1. Preview purchase data
-- Prompt
-- ============================================

SELECT *
FROM ecommerce
WHERE event_type = 'purchase'
LIMIT 10;


-- ============================================
-- 2. Total number of purchasing users
-- ============================================

SELECT 
    COUNT(DISTINCT user_id) AS total_purchasing_users
FROM ecommerce
WHERE event_type = 'purchase';


-- ============================================
-- 3. Average purchase value
-- ============================================

SELECT 
    ROUND(AVG(CAST(price AS REAL)), 2) AS avg_purchase_value
FROM ecommerce
WHERE event_type = 'purchase';


-- ============================================
-- 4. Top users by number of purchases
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
-- 5. Top users by total spending
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
-- 6. Base customer summary
-- One row per purchasing user
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
GROUP BY user_id
ORDER BY total_spent DESC;


-- ============================================
-- 7. Customer segmentation by total spending
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
GROUP BY user_id
ORDER BY total_spent DESC;


-- ============================================
-- 8. Segment distribution
-- Number of users in each segment
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
GROUP BY customer_segment
ORDER BY users DESC;


-- ============================================
-- 9. Revenue by segment
-- ============================================

SELECT 
    customer_segment,
    ROUND(SUM(total_spent), 2) AS segment_revenue
FROM (
    SELECT 
        user_id,
        SUM(CAST(price AS REAL)) AS total_spent,
        CASE 
            WHEN SUM(CAST(price AS REAL)) > 300 THEN 'High Value'
            WHEN SUM(CAST(price AS REAL)) > 100 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM ecommerce
    WHERE event_type = 'purchase'
    GROUP BY user_id
)
GROUP BY customer_segment
ORDER BY segment_revenue DESC;


-- ============================================
-- 10. Average spending by segment
-- ============================================

SELECT 
    customer_segment,
    ROUND(AVG(total_spent), 2) AS avg_spent_per_user
FROM (
    SELECT 
        user_id,
        SUM(CAST(price AS REAL)) AS total_spent,
        CASE 
            WHEN SUM(CAST(price AS REAL)) > 300 THEN 'High Value'
            WHEN SUM(CAST(price AS REAL)) > 100 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM ecommerce
    WHERE event_type = 'purchase'
    GROUP BY user_id
)
GROUP BY customer_segment
ORDER BY avg_spent_per_user DESC;


-- ============================================
-- 11. Revenue share by segment
-- ============================================

SELECT 
    customer_segment,
    ROUND(SUM(total_spent), 2) AS segment_revenue,
    ROUND(
        SUM(total_spent) * 100.0 / (
            SELECT SUM(CAST(price AS REAL))
            FROM ecommerce
            WHERE event_type = 'purchase'
        ),
        2
    ) AS revenue_share_pct
FROM (
    SELECT 
        user_id,
        SUM(CAST(price AS REAL)) AS total_spent,
        CASE 
            WHEN SUM(CAST(price AS REAL)) > 300 THEN 'High Value'
            WHEN SUM(CAST(price AS REAL)) > 100 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM ecommerce
    WHERE event_type = 'purchase'
    GROUP BY user_id
)
GROUP BY customer_segment
ORDER BY segment_revenue DESC;


-- ============================================
-- 12. Purchase frequency segmentation
-- ============================================

SELECT
    frequency_segment,
    COUNT(*) AS users
FROM (
    SELECT
        user_id,
        COUNT(*) AS total_purchases,
        CASE
            WHEN COUNT(*) >= 5 THEN 'Frequent'
            WHEN COUNT(*) >= 2 THEN 'Occasional'
            ELSE 'One-time'
        END AS frequency_segment
    FROM ecommerce
    WHERE event_type = 'purchase'
    GROUP BY user_id
)
GROUP BY frequency_segment
ORDER BY users DESC;


-- ============================================
-- 13. Repeat vs one-time customers
-- ============================================

SELECT
    CASE
        WHEN total_purchases = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS users
FROM (
    SELECT
        user_id,
        COUNT(*) AS total_purchases
    FROM ecommerce
    WHERE event_type = 'purchase'
    GROUP BY user_id
)
GROUP BY customer_type;


-- ============================================
-- 14. Revenue by repeat vs one-time customers
-- ============================================

SELECT
    customer_type,
    ROUND(SUM(total_spent), 2) AS revenue
FROM (
    SELECT
        user_id,
        COUNT(*) AS total_purchases,
        SUM(CAST(price AS REAL)) AS total_spent,
        CASE
            WHEN COUNT(*) = 1 THEN 'One-time'
            ELSE 'Repeat'
        END AS customer_type
    FROM ecommerce
    WHERE event_type = 'purchase'
    GROUP BY user_id
)
GROUP BY customer_type
ORDER BY revenue DESC;


-- ============================================
-- 15. Recency analysis
-- Last purchase date per user
-- ============================================

SELECT
    user_id,
    MAX(event_time) AS last_purchase_date
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY user_id
ORDER BY last_purchase_date DESC;


-- ============================================
-- 16. Value + frequency combined segmentation
-- More strategic segmentation
-- ============================================

SELECT
    user_id,
    ROUND(SUM(CAST(price AS REAL)), 2) AS total_spent,
    COUNT(*) AS total_purchases,
    CASE
        WHEN SUM(CAST(price AS REAL)) > 300 AND COUNT(*) >= 2 THEN 'High Value Loyal'
        WHEN SUM(CAST(price AS REAL)) > 300 AND COUNT(*) = 1 THEN 'High Value One-Time'
        WHEN SUM(CAST(price AS REAL)) > 100 AND COUNT(*) >= 2 THEN 'Medium Value Repeat'
        WHEN SUM(CAST(price AS REAL)) > 100 AND COUNT(*) = 1 THEN 'Medium Value One-Time'
        ELSE 'Low Value'
    END AS customer_profile
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY user_id
ORDER BY total_spent DESC, total_purchases DESC;


-- ============================================
-- 17. Distribution of combined customer profiles
-- ============================================

SELECT
    customer_profile,
    COUNT(*) AS users
FROM (
    SELECT
        user_id,
        SUM(CAST(price AS REAL)) AS total_spent,
        COUNT(*) AS total_purchases,
        CASE
            WHEN SUM(CAST(price AS REAL)) > 300 AND COUNT(*) >= 2 THEN 'High Value Loyal'
            WHEN SUM(CAST(price AS REAL)) > 300 AND COUNT(*) = 1 THEN 'High Value One-Time'
            WHEN SUM(CAST(price AS REAL)) > 100 AND COUNT(*) >= 2 THEN 'Medium Value Repeat'
            WHEN SUM(CAST(price AS REAL)) > 100 AND COUNT(*) = 1 THEN 'Medium Value One-Time'
            ELSE 'Low Value'
        END AS customer_profile
    FROM ecommerce
    WHERE event_type = 'purchase'
    GROUP BY user_id
)
GROUP BY customer_profile
ORDER BY users DESC;


-- ============================================
-- 18. Revenue by combined customer profiles
-- ============================================

SELECT
    customer_profile,
    ROUND(SUM(total_spent), 2) AS revenue
FROM (
    SELECT
        user_id,
        SUM(CAST(price AS REAL)) AS total_spent,
        COUNT(*) AS total_purchases,
        CASE
            WHEN SUM(CAST(price AS REAL)) > 300 AND COUNT(*) >= 2 THEN 'High Value Loyal'
            WHEN SUM(CAST(price AS REAL)) > 300 AND COUNT(*) = 1 THEN 'High Value One-Time'
            WHEN SUM(CAST(price AS REAL)) > 100 AND COUNT(*) >= 2 THEN 'Medium Value Repeat'
            WHEN SUM(CAST(price AS REAL)) > 100 AND COUNT(*) = 1 THEN 'Medium Value One-Time'
            ELSE 'Low Value'
        END AS customer_profile
    FROM ecommerce
    WHERE event_type = 'purchase'
    GROUP BY user_id
)
GROUP BY customer_profile
ORDER BY revenue DESC;


-- ============================================
-- END OF ANALYSIS
-- ============================================
