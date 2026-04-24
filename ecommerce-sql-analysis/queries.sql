-- =========================================================
-- E-COMMERCE FUNNEL & USER BEHAVIOR ANALYSIS
-- =========================================================

-- Dataset: ecommerce
-- Columns:
-- event_time, event_type, product_id, category_id,
-- category_code, brand, price, user_id, user_session


-- =========================================================
-- 1. Preview data
-- Prompt: What does the dataset look like?
-- Why: Validate structure and data types
-- =========================================================
SELECT *
FROM ecommerce
LIMIT 10;


-- =========================================================
-- 2. Event distribution
-- Prompt: How many total events per type?
-- Why: Understand overall platform activity
-- =========================================================
SELECT 
    event_type,
    COUNT(*) AS total_events
FROM ecommerce
GROUP BY event_type
ORDER BY total_events DESC;


-- =========================================================
-- 3. Unique users per event type
-- Prompt: How many users reach each stage?
-- Why: Foundation for funnel analysis
-- =========================================================
SELECT 
    event_type,
    COUNT(DISTINCT user_id) AS unique_users
FROM ecommerce
GROUP BY event_type
ORDER BY unique_users DESC;


-- =========================================================
-- 4. Overall conversion rate
-- Prompt: What % of users convert?
-- Why: Core KPI
-- Note: User-level conversion
-- =========================================================
SELECT 
    ROUND(
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) * 1.0
        / COUNT(DISTINCT user_id),
        4
    ) AS conversion_rate
FROM ecommerce;


-- =========================================================
-- 5. Funnel counts
-- Prompt: How many users at each stage?
-- Why: Build funnel structure
-- =========================================================
SELECT 
    COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END) AS viewers,
    COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END) AS cart_users,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchasers
FROM ecommerce;


-- =========================================================
-- 6. View → Cart conversion
-- Prompt: How many viewers add to cart?
-- Why: Measure product interest conversion
-- =========================================================
SELECT 
    ROUND(
        COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END) * 1.0 /
        COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END),
        4
    ) AS view_to_cart_rate
FROM ecommerce;


-- =========================================================
-- 7. Cart → Purchase conversion
-- Prompt: How many cart users convert?
-- Why: Measure purchase intent conversion
-- =========================================================
SELECT 
    ROUND(
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) * 1.0 /
        COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END),
        4
    ) AS cart_to_purchase_rate
FROM ecommerce;


-- =========================================================
-- 8. Drop-off rates
-- Prompt: Where do users drop off?
-- Why: Identify funnel friction points
-- =========================================================
SELECT 
    ROUND(
        1 - (
            COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END) * 1.0 /
            COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END)
        ),
        4
    ) AS view_to_cart_dropoff,
    ROUND(
        1 - (
            COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) * 1.0 /
            COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END)
        ),
        4
    ) AS cart_to_purchase_dropoff
FROM ecommerce;


-- =========================================================
-- 9. Total revenue
-- Prompt: How much revenue is generated?
-- Why: Core business output
-- =========================================================
SELECT 
    ROUND(SUM(CAST(price AS REAL)), 2) AS total_revenue
FROM ecommerce
WHERE event_type = 'purchase';


-- =========================================================
-- 10. Average purchase event price
-- Prompt: What is the average price per purchase event?
-- Why: Understand pricing level
-- Important: NOT average order value per user
-- =========================================================
SELECT 
    ROUND(AVG(CAST(price AS REAL)), 2) AS avg_purchase_event_price
FROM ecommerce
WHERE event_type = 'purchase';


-- =========================================================
-- 11. Revenue by month
-- Prompt: How does revenue evolve over time?
-- Why: Identify trends
-- =========================================================
SELECT 
    SUBSTR(event_time, 1, 7) AS month,
    ROUND(SUM(CAST(price AS REAL)), 2) AS revenue
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY month
ORDER BY month;


-- =========================================================
-- 12. Purchases & revenue by month
-- Prompt: How many purchases per month?
-- Why: Compare volume vs revenue
-- =========================================================
SELECT 
    SUBSTR(event_time, 1, 7) AS month,
    COUNT(*) AS purchase_events,
    ROUND(SUM(CAST(price AS REAL)), 2) AS revenue
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY month
ORDER BY month;


-- =========================================================
-- 13. Top products
-- Prompt: Which products sell the most?
-- Why: Identify top-performing items
-- =========================================================
SELECT 
    product_id,
    COUNT(*) AS purchases,
    ROUND(SUM(CAST(price AS REAL)), 2) AS revenue
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY product_id
ORDER BY purchases DESC, revenue DESC
LIMIT 10;


-- =========================================================
-- 14. Top brands (volume)
-- Prompt: Which brands have the most purchases?
-- Why: Identify popular brands
-- =========================================================
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


-- =========================================================
-- 15. Top brands (revenue)
-- Prompt: Which brands generate most revenue?
-- Why: Identify high-value brands
-- =========================================================
SELECT 
    brand,
    ROUND(SUM(CAST(price AS REAL)), 2) AS revenue
FROM ecommerce
WHERE event_type = 'purchase'
  AND brand IS NOT NULL
  AND brand <> ''
