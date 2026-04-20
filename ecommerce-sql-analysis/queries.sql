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





-- =========================================================
-- E-COMMERCE FUNNEL, BEHAVIOR & CONVERSION ANALYSIS
-- Source: Kaggle e-commerce dataset
-- Tool: SQLite
-- Goal: analyze funnel performance, user behavior, revenue,
--       pricing, brands, and category structure
-- =========================================================


-- =========================================================
-- 0. DATA PREVIEW & BASIC DATA QUALITY CHECKS
-- =========================================================

-- Preview raw data
SELECT *
FROM ecommerce
LIMIT 10;

-- Total number of rows
SELECT COUNT(*) AS total_rows
FROM ecommerce;

-- Count events by type
SELECT
    event_type,
    COUNT(*) AS total_events
FROM ecommerce
GROUP BY event_type
ORDER BY total_events DESC;

-- Check missing category values
SELECT COUNT(*) AS missing_category_code
FROM ecommerce
WHERE category_code IS NULL
   OR category_code = '';

-- Check missing brand values
SELECT COUNT(*) AS missing_brand
FROM ecommerce
WHERE brand IS NULL
   OR brand = '';

-- Check missing or invalid prices
SELECT COUNT(*) AS invalid_price_rows
FROM ecommerce
WHERE price IS NULL
   OR CAST(price AS REAL) <= 0;


-- =========================================================
-- 1. CLEAN BASE VIEW
-- Standardize key fields for downstream analysis
-- =========================================================

DROP VIEW IF EXISTS clean_events;

CREATE VIEW clean_events AS
SELECT
    DATE(REPLACE(event_time, ' UTC', '')) AS event_date,
    SUBSTR(REPLACE(event_time, ' UTC', ''), 1, 7) AS event_month,
    event_time,
    event_type,
    product_id,
    category_id,
    category_code,
    brand,
    CAST(price AS REAL) AS price,
    user_id,
    user_session
FROM ecommerce
WHERE user_session IS NOT NULL
  AND user_session <> ''
  AND price IS NOT NULL;


-- =========================================================
-- 2. SESSION-LEVEL FUNNEL TABLE
-- One row per session
-- viewed / added_to_cart / purchased / removed_from_cart flags
-- =========================================================

DROP TABLE IF EXISTS funnel_session;

CREATE TABLE funnel_session AS
SELECT
    user_session,
    MAX(CASE WHEN event_type = 'view' THEN 1 ELSE 0 END) AS viewed,
    MAX(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS added_to_cart,
    MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased,
    MAX(CASE WHEN event_type = 'remove_from_cart' THEN 1 ELSE 0 END) AS removed_from_cart,
    COUNT(*) AS total_events_in_session
FROM clean_events
GROUP BY user_session;


-- =========================================================
-- 3. CORE FUNNEL METRICS
-- Covers README metrics: sessions, views, carts, purchases,
-- conversion rates, overall conversion
-- =========================================================

SELECT
    COUNT(*) AS total_sessions,
    SUM(viewed) AS sessions_with_view,
    SUM(added_to_cart) AS sessions_with_cart,
    SUM(purchased) AS sessions_with_purchase,
    ROUND(SUM(added_to_cart) * 1.0 / NULLIF(SUM(viewed), 0), 4) AS view_to_cart_rate,
    ROUND(SUM(purchased) * 1.0 / NULLIF(SUM(added_to_cart), 0), 4) AS cart_to_purchase_rate,
    ROUND(SUM(purchased) * 1.0 / COUNT(*), 4) AS overall_conversion_rate
FROM funnel_session;


-- =========================================================
-- 4. FUNNEL DROP-OFF ANALYSIS
-- Covers README / insights: major drop-offs in the funnel
-- =========================================================

SELECT
    ROUND(1 - (SUM(added_to_cart) * 1.0 / NULLIF(SUM(viewed), 0)), 4) AS view_to_cart_dropoff_rate,
    ROUND(1 - (SUM(purchased) * 1.0 / NULLIF(SUM(added_to_cart), 0)), 4) AS cart_to_purchase_dropoff_rate
FROM funnel_session;


-- =========================================================
-- 5. CART ABANDONMENT SIGNAL
-- Sessions that reached cart but did not purchase
-- Supports cart friction / abandonment insight
-- =========================================================

SELECT
    COUNT(*) AS cart_sessions,
    SUM(CASE WHEN added_to_cart = 1 AND purchased = 0 THEN 1 ELSE 0 END) AS abandoned_cart_sessions,
    ROUND(
        SUM(CASE WHEN added_to_cart = 1 AND purchased = 0 THEN 1 ELSE 0 END) * 1.0
        / NULLIF(SUM(added_to_cart), 0),
        4
    ) AS cart_abandonment_rate
FROM funnel_session;


-- =========================================================
-- 6. REVENUE & ORDER VALUE
-- Covers README / insights: total revenue and AOV
-- =========================================================

SELECT
    ROUND(SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END), 2) AS total_revenue,
    COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) AS purchase_events,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_session END) AS purchasing_sessions,
    ROUND(
        SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) * 1.0
        / NULLIF(COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_session END), 0),
        2
    ) AS avg_order_value
