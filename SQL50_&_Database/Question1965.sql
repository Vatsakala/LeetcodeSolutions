-- # Write your MySQL query statement below
WITH null_salary AS (SELECT E.employee_id
                     FROM Employees E LEFT JOIN Salaries S
                     ON E.employee_id = S.employee_id
                     WHERE S.salary IS NULL
),
null_name AS (SELECT S.employee_id
              FROM Salaries S LEFT JOIN Employees E
              ON S.employee_id = E.employee_id
              WHERE E.name IS NULL
)
SELECT * FROM null_salary
UNION
SELECT * FROM null_name
ORDER BY employee_id ASC;

-- Solution 2
# Write your MySQL query statement below
WITH null_salary AS (SELECT employee_id
                     FROM Employees 
                     WHERE employee_id NOT IN (SELECT employee_id FROM Salaries)
),
null_name AS (SELECT employee_id
              FROM Salaries
              WHERE employee_id NOT IN (SELECT employee_id FROM Employees)          
)
SELECT * FROM null_salary
UNION
SELECT * FROM null_name
ORDER BY employee_id ASC;

/*
1965. Employees With Missing Information
Solved
Easy
Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Employees

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
+-------------+---------+
employee_id is the column with unique values for this table.
Each row of this table indicates the name of the employee whose ID is employee_id.
 

Table: Salaries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| salary      | int     |
+-------------+---------+
employee_id is the column with unique values for this table.
Each row of this table indicates the salary of the employee whose ID is employee_id.
 

Write a solution to report the IDs of all the employees with missing information. The information of an employee is missing if:

The employee's name is missing, or
The employee's salary is missing.
Return the result table ordered by employee_id in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Employees table:
+-------------+----------+
| employee_id | name     |
+-------------+----------+
| 2           | Crew     |
| 4           | Haven    |
| 5           | Kristian |
+-------------+----------+
Salaries table:
+-------------+--------+
| employee_id | salary |
+-------------+--------+
| 5           | 76071  |
| 1           | 22517  |
| 4           | 63539  |
+-------------+--------+
Output: 
+-------------+
| employee_id |
+-------------+
| 1           |
| 2           |
+-------------+
Explanation: 
Employees 1, 2, 4, and 5 are working at this company.
The name of employee 1 is missing.
The salary of employee 2 is missing.
*/