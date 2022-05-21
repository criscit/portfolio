/*Определить кто больше поставил лайков (всего): мужчины или женщины.
С использованием JOIN*/

WITH likes AS(
SELECT COUNT(from_user_id) AS total, 
from_user_id AS hit_like FROM like_to_user
GROUP BY hit_like
UNION ALL
SELECT COUNT(from_user_id) AS total, 
from_user_id AS hit_like FROM like_to_media
GROUP BY hit_like
UNION ALL
SELECT COUNT(from_user_id) AS total, 
from_user_id AS hit_like FROM like_to_post
GROUP BY hit_like)
SELECT u.gender, SUM(total) AS number_of_likes FROM likes
INNER JOiN users u
ON likes.hit_like = u.id
GROUP BY gender ORDER BY number_of_likes DESC LIMIT 1;


/*Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.
С использованием JOIN*/

SELECT COUNT(to_user_id) AS number_of_likes, u.*, 
FLOOR((to_days(NOW())-to_days(u.birthday))/365.25) AS age FROM like_to_user l 
INNER JOIN users u
ON u.id = l.to_user_id
WHERE FLOOR((to_days(NOW())-to_days(u.birthday))/365.25)<10
GROUP BY to_user_id ORDER BY age;

/*Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
который больше всех общался с выбранным пользователем (написал ему сообщений).
С использованием JOIN*/

SELECT u.*, m.to_user_id, COUNT(m.from_user_id) AS number_of_messages FROM users u
INNER JOIN messages m
ON m.from_user_id = u.id AND m.to_user_id = 2 GROUP BY m.from_user_id ORDER BY number_of_messages DESC LIMIT 1;

/* Определить кто больше поставил лайков (всего) - мужчины или женщины?*/

WITH likes AS(
SELECT COUNT(from_user_id) AS total, 
from_user_id AS hit_like, (SELECT gender FROM users WHERE id=like_to_user.from_user_id) AS gender FROM like_to_user
GROUP BY hit_like
UNION ALL
SELECT COUNT(from_user_id) AS total, 
from_user_id AS hit_like, (SELECT gender FROM users WHERE id=like_to_media.from_user_id) AS gender FROM like_to_media
GROUP BY hit_like
UNION ALL
SELECT COUNT(from_user_id) AS total, 
from_user_id AS hit_like, (SELECT gender FROM users WHERE id=like_to_post.from_user_id) AS gender FROM like_to_post
GROUP BY hit_like)
SELECT gender, SUM(total) AS number_of_likes FROM likes GROUP BY gender ORDER BY number_of_likes DESC LIMIT 1;

/*Пусть задан некоторый пользователь.
Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим
пользователем.*/

WITH top_communication AS(
WITH communications AS(
SELECT COUNT(to_user_id) AS total, 
from_user_id AS communication_with FROM messages WHERE to_user_id=2
GROUP BY communication_with
UNION ALL
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
SELECT id FROM users ORDER BY birthday DESC LIMIT 10)
SELECT to_user_id, COUNT(to_user_id) AS number_of_likes FROM like_to_user WHERE to_user_id IN (SELECT id FROM top_ten)
GROUP BY to_user_id ORDER BY number_of_likes DESC;