FROM clean_events;


-- =========================================================
-- 7. REVENUE BY MONTH
-- Covers README time/revenue observation
-- =========================================================

SELECT
    event_month,
    ROUND(SUM(price), 2) AS revenue,
    COUNT(DISTINCT user_session) AS purchasing_sessions
FROM clean_events
WHERE event_type = 'purchase'
GROUP BY event_month
ORDER BY event_month;


-- =========================================================
-- 8. DAILY TRAFFIC VS PURCHASES
-- Supports insight: traffic can rise while purchases lag
-- =========================================================

SELECT
    event_date,
    COUNT(DISTINCT user_session) AS total_sessions,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_session END) AS purchasing_sessions,
    COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) AS purchase_events
FROM clean_events
GROUP BY event_date
ORDER BY event_date;


-- =========================================================
-- 9. PRICE RANGE ANALYSIS (SESSION LEVEL)
-- Covers README / insights: conversion by price range
-- Assign each session a price band based on average viewed price
-- =========================================================

WITH session_price_band AS (
    SELECT
        e.user_session,
        AVG(CASE WHEN e.event_type = 'view' THEN e.price END) AS avg_view_price
    FROM clean_events e
    GROUP BY e.user_session
),
session_price_labeled AS (
    SELECT
        spb.user_session,
        CASE
            WHEN avg_view_price < 50 THEN 'Low'
            WHEN avg_view_price >= 50 AND avg_view_price <= 150 THEN 'Mid'
            ELSE 'High'
        END AS price_range
    FROM session_price_band spb
    WHERE avg_view_price IS NOT NULL
)
SELECT
    spl.price_range,
    COUNT(*) AS sessions,
    SUM(fs.purchased) AS purchasing_sessions,
    ROUND(SUM(fs.purchased) * 1.0 / COUNT(*), 4) AS conversion_rate
FROM session_price_labeled spl
JOIN funnel_session fs
    ON spl.user_session = fs.user_session
GROUP BY spl.price_range
ORDER BY conversion_rate DESC;


-- =========================================================
-- 10. BRAND PERFORMANCE (SESSION LEVEL)
-- Covers README / insights: some brands convert better
-- Each session assigned its most frequently viewed brand
-- =========================================================

WITH brand_session_counts AS (
    SELECT
        user_session,
        brand,
        COUNT(*) AS brand_events,
        ROW_NUMBER() OVER (
            PARTITION BY user_session
            ORDER BY COUNT(*) DESC, brand
        ) AS rn
    FROM clean_events
    WHERE brand IS NOT NULL
      AND brand <> ''
      AND event_type = 'view'
    GROUP BY user_session, brand
),
primary_brand_session AS (
    SELECT
        user_session,
        brand
    FROM brand_session_counts
    WHERE rn = 1
)
SELECT
    pbs.brand,
    COUNT(*) AS sessions,
    SUM(fs.purchased) AS purchasing_sessions,
    ROUND(SUM(fs.purchased) * 1.0 / COUNT(*), 4) AS conversion_rate
FROM primary_brand_session pbs
JOIN funnel_session fs
    ON pbs.user_session = fs.user_session
GROUP BY pbs.brand
HAVING COUNT(*) >= 20
ORDER BY conversion_rate DESC, sessions DESC;


-- =========================================================
-- 11. TOP BRANDS BY PURCHASE EVENTS
-- Useful supporting query for README observations
-- =========================================================

SELECT
    brand,
    COUNT(*) AS purchase_events,
    ROUND(SUM(price), 2) AS revenue
FROM clean_events
WHERE event_type = 'purchase'
  AND brand IS NOT NULL
  AND brand <> ''
GROUP BY brand
ORDER BY purchase_events DESC, revenue DESC
LIMIT 10;


