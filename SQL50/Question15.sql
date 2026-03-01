--- BE CAREFUL USING WHERE WITH AN LEFT JOIN: check submission histroy leetocde
-- ON VS WHERE LOGIC
/*
The decision rule: ON vs WHERE
Put a condition in ON when it is part of the match logic

Ask: “Does this condition define which right-table rows are allowed to match a left-table row?”

If yes → ON.

Especially important with LEFT JOIN, because ON decides what matches, while still keeping the left rows.

Put a condition in WHERE when it is a final filter on the output rows

Ask: “Do I want to remove rows from the final result entirely?”

If yes → WHERE.

Safe to use for left-table-only filters.

Dangerous when it references right-table columns in a LEFT JOIN (can turn it into an inner join).
*/
---Write your MySQL query statement below
SELECT P.product_id, IFNULL( ROUND(SUM(U.units*P.price)/SUM(U.units) ,2), 0) as average_price
FROM Prices P LEFT JOIN UnitsSold U on P.product_id = U.product_id and purchase_date BETWEEN P.start_date and P.end_date
Group by P.product_id;

/*
1251. Average Selling Price
Solved
Easy
Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Prices

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| start_date    | date    |
| end_date      | date    |
| price         | int     |
+---------------+---------+
(product_id, start_date, end_date) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the price of the product_id in the period from start_date to end_date.
For each product_id there will be no two overlapping periods. That means there will be no two intersecting periods for the same product_id.
 

Table: UnitsSold

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| purchase_date | date    |
| units         | int     |
+---------------+---------+
This table may contain duplicate rows.
Each row of this table indicates the date, units, and product_id of each product sold. 
 

Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places. If a product does not have any sold units, its average selling price is assumed to be 0.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Prices table:
+------------+------------+------------+--------+
| product_id | start_date | end_date   | price  |
+------------+------------+------------+--------+
| 1          | 2019-02-17 | 2019-02-28 | 5      |
| 1          | 2019-03-01 | 2019-03-22 | 20     |
| 2          | 2019-02-01 | 2019-02-20 | 15     |
| 2          | 2019-02-21 | 2019-03-31 | 30     |
+------------+------------+------------+--------+
UnitsSold table:
+------------+---------------+-------+
| product_id | purchase_date | units |
+------------+---------------+-------+
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |
+------------+---------------+-------+
Output: 
+------------+---------------+
| product_id | average_price |
+------------+---------------+
| 1          | 6.96          |
| 2          | 16.96         |
+------------+---------------+
Explanation: 
Average selling price = Total Price of Product / Number of products sold.
Average selling price for product 1 = ((100 * 5) + (15 * 20)) / 115 = 6.96
Average selling price for product 2 = ((200 * 15) + (30 * 30)) / 230 = 16.96

*/