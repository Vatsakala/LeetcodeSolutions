-- # Write your MySQL query statement below
WITH adding_season AS (
    SELECT *, CASE 
                WHEN MONTH(sale_date) IN (12, 1, 2) THEN "Winter"
                WHEN MONTH(sale_date) IN (3, 4, 5) THEN "Spring"
                WHEN MONTH(sale_date) IN (6, 7, 8) THEN "Summer"
                WHEN MONTH(sale_date) IN (9, 10, 11) THEN "Fall" 
              END AS season
    FROM sales         
),
season_category_sales AS(
    SELECT A.season, P.category, SUM(A.quantity) as total_quantity, SUM(A.quantity*A.price) as total_revenue
    FROM adding_season A JOIN Products P
    ON A.product_id = P.product_id 
    GROUP BY season, category
),
assign_rank AS (
    SELECT *, RANK() OVER (PARTITION BY season ORDER BY total_quantity DESC, total_revenue DESC, category ASC) as rnk
    FROM season_category_sales
)
SELECT season, category, total_quantity, total_revenue
FROM assign_rank
WHERE rnk = 1
ORDER BY season ASC;
