-- Write your MySQL query statement below
WITH cte AS (
    SELECT account_id, (CASE 
                       WHEN income < 20000 THEN 'Low Salary'
                       WHEN income > 50000 THEN 'High Salary'
                       ELSE 'Average Salary' END) AS `category`
    FROM Accounts
),
categories AS (
    SELECT 'Low Salary' as category
    UNION SELECT 'Average Salary'
    UNION SELECT 'High Salary'
)

SELECT C1.category, COUNT(C2.account_id) as accounts_count
FROM categories C1 LEFT JOIN cte C2
ON C1.category = C2.category
GROUP BY C1.category; 

-- logic 1 master category table with case when other is union all the tables with results
WITH low AS (
    SELECT 'Low Salary' AS category, COUNT(account_id) AS accounts_count
    FROM Accounts
    WHERE income < 20000
),
`avg` AS (
    SELECT 'Average Salary' AS category, COUNT(account_id) AS accounts_count
    FROM Accounts
    WHERE income BETWEEN 20000 AND 50000
),
high AS (
    SELECT 'High Salary' AS category, COUNT(account_id) AS accounts_count
    FROM Accounts
    WHERE income > 50000
)
SELECT * FROM low
UNION
SELECT * FROM `avg`
UNION
SELECT * FROM high
/*
1907. Count Salary Categories
Solved
Medium
Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Accounts

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.
 

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Accounts table:
+------------+--------+
| account_id | income |
+------------+--------+
| 3          | 108939 |
| 2          | 12747  |
| 8          | 87709  |
| 6          | 91796  |
+------------+--------+
Output: 
+----------------+----------------+
| category       | accounts_count |
+----------------+----------------+
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |
+----------------+----------------+
Explanation: 
Low Salary: Account 2.
Average Salary: No accounts.
High Salary: Accounts 3, 6, and 8.
*/