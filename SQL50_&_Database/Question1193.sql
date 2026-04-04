--- # Write your MySQL query statement below
WITH total_transaction_amt AS (
    SELECT DATE_FORMAT(trans_date, '%Y-%m') as 'month', country, COUNT(trans_date) as trans_count, SUM(amount) as trans_total_amount
    FROM Transactions
    GROUP BY month, country
),
approved_transaction_amt AS (
    SELECT DATE_FORMAT(trans_date, '%Y-%m') as 'month', country, COUNT(trans_date) as approved_count, SUM(amount) as approved_total_amount
    FROM Transactions
    WHERE state = "approved"
    GROUP BY month, country
    
)
SELECT TA.month, TA.country, TA.trans_count, COALESCE(AA.approved_count, 0) AS approved_count, TA.trans_total_amount, COALESCE(AA.approved_total_amount, 0) as approved_total_amount
FROM total_transaction_amt TA LEFT JOIN approved_transaction_amt AA
ON TA.month = AA.month 
AND TA.country <=> AA.country

--- IDEAL SOLUTION
SELECT DATE_FORMAT(trans_date, '%Y-%m') as 'month', country, COUNT(trans_date) as trans_count, SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) as approved_count, SUM(amount) as trans_total_amount, SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) as approved_total_amount
FROM Transactions
GROUP BY `month`, country

/*
1193. Monthly Transactions I
Solved
Medium
Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Transactions

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
 

Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |
+------+---------+----------+--------+------------+
Output: 
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+
*/