/*Подсчитайте произведение чисел в столбце таблицы.*/

SELECT ROUND(EXP(SUM(LN(id)))) FROM media_types;

/*Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/

SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday))), '%W') AS day,
 COUNT(*) AS total FROM users GROUP by day ORDER BY total DESC;

/* ИЛИ */

SELECT COUNT(*), 
DAYNAME(CONCAT(DATE_FORMAT(NOW(), '%Y'),'-', 
DATE_FORMAT(birthday, '%m'),'-', 
DATE_FORMAT(birthday, '%d'))) 
AS day_of_week FROM users GROUP BY day_of_week WITH ROLLUP;

/*Подсчитайте средний возраст пользователей в таблице users*/

SELECT AVG(TIMESTAMODIFF(YEAR, birthday, NOW())) FROM users;

/*ИЛИ*/

SELECT ROUND(AVG((TO_DAYS(NOW())-TO_DAYS(birthday))/365.25)) AS avg_age FROM users;

/*Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM
catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.*/

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);

/*Из таблицы users необходимо извлечь пользователей, родившихся в августе и
мае. Месяцы заданы в виде списка английских названий (may, august)*/

SELECT name FROM users WHERE DATE_FORMAT(birthday, '%M') IN ('may', 'august');

/*В таблице складских запасов storehouses_products в поле value могут встречаться самые
разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке
увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех
записей.*/

SELECT * FROM storehouses_products ORDER BY IF(value > 0, 0, 1), value;

/*Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы
типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10.
Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.*/

UPDATE users SET 
created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE users MODIFY created_at  DATETIME;
ALTER TABLE users MODIFY updated_at  DATETIME;

/*ИЛИ*/

UPDATE users SET 
created_at = CONCAT(SUBSTRING(created_at, 7,4),'-',SUBSTRING(created_at, 4,2),'-', SUBSTRING(created_at, 1,2), SUBSTRING(created_at, 11,6)), 
updated_at = CONCAT(SUBSTRING(updated_at, 7,4),'-',SUBSTRING(updated_at, 4,2),'-', SUBSTRING(updated_at, 1,2), SUBSTRING(updated_at, 11,6)) WHERE id>0;

ALTER TABLE users MODIFY created_at  DATETIME;
ALTER TABLE users MODIFY updated_at  DATETIME;

/*В учебной базе shop присутствует таблица catalogs. 
Пусть в базе данных sample имеется таблица cat, 
в которой могут присутствовать строки с такими же 
первичными ключами. Напишите запрос, который копирует 
данные из таблицы catalogs в таблицу cat, при этом 
для записей с конфликтующими первичными ключами в 
таблице cat должна производиться замена значениями из таблицы catalogs.*/

DROP TABLE IF EXISTS cat;
CREATE TABLE cat (
id SERIAL PRIMARY KEY,
name VARCHAR(255),
UNIQUE unique_name(name(10)));

INSERT iNTO cat VALUES 
(NULL, 'Intel');

INSERT INTO sample.cat
SELECT * FROM shop.catalogs
ON DUPLICATE KEY UPDATE
name = VALUES(name);

SELECT * FROM sample.cat;