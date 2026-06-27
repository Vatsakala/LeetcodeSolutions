-- GAPS AND ISLAND QUESTOIN IMP
# Write your MySQL query statement below
WITH action_count AS (
    select user_id, action_date, action, COUNT(action) as daily_count
    FROM activity
    GROUP BY user_id, action_date, action
    HAVING COUNT(action) = 1
),
rw_number AS (
    SELECT user_id, action, action_date, ROW_NUMBER() OVER (PARTITION BY user_id, action ORDER BY action_date) as rw_number
    FROM action_count
),
streak_group AS (
SELECT *, action_date -rw_number AS streak_group
FROM rw_number
),
streak_count AS (
    SELECT *, COUNT(user_id) as streak_count, MIN(action_date) AS start_date, MAX(action_date) as end_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY COUNT(*) DESC, action_date ASC) as rnk
    FROM streak_group
    GROUP BY user_id, streak_group, action
)
SELECT user_id, action, streak_count as streak_length, start_date, end_date
FROM streak_count
WHERE streak_count > 4
AND rnk = 1
ORDER BY streak_length DESC, user_id ASC;

-- OPTIMISED VERSION
WITH numbered AS (
    SELECT
        user_id,
        action,
        action_date,
        ROW_NUMBER() OVER (
            PARTITION BY user_id, action
            ORDER BY action_date
        ) AS rn
    FROM activity
),

grouped AS (
    SELECT
        user_id,
        action,
        action_date,
        DATE_SUB(action_date, INTERVAL rn DAY) AS grp
    FROM numbered
),

streaks AS (
    SELECT
        user_id,
        action,
        MIN(action_date) AS start_date,
        MAX(action_date) AS end_date,
        COUNT(*) AS streak_length
    FROM grouped
    GROUP BY user_id, action, grp
    HAVING COUNT(*) >= 5
),

ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY streak_length DESC, start_date ASC
        ) AS rk
    FROM streaks
)

SELECT
    user_id,
    action,
    streak_length,
    start_date,
    end_date
FROM ranked
WHERE rk = 1
ORDER BY streak_length DESC,
         user_id ASC;

/*
3832. Find Users with Persistent Behavior Patterns
Solved
Hard
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| user_id      | int     |
| action_date  | date    |
| action       | varchar |
+--------------+---------+
(user_id, action_date, action) is the primary key (unique value) for this table.
Each row represents a user performing a specific action on a given date.
Write a solution to identify behaviorally stable users based on the following definition:

A user is considered behaviorally stable if there exists a sequence of at least 5 consecutive days such that:
The user performed exactly one action per day during that period.
The action is the same on all those consecutive days.
If a user has multiple qualifying sequences, only consider the sequence with the maximum length.
Return the result table ordered by streak_length in descending order, then by user_id in ascending order.

The result format is in the following example.

 

Example:

Input:

activity table:

+---------+-------------+--------+
| user_id | action_date | action |
+---------+-------------+--------+
| 1       | 2024-01-01  | login  |
| 1       | 2024-01-02  | login  |
| 1       | 2024-01-03  | login  |
| 1       | 2024-01-04  | login  |
| 1       | 2024-01-05  | login  |
| 1       | 2024-01-06  | logout |
| 2       | 2024-01-01  | click  |
| 2       | 2024-01-02  | click  |
| 2       | 2024-01-03  | click  |
| 2       | 2024-01-04  | click  |
| 3       | 2024-01-01  | view   |
| 3       | 2024-01-02  | view   |
| 3       | 2024-01-03  | view   |
| 3       | 2024-01-04  | view   |
| 3       | 2024-01-05  | view   |
| 3       | 2024-01-06  | view   |
| 3       | 2024-01-07  | view   |
+---------+-------------+--------+
Output:

+---------+--------+---------------+------------+------------+
| user_id | action | streak_length | start_date | end_date   |
+---------+--------+---------------+------------+------------+
| 3       | view   | 7             | 2024-01-01 | 2024-01-07 |
| 1       | login  | 5             | 2024-01-01 | 2024-01-05 |
+---------+--------+---------------+------------+------------+
Explanation:

User 1:
Performed login from 2024-01-01 to 2024-01-05 on consecutive days
Each day has exactly one action, and the action is the same
Streak length = 5 (meets minimum requirement)
The action changes on 2024-01-06, ending the streak
User 2:
Performed click for only 4 consecutive days
Does not meet the minimum streak length of 5
Excluded from the result
User 3:
Performed view for 7 consecutive days
This is the longest valid sequence for this user
Included in the result
The Results table is ordered by streak_length in descending order, then by user_id in ascending order
*/