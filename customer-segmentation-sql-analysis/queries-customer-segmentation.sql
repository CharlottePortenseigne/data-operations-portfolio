-- ============================================
-- Customer Segmentation & Revenue Analysis
-- ============================================

-- 1. Top users by number of purchases
SELECT 
    user_id,
    COUNT(*) AS total_purchases
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY user_id
ORDER BY total_purchases DESC
LIMIT 10;

-- 2. Top users by total spending
SELECT 
    user_id,
    ROUND(SUM(CAST(price AS REAL)), 2) AS total_spent
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY user_id
ORDER BY total_spent DESC
LIMIT 10;

-- 3. Average purchase value
SELECT 
    ROUND(AVG(CAST(price AS REAL)), 2) AS avg_purchase_value
FROM ecommerce
WHERE event_type = 'purchase';

-- 4. Number of purchasing users
SELECT 
    COUNT(DISTINCT user_id) AS purchasing_users
FROM ecommerce
WHERE event_type = 'purchase';

-- 5. Customer segmentation
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

-- 6. Segment distribution
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