GROUP BY brand
ORDER BY revenue DESC
LIMIT 10;


-- =========================================================
-- 16. Category revenue
-- Prompt: Which categories perform best?
-- Why: Category-level insight (limited dataset)
-- =========================================================
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


-- =========================================================
-- 17. Remove-from-cart events
-- Prompt: How often do users remove items?
-- Why: Measure hesitation
-- =========================================================
SELECT 
    COUNT(*) AS remove_from_cart_events
FROM ecommerce
WHERE event_type = 'remove_from_cart';


-- =========================================================
-- 18. Users removing items
-- Prompt: How many users remove items?
-- Why: Measure behavioral friction
-- =========================================================
SELECT 
    COUNT(DISTINCT user_id) AS users_removed
FROM ecommerce
WHERE event_type = 'remove_from_cart';


-- =========================================================
-- 19. Remove-from-cart rate
-- Prompt: What % of cart users remove items?
-- Why: Measure friction after intent
-- =========================================================
SELECT 
    ROUND(
        COUNT(DISTINCT CASE WHEN event_type = 'remove_from_cart' THEN user_id END) * 1.0 /
        COUNT(DISTINCT CASE WHEN event_type = 'cart' THEN user_id END),
        4
    ) AS remove_from_cart_rate
FROM ecommerce;


-- =========================================================
-- 20. Cart abandonment
-- Prompt: How many users cart but never purchase?
-- Why: Identify high-intent lost users
-- =========================================================
SELECT 
    COUNT(*) AS cart_no_purchase_users
FROM (
    SELECT 
        user_id,
        MAX(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS carted,
        MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased
    FROM ecommerce
    GROUP BY user_id
)
WHERE carted = 1 AND purchased = 0;


-- =========================================================
-- 21. HIGH-INTENT NON-BUYERS (NEW 🔥)
-- Prompt: Which users show strong interest but never convert?
-- Why: Most valuable CRM target segment
-- Definition:
-- - at least 3 product views (engagement)
-- - no purchase
-- =========================================================
SELECT 
    COUNT(*) AS high_intent_non_buyers
FROM (
    SELECT 
        user_id
    FROM ecommerce
    GROUP BY user_id
    HAVING 
        COUNT(CASE WHEN event_type = 'view' THEN 1 END) >= 3
        AND MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) = 0
);


-- =========================================================
-- 22. One-time vs repeat purchasers
-- Prompt: Do users purchase multiple times?
-- Why: Explore retention behavior
-- Note: Event-based, not real orders
-- =========================================================
SELECT 
    CASE 
        WHEN COUNT(*) = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS users
FROM ecommerce
WHERE event_type = 'purchase'
GROUP BY user_id;


-- =========================================================
-- 23. Session behavior
-- Prompt: What does a session look like?
-- Why: Understand interaction patterns
-- =========================================================
SELECT 
    user_session,
    COUNT(*) AS events,
    MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased
FROM ecommerce
GROUP BY user_session;


-- =========================================================
-- 24. Conversion by interaction count
-- Prompt: Does more interaction increase conversion?
-- Why: Link engagement to performance
-- =========================================================
SELECT 
    events,
    COUNT(*) AS sessions,
    SUM(purchased) AS purchases,
    ROUND(SUM(purchased) * 1.0 / COUNT(*), 4) AS conversion_rate
FROM (
    SELECT 
        user_session,
        COUNT(*) AS events,
        MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased
    FROM ecommerce
    GROUP BY user_session
)
GROUP BY events
ORDER BY events;


-- =========================================================
-- 25. Interaction buckets
-- Prompt: How does engagement level affect conversion?
-- Why: Cleaner behavioral segmentation
-- =========================================================
SELECT 
    interaction_bucket,
    COUNT(*) AS sessions,
    SUM(purchased) AS purchases,
    ROUND(SUM(purchased) * 1.0 / COUNT(*), 4) AS conversion_rate
FROM (
    SELECT 
        user_session,
        MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased,
        CASE 
            WHEN COUNT(*) = 1 THEN '1 interaction'
            WHEN COUNT(*) = 2 THEN '2 interactions'
            WHEN COUNT(*) BETWEEN 3 AND 4 THEN '3-4 interactions'
            ELSE '5+ interactions'
        END AS interaction_bucket
    FROM ecommerce
    GROUP BY user_session
)
GROUP BY interaction_bucket;


-- =========================================================
-- 26. Avg events per session (buyers vs non-buyers)
-- Prompt: How different are buyer sessions?
-- Why: Strong behavioral signal
-- =========================================================
SELECT 
    purchased,
    ROUND(AVG(events), 2) AS avg_events
FROM (
    SELECT 
        user_session,
        COUNT(*) AS events,
        MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchased
    FROM ecommerce
    GROUP BY user_session
)
GROUP BY purchased;


-- =========================================================
-- 27. Users vs sessions
-- Prompt: How many users vs sessions?
-- Why: Provide context
-- =========================================================
SELECT 
    COUNT(DISTINCT user_id) AS users,
    COUNT(DISTINCT user_session) AS sessions
FROM ecommerce;


-- ============================================
-- END OF ANALYSIS
-- ============================================
