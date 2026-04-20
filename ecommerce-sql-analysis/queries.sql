-- =========================================================
-- E-COMMERCE FUNNEL, BEHAVIOR & CONVERSION ANALYSIS
-- Source: Kaggle e-commerce dataset
-- Tool: SQLite
-- Goal: analyze funnel performance, user behavior, 
--       revenue trends, and purchase signals
-- =========================================================

-- Table: ecommerce
-- Columns:
-- event_time, event_type, product_id, category_id,
-- category_code, brand, price, user_id, user_session


-- ============================================
-- 1. Preview data
-- ============================================

SELECT *
FROM ecommerce
LIMIT 10;


-- ============================================
-- 2. Event counts
-- ============================================

SELECT 
    event_type,
    COUNT(*) AS total_events
FROM ecommerce
GROUP BY event_type
ORDER BY total_events DESC;


-- ============================================
-- 3. Unique users by event type
-- ============================================

SELECT 
    event_type,
    COUNT(DISTINCT user_id) AS unique_users
FROM ecommerce
GROUP BY event_type
ORDER BY unique_users DESC;


-- ============================================
-- 4. Overall conversion rate
-- Distinct users who purchased / distinct users overall
-- ============================================

SELECT 
    ROUND(
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) * 1.0
        / COUNT(DISTINCT user_id),
        4
    ) AS conversion_rate
FROM ecommerce;


-- ============================================
-- 5. Funnel counts
-- Distinct users at each main stage
-- ============================================

SELECT 
    COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END) AS users_viewed,
    COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END) AS users_carted,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS users_purchased
FROM ecommerce;


-- ============================================
-- 6. View → Cart conversion
-- ============================================

SELECT 
    COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END) AS users_carted,
    COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END) AS users_viewed,
    ROUND(
        COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END) * 1.0
        / COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END),
        4
    ) AS view_to_cart_rate
FROM ecommerce;


-- ============================================
-- 7. Cart -> Purchase conversion
-- ============================================

SELECT 
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS users_purchased,
    COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END) AS users_carted,
    ROUND(
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) * 1.0
        / COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END),
        4
    ) AS cart_to_purchase_rate
FROM ecommerce;


-- ============================================
-- 8. Funnel drop-off rates
-- ============================================

SELECT 
    ROUND(
        1 - (
            COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END) *1.0
            / COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END)
        ),
        4
    ) AS view_to_cart_dropoff_rate,
    ROUND(
        1 - (
            COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) * 1.0
            / COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END)
        ),
        4
    ) AS cart_to_purchase_dropoff_rate
FROM ecommerce;


-- ============================================
-- 9. Total revenue
-- ============================================

SELECT 
    ROUND(SUM(CAST(price AS REAL)), 2) AS total_revenue
FROM ecommerce
WHERE event_type = 'purchase';


-- ============================================
-- 10. Average purchase value
-- ============================================

SELECT 
    ROUND(AVG(CAST(price AS REAL)), 2) AS avg_purchase_value
FROM ecommerce
WHERE event_type = 'purchase';


-- ============================================
-- 11. Revenue by month
-- ============================================

SELECT 
    SUBSTR(event_time, 1, 7) AS month,
    ROUND(SUM(CAST(price AS REAL)), 2) AS revenue
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY month
ORDER BY month;


-- ============================================
-- 12. Purchases by month
-- Useful for comparing purchase volume and revenue
-- ============================================

SELECT 
    SUBSTR(event_time, 1, 7) AS month,
    COUNT(*) AS purchase_events,
    ROUND(SUM(CAST(price AS REAL)), 2) AS revenue
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY month
ORDER BY month;


-- ============================================
-- 13. Top products by purchases
-- ============================================

SELECT 
    product_id,
    COUNT(*) AS purchases,
    ROUND(SUM(CAST(price AS REAL)), 2) AS revenue
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY product_id
ORDER BY purchases DESC, revenue DESC
LIMIT 10;


-- ============================================
-- 14. Top brands by purchases
-- ============================================

SELECT 
    brand,
    COUNT(*) AS purchases,
    ROUND(SUM(CAST(price AS REAL)), 2) AS revenue
FROM ecommerce
WHERE event_type = 'purchase'
  AND brand IS NOT NULL
  AND brand <> ''
GROUP BY brand
ORDER BY purchases DESC, revenue DESC
LIMIT 10;


-- ============================================
-- 15. Revenue by brand
-- Useful to distinguish purchase volume vs value
-- ============================================

SELECT 
    brand,
    ROUND(SUM(CAST(price AS REAL)), 2) AS revenue,
    COUNT(*) AS purchase_events
FROM ecommerce
WHERE event_type = 'purchase'
  AND brand IS NOT NULL
  AND brand <> ''
GROUP BY brand
ORDER BY revenue DESC
LIMIT 10;

