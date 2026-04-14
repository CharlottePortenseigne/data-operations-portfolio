-- ============================================
-- E-commerce Funnel & User Behavior Analysis
-- ============================================

-- Table: ecommerce
-- Columns:
-- event_time, event_type, product_id, category_id,
-- category_code, brand, price, user_id, user_session


-- ============================================
-- 1. Preview data
-- ============================================

SELECT *
FROM ecommerce
LIMIT 5;


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
-- 4. Conversion rate
-- ============================================

SELECT 
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) * 1.0
    / COUNT(DISTINCT user_id) AS conversion_rate
FROM ecommerce;


-- ============================================
-- 5. Funnel: view → cart
-- ============================================

SELECT 
    COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END) AS users_viewed,
    COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END) AS users_carted
FROM ecommerce;


-- ============================================
-- 6. Funnel: cart → purchase
-- ============================================

SELECT 
    COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END) AS users_carted,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS users_purchased
FROM ecommerce;


-- ============================================
-- 7. Total revenue
-- ============================================

SELECT 
    ROUND(SUM(CAST(price AS REAL)), 2) AS total_revenue
FROM ecommerce
WHERE event_type = 'purchase';


-- ============================================
-- 8. Revenue by month
-- ============================================

SELECT 
    SUBSTR(event_time, 1, 7) AS month,
    ROUND(SUM(CAST(price AS REAL)), 2) AS revenue
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY month
ORDER BY month;


-- ============================================
-- 9. Top categories by revenue
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
-- 10. Top products
-- ============================================

SELECT 
    product_id,
    COUNT(*) AS purchases
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY product_id
ORDER BY purchases DESC
LIMIT 10;


-- ============================================
-- 11. Top brands
-- ============================================

SELECT 
    brand,
    COUNT(*) AS purchases
FROM ecommerce
WHERE event_type = 'purchase'
  AND brand IS NOT NULL
  AND brand <> ''
GROUP BY brand
ORDER BY purchases DESC
LIMIT 10;


-- ============================================
-- 12. Remove-from-cart behavior
-- ============================================

SELECT 
    COUNT(*) AS remove_from_cart_events
FROM ecommerce
WHERE event_type = 'remove_from_cart';


-- ============================================
-- 13. Users who removed items from cart
-- ============================================

SELECT 
    COUNT(DISTINCT user_id) AS users_removed_from_cart
FROM ecommerce
WHERE event_type = 'remove_from_cart';


-- ============================================
-- 14. Average purchase value
-- ============================================

SELECT 
    ROUND(AVG(CAST(price AS REAL)), 2) AS avg_purchase_value
FROM ecommerce
WHERE event_type = 'purchase';