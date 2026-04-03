--- Write your MySQL query statement below
WITH first_orders AS (
    SELECT customer_id, MIN(order_date) as min_order_date
    FROM Delivery
    GROUP BY customer_id
),
immediate_first AS (
    SELECT D.customer_id
    FROM Delivery D JOIN first_orders F
    ON D.customer_id = F.customer_id
    AND D.order_date = F.min_order_date
    AND D.customer_pref_delivery_date = F.min_order_date
)
SELECT ROUND(
    ((SELECT Count(*) FROM immediate_first)/
    (SELECT Count(*) FROM first_orders))*100,
    2) AS immediate_percentage;