-- ============================================
-- 16. Top categories by revenue
-- ============================================

SELECT 
    category_code,
    ROUND(SUM(CAST(price AS REAL)), 2) AS revenue
FROM ecommerce
WHERE event_type = 'purchase'
  AND category_code IS NOT NULL
  AND category_code <> ''
GROUP BY category_code
ORDER BY revenue DESC
LIMIT 10;


-- ============================================
-- 17. Remove-from-cart behavior
-- ============================================

SELECT 
    COUNT(*) AS remove_from_cart_events
FROM ecommerce
WHERE event_type = 'remove_from_cart';


-- ============================================
-- 18. Users who removed items from cart
-- ============================================

SELECT 
    COUNT(DISTINCT user_id) AS users_removed_from_cart
FROM ecommerce
WHERE event_type = 'remove_from_cart';


-- ============================================
-- 19. Remove-from-cart rate among cart users
-- Better measure of hesitation after cart intent
-- ============================================

SELECT 
    COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END) AS users_carted,
    COUNT(DISTINCT CASE WHEN event_type = 'remove_from_cart' THEN user_id END) AS users_removed_from_cart,
    ROUND(
        COUNT(DISTINCT CASE WHEN event_type = 'remove_from_cart' THEN user_id END) * 1.0
        / COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END),
        4
    ) AS remove_from_cart_user_rate
FROM ecommerce;


-- ============================================
-- 20. Users who carted but never purchased
-- Strong CRM / abandonment signal
-- ============================================

SELECT
    COUNT(*) AS cart_no_purchase_users
FROM (
    SELECT
        user_id,
        MAX(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS added_to_cart,
        MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased
    FROM ecommerce
    GROUP BY user_id
)
WHERE added_to_cart = 1
    AND purchased = 0 ;

-- ============================================
-- 21. One-time vs repeat purchasers
-- Adds a retention / CRM angle
-- ============================================

SELECT
    CASE
        WHEN purchase_count = 1 THEN 'One-time purchaser'
        ELSE 'Repeat purchaser'
    END AS customer_type,
    COUNT(*) AS users
FROM (
    SELECT
        user_id,
    COUNT(*) AS purchase_count
    FROM ecommerce
    WHERE event_type = 'purchase'
    GROUP BY user_id
)
GROUP BY customer_type;
    

-- ============================================
-- 22. Session behavior preview
-- Events per session + purchase flag
-- ============================================

SELECT 
    user_session,
    COUNT(*) AS events_count,
    MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased
FROM ecommerce
GROUP BY user_session
LIMIT 20;


-- ============================================
-- 23. Session behavior aggregated
-- Conversion by number of interactions
-- ============================================

SELECT 
    events_count,
    COUNT(*) AS sessions,
    SUM(purchased) AS purchases,
    ROUND(SUM(purchased) * 1.0 / COUNT(*), 4) AS conversion_rate
FROM(
    SELECT
        user_session,
        COUNT(*) AS events_count,
        MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased
    FROM ecommerce
    GROUP BY user_session
)
GROUP BY events_count
ORDER BY events_count;


-- ============================================
-- 24. Interaction buckets
-- Cleaner version for README / insights storytelling
-- ============================================

SELECT 
    interaction_bucket,
    COUNT(*) AS sessions,
    SUM(purchased) AS purchases,
    ROUND(SUM(purchased) * 1.0 / COUNT(*), 4) AS conversion_rate
FROM(
    SELECT
        user_session,
        MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased,
        CASE
            WHEN COUNT(*) = 1 THEN '1 interaction'
            WHEN COUNT(*) = 2 THEN '2 interactions'
            WHEN COUNT(*) BETWEEN 3 and 4 THEN '3-4 interactions'
            ELSE '5+ interactions'
        END AS interaction_bucket
    FROM ecommerce
    GROUP BY user_session
)
GROUP BY interaction_bucket
ORDER BY 
    CASE interaction_bucket
        WHEN '1 interaction' THEN 1
        WHEN '2 interactions' THEN 2
        WHEN '3-4 interactions' THEN 3
        ELSE 4
    END;


-- ============================================
-- 25. Average events in purchasing vs non-purchasing sessions
-- Supports the idea than more interactions can signal stronger intent
-- ============================================

SELECT
    purchased,
    ROUND(AVG(events_count), 2) AS avg_events_per_session
FROM (
    SELECT
        user_session,
        COUNT(*) AS events_count,
        MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased
    FROM ecommerce
    GROUP BY user_session
)
GROUP BY purchased;


-- ============================================
-- 26. Optional context: unique users vs sessions
-- ============================================

SELECT
    COUNT(DISTINCT user_id) AS unique_users,
    COUNT(DISTINCT user_session) AS unique_sessions
FROM ecommerce;


-- ============================================
-- END OF ANALYSIS
-- ============================================
