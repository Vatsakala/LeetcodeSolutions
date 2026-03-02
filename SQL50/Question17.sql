--- Write your MySQL query statement below
SELECT R.contest_id, ROUND(COUNT(user_id) * 100/(SELECT COUNT(user_id) from Users) ,2) as percentage
FROM register R
GROUP BY R.contest_id
ORDER BY percentage DESC, R.contest_id ASC;

/* GROUP BY CONCEPT EXPLAINED
Yes — that’s basically the right mental model.

A cleaner way to say it:

GROUP BY picks the “label” (the column(s) you group on), e.g. contest_id.
It splits the rows into buckets by that label:

all rows with contest_id = 208 in one bucket

all rows with contest_id = 209 in another bucket

Aggregate functions like COUNT, SUM, AVG are computed inside each bucket.

Then SQL outputs one row per bucket, containing:

the group label (contest_id)

the aggregate results (COUNT(*), etc.)

Example for Register:

Rows:

(208,2), (208,6), (208,7), (209,2)

Buckets:

208 bucket has 3 rows → COUNT(*) = 3

209 bucket has 1 row → COUNT(*) = 1

Output becomes:

contest_id	COUNT(*)
208	3
209	1

So yes: separate → aggregate → “smoosh” into one row per group.
*/

/*
1633. Percentage of Users Attended a Contest
Solved
Easy
Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Users

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| user_name   | varchar |
+-------------+---------+
user_id is the primary key (column with unique values) for this table.
Each row of this table contains the name and the id of a user.
 

Table: Register

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| contest_id  | int     |
| user_id     | int     |
+-------------+---------+
(contest_id, user_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id of a user and the contest they registered into.
 

Write a solution to find the percentage of the users registered in each contest rounded to two decimals.

Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Users table:
+---------+-----------+
| user_id | user_name |
+---------+-----------+
| 6       | Alice     |
| 2       | Bob       |
| 7       | Alex      |
+---------+-----------+
Register table:
+------------+---------+
| contest_id | user_id |
+------------+---------+
| 215        | 6       |
| 209        | 2       |
| 208        | 2       |
| 210        | 6       |
| 208        | 6       |
| 209        | 7       |
| 209        | 6       |
| 215        | 7       |
| 208        | 7       |
| 210        | 2       |
| 207        | 2       |
| 210        | 7       |
+------------+---------+
Output: 
+------------+------------+
| contest_id | percentage |
+------------+------------+
| 208        | 100.0      |
| 209        | 100.0      |
| 210        | 100.0      |
| 215        | 66.67      |
| 207        | 33.33      |
+------------+------------+
Explanation: 
All the users registered in contests 208, 209, and 210. The percentage is 100% and we sort them in the answer table by contest_id in ascending order.
Alice and Alex registered in contest 215 and the percentage is ((2/3) * 100) = 66.67%
Bob registered in contest 207 and the percentage is ((1/3) * 100) = 33.33%
*/