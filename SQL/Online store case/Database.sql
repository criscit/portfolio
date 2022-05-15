DROP TABLE IF EXISTS users;
CREATE TABLE users (
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Имя покупателя',
birthday DATE COMMENT 'Дата рождения',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Название раздела',
UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT iNTO catalogs VALUES 
(NULL, 'Процессоры'),
(NULL, 'Мат. платы'),
(NULL, 'Вентиляторы'),
(NULL, 'Батареи'),
(DEFAULT, 'Видеокарты');

SELECT * FROM catalogs ORDER BY FIELD(id, 5, 1, 2);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Название',
descriprion TEXT COMMENT 'Описание',
price DECIMAL(11,2) COMMENT 'Цена',
catalog_id INT UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Товарные позиции';

CREATE INDEX index_of_catalog_id USING BTREE ON products (catalog_id);
-- CREATE INDEX index_of_catalog_id USING HASH ON products (catalog_id);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
id SERIAL PRIMARY KEY,
user_id INT UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
id SERIAL PRIMARY KEY,
order_id INT UNSIGNED,
product_id INT UNSIGNED,
total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товраных позиций',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP/* ,
 KEY order_id(order_id, product_id),
KEY product_id(product_id, order_id) */
) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
id SERIAL PRIMARY KEY,
user_id INT UNSIGNED,
product_id INT UNSIGNED,
discount FLOAT COMMENT 'Величина скидки от 0.0 до 1.0',
started_at DATETIME,
finished_at DATETIME,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
KEY index_of_user_id(user_id),
KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Название',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
id SERIAL PRIMARY KEY,
storehouse_id INT UNSIGNED,
product_id INT UNSIGNED,
value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

DROP TABLE IF EXISTS files_of_users;
CREATE TABLE files_of_users (
id SERIAL PRIMARY KEY,
storehouse_id INT UNSIGNED,
product_id INT UNSIGNED,
value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

DROP TABLE IF EXISTS files_of_users;
CREATE TABLE files_of_users (
id SERIAL PRIMARY KEY,
storehouse_id INT UNSIGNED,
product_id INT UNSIGNED,
value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';