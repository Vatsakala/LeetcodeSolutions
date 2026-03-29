--- # Write your MySQL query statement below
WITH sequence as (
    SELECT S1.id as id1 , S2.id as id2, S3.id as id3
    FROM Stadium S1 JOIN Stadium S2
    ON S2.id = S1.id + 1
    JOIN Stadium S3
    ON S3.id = S1.id + 2
    WHERE S1.people >= 100
    AND S2.people >= 100
    AND S3.people >= 100
)

SELECT * FROM Stadium
WHERE id IN (
    SELECT id1 FROM sequence
    UNION 
    SELECT id2 FROM sequence
    UNION 
    SELECT id3 FROM sequence
)
order by id;

-- ROW NUMBER LOGIC
WITH filtered_rows as (
    SELECT *, id -ROW_NUMBER() OVER (ORDER BY id) as consecutive_days
    FROM Stadium
    WHERE people >=100
) 

SELECT id, visit_date, people
from filtered_rows
WHERE consecutive_days in (
    SELECT consecutive_days 
    FROM filtered_rows
    GROUP BY consecutive_days
    HAVING COUNT(id) >= 3
)
ORDER BY visit_date;

/*
601. Human Traffic of Stadium
Solved
Hard
Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Stadium

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| visit_date    | date    |
| people        | int     |
+---------------+---------+
visit_date is the column with unique values for this table.
Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
As the id increases, the date increases as well.
 

Write a solution to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.

Return the result table ordered by visit_date in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Stadium table:
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 1    | 2017-01-01 | 10        |
| 2    | 2017-01-02 | 109       |
| 3    | 2017-01-03 | 150       |
| 4    | 2017-01-04 | 99        |
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+
Output: 
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+
Explanation: 
The four rows with ids 5, 6, 7, and 8 have consecutive ids and each of them has >= 100 people attended. Note that row 8 was included even though the visit_date was not the next day after row 7.
The rows with ids 2 and 3 are not included because we need at least three consecutive ids.
*/