-- =========================================================
-- 12. USER BEHAVIOR DEPTH
-- Covers README / insights: more interactions = higher conversion
-- =========================================================

SELECT
    total_events_in_session AS events_count,
    COUNT(*) AS sessions,
    SUM(purchased) AS purchasing_sessions,
    ROUND(SUM(purchased) * 1.0 / COUNT(*), 4) AS conversion_rate
FROM funnel_session
GROUP BY total_events_in_session
ORDER BY total_events_in_session;


-- =========================================================
-- 13. INTERACTION BUCKETS
-- Cleaner version for portfolio storytelling
-- Supports “1 interaction vs 3-4 interactions” type observation
-- =========================================================

WITH session_buckets AS (
    SELECT
        user_session,
        purchased,
        CASE
            WHEN total_events_in_session = 1 THEN '1 interaction'
            WHEN total_events_in_session = 2 THEN '2 interactions'
            WHEN total_events_in_session BETWEEN 3 AND 4 THEN '3-4 interactions'
            ELSE '5+ interactions'
        END AS interaction_bucket
    FROM funnel_session
)
SELECT
    interaction_bucket,
    COUNT(*) AS sessions,
    SUM(purchased) AS purchasing_sessions,
    ROUND(SUM(purchased) * 1.0 / COUNT(*), 4) AS conversion_rate
FROM session_buckets
GROUP BY interaction_bucket
ORDER BY
    CASE interaction_bucket
        WHEN '1 interaction' THEN 1
        WHEN '2 interactions' THEN 2
        WHEN '3-4 interactions' THEN 3
        ELSE 4
    END;


-- =========================================================
-- 14. CATEGORY / LINGUISTIC ANALYSIS
-- Simplify hierarchical category codes into main categories
-- Covers README linguistic / semantic structuring angle
-- =========================================================

WITH session_main_category AS (
    SELECT
        e.user_session,
        CASE
            WHEN e.category_code IS NULL OR e.category_code = '' THEN 'Unknown'
            WHEN INSTR(e.category_code, '.') > 0 THEN SUBSTR(e.category_code, 1, INSTR(e.category_code, '.') - 1)
            ELSE e.category_code
        END AS main_category,
        COUNT(*) AS category_events,
        ROW_NUMBER() OVER (
            PARTITION BY e.user_session
            ORDER BY COUNT(*) DESC,
                     CASE
                         WHEN e.category_code IS NULL OR e.category_code = '' THEN 'Unknown'
                         WHEN INSTR(e.category_code, '.') > 0 THEN SUBSTR(e.category_code, 1, INSTR(e.category_code, '.') - 1)
                         ELSE e.category_code
                     END
        ) AS rn
    FROM clean_events e
    WHERE e.event_type = 'view'
    GROUP BY
        e.user_session,
        CASE
            WHEN e.category_code IS NULL OR e.category_code = '' THEN 'Unknown'
            WHEN INSTR(e.category_code, '.') > 0 THEN SUBSTR(e.category_code, 1, INSTR(e.category_code, '.') - 1)
            ELSE e.category_code
        END
),
primary_category_session AS (
    SELECT
        user_session,
        main_category
    FROM session_main_category
    WHERE rn = 1
)
SELECT
    pcs.main_category,
    COUNT(*) AS sessions,
    SUM(fs.purchased) AS purchasing_sessions,
    ROUND(SUM(fs.purchased) * 1.0 / COUNT(*), 4) AS conversion_rate
FROM primary_category_session pcs
JOIN funnel_session fs
    ON pcs.user_session = fs.user_session
GROUP BY pcs.main_category
HAVING COUNT(*) >= 50
ORDER BY conversion_rate DESC, sessions DESC;


-- =========================================================
-- 15. TOP PRODUCTS BY PURCHASES
-- Supporting product-level observation
-- =========================================================

SELECT
    product_id,
    COUNT(*) AS purchase_events,
    ROUND(SUM(price), 2) AS revenue
FROM clean_events
WHERE event_type = 'purchase'
GROUP BY product_id
ORDER BY purchase_events DESC, revenue DESC
LIMIT 10;


-- =========================================================
-- 16. OPTIONAL: UNIQUE USERS VS SESSIONS
-- Helpful context if you mention users elsewhere
-- =========================================================

SELECT
    COUNT(DISTINCT user_id) AS unique_users,
    COUNT(DISTINCT user_session) AS unique_sessions
FROM clean_events;


-- =========================================================
-- END OF ANALYSIS
-- =========================================================
