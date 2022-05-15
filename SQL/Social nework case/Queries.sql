/*Пусть задан некоторый пользователь.
Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим
пользователем.*/

WITH top_communication AS(
WITH communications AS(
SELECT COUNT(to_user_id) AS total, 
from_user_id AS communication_with FROM messages WHERE to_user_id=2
GROUP BY communication_with
UNION
SELECT COUNT(from_user_id) AS total, 
to_user_id AS communication_with FROM messages WHERE from_user_id=2
GROUP BY communication_with)
SELECT communication_with, SUM(total) AS number_of_communications FROM communications 
GROUP BY communication_with 
ORDER BY number_of_communications DESC
LIMIT 1)
SELECT id, first_name, last_name FROM users WHERE id IN (
SELECT communication_with FROM top_communication);

/*Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.*/

WITH top_ten AS (
SELECT id, TIMESTAMPDIFF(YEAR, birthday, NOW()) AS age FROM users ORDER BY age LIMIT 10)
SELECT to_user_id, COUNT(to_user_id) AS number_of_likes FROM like_to_user WHERE to_user_id IN (SELECT id FROM top_ten)
GROUP BY to_user_id ORDER BY number_of_likes DESC;