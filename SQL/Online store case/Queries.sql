/*Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
Числами Фибоначчи называется последовательность в которой число равно сумме двух
предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.*/

/*1-ый способо, рекурсивная функция*/

CREATE FUNCTION FIBONACCI (ordinal INT) 
RETURNS INT DETERMINISTIC BEGIN 
IF ordinal <= 0 THEN RETURN 0;
ELSEIF ordinal = 1 or ordinal=2 THEN RETURN 1;
ELSE RETURN FIBONACCI(ordinal - 1) + FIBONACCI(ordinal - 2);
END IF; END//

/*2-ой способ аналитическая формула*/

CREATE FUNCTION FIBONACCI (ordinal INT) 
RETURNS INT DETERMINISTIC BEGIN 
DECLARE fs DOUBLE; 
SET fs = SQRT(5);
RETURN (POW((1+fs)/2.0,ordinal)-POW((1-fs)/2.0,ordinal))/fs;
END//

/*3-ий способ*/

CREATE FUNCTION FIBONACCI (ordinal INT) 
RETURNS INT DETERMINISTIC BEGIN 
DECLARE i, fibo, first, second INT; 
CASE 
WHEN ordinal=0 or ordinal=1 THEN SET fibo = ordinal; 
WHEN ordinal >= 2 AND ordinal<=100 THEN SET first = 0; 
SET second =1; SET i=0; 
while i < ordinal - 1 DO 
SET fibo = second + first; 
SET first = second;
SET second = fibo; 
SET i = i+1;
END WHILE;
ELSE 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Number shuold be from 0 to 100';
END CASE; RETURN fibo; END//

/*В таблице products есть два текстовых поля: name с названием товара и description с его
описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля
принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь
того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям
NULL-значение необходимо отменить операцию.*/

CREATE TRIGGER upd_prod BEFORE UPDATE ON products 
FOR EACH ROW 
BEGIN 
IF NEW.name IS NULL AND NEW.description IS NULL 
THEN SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Both name and description are NULL'; 
END IF; END//
CREATE TRIGGER ins_prod BEFORE INSERT ON products 
FOR EACH ROW 
BEGIN 
IF NEW.name IS NULL AND NEW.description IS NULL
THEN SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Both name and description are NULL'; 
END IF; END//

/*Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от
текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с
12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый
вечер", с 00:00 до 6:00 — "Доброй ночи".*/

CREATE FUNCTION hello () RETURNS TINYTEXT NOT DETERMINISTIC BEGIN DECLARE hour INT;
SET hour = HOUR(NOW()); 
CASE 
WHEN hour BETWEEN 0 AND 5 THEN RETURN 'Доброй ночи';
WHEN hour BETWEEN 6 AND 11 THEN RETURN 'Доброе утро';
WHEN hour BETWEEN 12 AND 17 THEN RETURN 'Добрый день';
WHEN hour BETWEEN 18 AND 23 THEN RETURN 'Доброй вечер';
END CASE; END//

/*Пусть имеется таблица accounts содержащая три столбца id, name, password,
содержащие первичный ключ, имя пользователя и его пароль. Создайте представление
username таблицы accounts, предоставляющий доступ к столбца id и name. Создайте
пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы
извлекать записи из представления username.*/

CREATE USER 'user_read'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT (id, name) ON shop.view1 TO 'user_read'@'localhost';
DROP user 'user_read'@'localhost';

/*Создайте двух пользователей которые имеют доступ к базе данных shop. Первому
пользователю shop_read должны быть доступны только запросы на чтение данных, второму
пользователю shop — любые операции в пределах базы данных shop.*/

CREATE USER 'shop_read'@'localhost';
GRANT SELECT, SHOW VIEW ON shop.* TO 'shop_read'@'localhost';
CREATE USER 'shop'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON shop.* TO 'shop'@'localhost';


/*Пусть имеется любая таблица с календарным полем created_at. Создайте
запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих
записей.*/

DELETE users FROM users 
JOIN (SELECT created_at FROM users ORDER BY created_at DESC LIMIT 5, 1) AS deluser 
ON users.created_at <= deluser.created_at;

/*2-ой способ*/

START TRANSACTION;
PREPARE userdel FROM 'DELETE FROM users ORDER BY created_at LIMIT ?';
SET @total := (SELECT COUNT(*) FROM users) - 5;
EXECUTE userdel USING @total;
COMMIT;

/*Пусть имеется таблица с календарным полем created_at. В ней размещены
разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и
2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в
соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она
отсутствует.*/

SELECT time_period.selected_date AS date, IF (time_period.selected_date = ANY (SELECT DATE(created_at) FROM vk.users), 1, 0) AS appearance FROM
(SELECT v.* FROM 
  (SELECT ADDDATE('2018-08-01',t1.i*10 + t0.i) selected_date FROM
   (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t0,
   (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3) t1) v
  WHERE selected_date BETWEEN '2018-08-01' AND '2018-08-31') AS time_period ORDER BY date;

/*Создайте представление, которое выводит название name товарной позиции из таблицы
products и соответствующее название каталога name из таблицы catalogs.*/

CREATE OR REPLACE VIEW prod_cat AS 
SELECT p.name product, c.name catalog FROM products p
JOIN catalogs c 
ON p.catalog_id = c.id;

/*В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте
транзакции.*/

START TRANSACTION;
INSERT INTO example.users
SELECT id, name, created_at, updated_at 
FROM shop.users WHERE shop.users.id=1;
DELETE FROM shop.users WHERE id = 1;
COMMIT;

/*Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label,
name). Поля from, to и label содержат английские названия городов, поле name — русское.
Выведите список рейсов flights с русскими названиями городов.*/

SELECT id, cities_from.name, cities_to.name FROM flights
LEFT JOIN cities AS cities_from
ON flights.is_from = cities_from.label
LEFT JOIN cities AS cities_to
ON flights.is_to = cities_to.label
ORDER BY id;

/*ИЛИ*/

SELECT id,
(SELECT name FROM cities WHERE label = flights.is_from) AS `FROM`,
(SELECT name FROM cities WHERE label = flights.is_to) AS `TO`
FROM flights;

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