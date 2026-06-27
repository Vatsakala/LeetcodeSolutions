-- # Write your MySQL query statement below
WITH user_with_reaction as (
    SELECT user_id, content_id, COUNT(reaction) AS total_reaction
    FROM reactions
    GROUP BY user_id
    HAVING COUNT(reaction) >= 5
),

each_reaction_type_count as (
    SELECT user_id, reaction, COUNT(reaction) as cnt, RANK() OVER (PARTITION BY user_id ORDER BY count(*) DESC) as rnk
    FROM reactions
    GROUP BY user_id, reaction
)
SELECT U.user_id, E.reaction as dominant_reaction, ROUND(cnt/total_reaction , 2) as reaction_ratio
FROM user_with_reaction U JOIN each_reaction_type_count E
on U.user_id = E.user_id
WHERE cnt/total_reaction >= 0.6
AND E.rnk = 1
ORDER by reaction_ratio DESC, user_id ASC

/*
3808. Find Emotionally Consistent Users
Solved
Medium
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: reactions

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| user_id      | int     |
| content_id   | int     |
| reaction     | varchar |
+--------------+---------+
(user_id, content_id) is the primary key (unique value) for this table.
Each row represents a reaction given by a user to a piece of content.
Write a solution to identify emotionally consistent users based on the following requirements:

For each user, count the total number of reactions they have given.
Only include users who have reacted to at least 5 different content items.
A user is considered emotionally consistent if at least 60% of their reactions are of the same type.
Return the result table ordered by reaction_ratio in descending order and then by user_id in ascending order.

Note:

reaction_ratio should be rounded to 2 decimal places
The result format is in the following example.

 

Example:

Input:

reactions table:

+---------+------------+----------+
| user_id | content_id | reaction |
+---------+------------+----------+
| 1       | 101        | like     |
| 1       | 102        | like     |
| 1       | 103        | like     |
| 1       | 104        | wow      |
| 1       | 105        | like     |
| 2       | 201        | like     |
| 2       | 202        | wow      |
| 2       | 203        | sad      |
| 2       | 204        | like     |
| 2       | 205        | wow      |
| 3       | 301        | love     |
| 3       | 302        | love     |
| 3       | 303        | love     |
| 3       | 304        | love     |
| 3       | 305        | love     |
+---------+------------+----------+
Output:

+---------+-------------------+----------------+
| user_id | dominant_reaction | reaction_ratio |
+---------+-------------------+----------------+
| 3       | love              | 1.00           |
| 1       | like              | 0.80           |
+---------+-------------------+----------------+
Explanation:

User 1:
Total reactions = 5
like appears 4 times
reaction_ratio = 4 / 5 = 0.80
Meets the 60% consistency requirement
User 2:
Total reactions = 5
Most frequent reaction appears only 2 times
reaction_ratio = 2 / 5 = 0.40
Does not meet the consistency requirement
User 3:
Total reactions = 5
'love' appears 5 times
reaction_ratio = 5 / 5 = 1.00
Meets the consistency requirement
The Results table is ordered by reaction_ratio in descending order, then by user_id in ascending order.
*/