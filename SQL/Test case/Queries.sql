/*Задание 1. 
1.1 Сгруппировать по месяцам количество заявок, сумму выдач, вычислить долю выдач.*/

SELECT DATE_FORMAT(create_date, '%M') AS `month`, COUNT(1) AS number_of_orders, 
SUM(index_sum) AS total_sum, SUM(index_issue)/COUNT(1) AS issue_ratio
FROM test_sql GROUP BY month ORDER BY create_date;

/*1.2 Для каждого месяца указать сумму выдач за предыдущий месяц, 
посчитать % изменения суммы выдач текущего месяца к предыдущему.*/

WITH left_part AS (
SELECT DATE_FORMAT(create_date, '%M %Y') AS previous_month, 
DATE_FORMAT(DATE_ADD(create_date, INTERVAL 1 MONTH), '%M %Y') AS `month`, 
SUM(index_sum) AS total_sum_previous_month
FROM test_sql
GROUP BY month ORDER BY create_date)
SELECT month, total_sum_previous_month, right_part.total_sum_this_month, 
ROUND((right_part.total_sum_this_month-total_sum_previous_month)/right_part.total_sum_this_month*100) AS `changes, %`
FROM left_part
LEFT JOIN (SELECT DATE_FORMAT(create_date, '%M %Y') AS this_month, 
SUM(index_sum) AS total_sum_this_month
FROM test_sql GROUP BY this_month ORDER BY create_date) AS right_part
ON month = this_month;

/*Задание 2. Добавить индикатор, который будет выделять следующие значения:
•	Если сумма по заявке больше 2000000 и дата создания заявки «март 2020» - 1
•	Если сумма по заявке больше 1000000, но меньше 2000000 и дата создания заявки «март 2020» - 2
•	Все остальные заявки не должны попасть в результат выполнения запроса.*/

SELECT * FROM (
SELECT *, IF(index_sum > 2000000 AND create_date BETWEEN '2020-03-01' AND '2020-03-31',1,0) AS indicator_1, 
IF(index_sum BETWEEN 1000000 AND 2000000 AND create_date BETWEEN '2020-03-01' AND '2020-03-31',1,0) AS indicator_2 FROM test_sql) AS tab
WHERE indicator_1 = 1 OR indicator_2 = 1;

/*Задание 3. Показать источник, через который пришло наибольшее число заявок*/

SELECT product_infosource1, COUNT(1) AS number_of_orders FROM test_sql GROUP BY product_infosource1 ORDER BY number_of_orders DESC LIMIT 1;

/*Задание 5. Исправьте ошибки в SQL запросах
select s.PRODUCT_INFOSOURCE1
     , case when st_ord=null THEN nd 
	      when st_ord LIKE ‘% % %’ THEN ‘1’ 
            when product_infosource1=’source1’ THEN ‘2’
		END 
  from test_sql s*/

SELECT product_infosource1, 
CASE WHEN st_ord IS NULL THEN 'nd'  WHEN st_ord LIKE '% % %' THEN '1' 
WHEN product_infosource1='source1' THEN '2' END FROM test_sql;

/*select d.MOBPHONE, d1.*, 1
  from table1@prod d1
  where ACC_4017_NUMBER in ('4081456878065343693')
  left join table2 d on d.ACCT_NUMBER = d1.ACC_4017_NUMBER*/

SELECT d.MOBPHONE, d1.* FROM d1 LEFT JOIN d ON d.ACCT_NUMBER = d1.ACC_4017_NUMBER
WHERE ACC_4017_NUMBER IN ('4081456878065343693');

/*select max(create_date) from(
select *, max(create_date) as max_date 
from(select cust_id, product_id, create_date from table1)
group by *)  */

SELECT cust_id, product_id, create_date FROM table1 ORDER BY create_date DESC LIMIT 1;

/*Задание 6.
a) Напишите запрос, не используя предложение WHERE, который выводит только положительные числа*/

CREATE TABLE table_num (numbers INT);
INSERT INTO table_num VALUES (1),(-21),(0),(-100),(7),(5),(0),(10),(-2),(5),(-2),(-2),(5),(0);

SELECT positive_part.numbers FROM (
SELECT ROW_NUMBER() OVER(ORDER BY numbers ASC) AS row_fac, numbers, 
IF (numbers>0, 1,0) AS positive_index FROM table_num) AS checking
INNER JOIN 
(SELECT ROW_NUMBER() OVER(ORDER BY numbers ASC) AS row_fac, numbers FROM table_num) AS positive_part
ON positive_part.numbers = checking.numbers AND positive_index>0 AND checking.row_fac=positive_part.row_fac;

/*б) Напишите запрос, не используя предложение WHERE и явные операторы соединения JOIN, который выводит только положительные числа*/

CREATE TABLE positive_numbers(numbers INT);
ALTER TABLE positive_numbers ADD CONSTRAINT check_phone CHECK (REGEXP_LIKE (numbers, '^[1-9]')); 
INSERT IGNORE INTO positive_numbers SELECT numbers FROM table_num;
SELECT * FROM positive_numbers;














