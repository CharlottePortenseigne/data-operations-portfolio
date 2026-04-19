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




/* =========================================================
   E-COMMERCE FUNNEL & USER BEHAVIOR ANALYSIS
   Source: Kaggle e-commerce dataset
   Goal: analyze conversion, behavior, revenue, and trends
   ========================================================= */


/* =========================================================
   1. DATA EXPLORATION
   ========================================================= */

-- Preview the raw dataset
SELECT *
FROM ecommerce
LIMIT 10;

-- Count rows where category information is missing
SELECT COUNT(*) AS missing_categories
FROM ecommerce
WHERE category_code IS NULL
   OR category_code = '';



/* =========================================================
   2. FUNNEL CONSTRUCTION (SESSION LEVEL)
   ========================================================= */

-- Remove the table if it already exists
DROP TABLE IF EXISTS funnel;

-- Build one row per session
-- viewed = session had at least one product view
-- added_to_cart = session had at least one cart event
-- purchased = session had at least one purchase event
CREATE TABLE funnel AS
SELECT
  user_session,
  MAX(CASE WHEN event_type = 'view' THEN 1 ELSE 0 END) AS viewed,
  MAX(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS added_to_cart,
  MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased
FROM ecommerce
GROUP BY user_session;



/* =========================================================
   3. FUNNEL METRICS
   ========================================================= */

-- Calculate total sessions at each stage
-- and conversion rates between stages
SELECT
  COUNT(*) AS total_sessions,
  SUM(viewed) AS total_views,
  SUM(added_to_cart) AS total_carts,
  SUM(purchased) AS total_purchases,
  SUM(added_to_cart) * 1.0 / SUM(viewed) AS view_to_cart_rate,
  SUM(purchased) * 1.0 / SUM(added_to_cart) AS cart_to_purchase_rate
FROM funnel;



/* =========================================================
   4. DROP-OFF ANALYSIS
   ========================================================= */

-- Measure how many users are lost between each stage
SELECT
  1 - (SUM(added_to_cart) * 1.0 / SUM(viewed)) AS view_to_cart_dropoff,
  1 - (SUM(purchased) * 1.0 / SUM(added_to_cart)) AS cart_to_purchase_dropoff
FROM funnel;



/* =========================================================
   5. BRAND ANALYSIS
   ========================================================= */

-- Compare brands by conversion rate
-- Use DISTINCT sessions to avoid double counting
-- Keep only brands with at least 20 sessions for reliability
SELECT
  e.brand,
  COUNT(DISTINCT e.user_session) AS sessions,
  COUNT(DISTINCT CASE WHEN f.purchased = 1 THEN e.user_session END) AS purchases,
  COUNT(DISTINCT CASE WHEN f.purchased = 1 THEN e.user_session END) * 1.0
    / COUNT(DISTINCT e.user_session) AS conversion_rate
FROM ecommerce e
JOIN funnel f
  ON e.user_session = f.user_session
WHERE e.brand IS NOT NULL
GROUP BY e.brand
HAVING COUNT(DISTINCT e.user_session) >= 20
ORDER BY conversion_rate DESC;



/* =========================================================
   6. PRICE ANALYSIS
   ========================================================= */

-- Group products into price bands
-- Then compare session volume, purchases, and conversion rate
SELECT
  CASE
    WHEN e.price < 50 THEN 'Low'
    WHEN e.price BETWEEN 50 AND 150 THEN 'Mid'
    ELSE 'High'
  END AS price_range,
  COUNT(DISTINCT e.user_session) AS sessions,
  COUNT(DISTINCT CASE WHEN f.purchased = 1 THEN e.user_session END) AS purchases,
  COUNT(DISTINCT CASE WHEN f.purchased = 1 THEN e.user_session END) * 1.0
    / COUNT(DISTINCT e.user_session) AS conversion_rate
FROM ecommerce e
JOIN funnel f
  ON e.user_session = f.user_session
GROUP BY price_range
ORDER BY conversion_rate DESC;



/* =========================================================
   7. REVENUE ANALYSIS
   ========================================================= */

-- Compute total revenue from purchase events only
-- Also calculate average order value (AOV)
SELECT
  SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) AS total_revenue,
  COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_session END) AS purchases,
  SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) * 1.0
    / COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_session END) AS avg_order_value
FROM ecommerce;



/* =========================================================
   8. TIME-BASED ANALYSIS
   ========================================================= */

-- event_time contains "UTC", which SQLite does not parse directly
-- Remove " UTC" so DATE() can extract the date correctly
SELECT
  DATE(REPLACE(event_time, ' UTC', '')) AS date,
  COUNT(DISTINCT user_session) AS sessions,
  COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) AS purchases
FROM ecommerce
GROUP BY date
ORDER BY date;



/* =========================================================
   9. USER BEHAVIOR ANALYSIS (SESSION LEVEL)
   ========================================================= */

-- Count how many events happen in each session
-- Also flag whether the session ended in a purchase
SELECT
  user_session,
  COUNT(*) AS events_count,
  MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased
FROM ecommerce
GROUP BY user_session;



/* =========================================================
   10. USER BEHAVIOR ANALYSIS (AGGREGATED)
   ========================================================= */

-- Group sessions by number of events
-- Then compare how conversion changes with engagement depth
SELECT
  events_count,
  COUNT(*) AS sessions,
  SUM(purchased) AS purchases,
  SUM(purchased) * 1.0 / COUNT(*) AS conversion_rate
FROM (
  SELECT
    user_session,
    COUNT(*) AS events_count,
    MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased
  FROM ecommerce
  GROUP BY user_session
)
GROUP BY events_count
ORDER BY events_count;



/* =========================================================
   11. CATEGORY / LINGUISTIC ANALYSIS
   ========================================================= */

-- Extract the main category from hierarchical category codes
-- Example:
-- furniture.living_room.cabinet -> furniture
-- This is a simple linguistic / semantic simplification
SELECT
  SUBSTR(category_code, 1, INSTR(category_code, '.') - 1) AS main_category,
  COUNT(DISTINCT e.user_session) AS sessions,
  COUNT(DISTINCT CASE WHEN f.purchased = 1 THEN e.user_session END) AS purchases,
  COUNT(DISTINCT CASE WHEN f.purchased = 1 THEN e.user_session END) * 1.0
    / COUNT(DISTINCT e.user_session) AS conversion_rate
FROM ecommerce e
JOIN funnel f
  ON e.user_session = f.user_session
WHERE category_code IS NOT NULL
  AND category_code != ''
GROUP BY main_category
HAVING COUNT(DISTINCT e.user_session) >= 50
ORDER BY conversion_rate DESC;



/* =========================================================
   END OF ANALYSIS
   ========================================================= */