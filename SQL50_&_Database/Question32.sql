--- # Write your MySQL query statement below
SELECT DISTINCT(L1.num) as ConsecutiveNums
FROM Logs L1 JOIN LOGS L2 ON L1.id = L2.id + 1
JOIN LOGS L3 ON L1.id = L3.id + 2
WHERE L1.num = L2.num
AND L1.num = L3.num;

---Window Function Approach
SELECT DISTINCT num AS ConsecutiveNums
FROM (
  SELECT
    id,
    num,
    LAG(num, 1) OVER (ORDER BY id) AS prev1,
    LAG(num, 2) OVER (ORDER BY id) AS prev2
  FROM Logs
) t
WHERE num = prev1
  AND num = prev2;

--- Very interesting approach
SELECT num AS ConsecutiveNums
FROM (
  SELECT
    num,
    ROW_NUMBER() OVER (ORDER BY id)
    - ROW_NUMBER() OVER (PARTITION BY num ORDER BY id) AS grp
  FROM Logs
) t
GROUP BY num, grp
HAVING COUNT(*) >= 3;
/*
180. Consecutive Numbers
Solved
Medium
Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.
*/