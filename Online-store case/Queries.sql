/*В учебной базе shop присутствует таблица catalogs. 
Пусть в базе данных sample имеется таблица cat, 
в которой могут присутствовать строки с такими же 
первичными ключами. Напишите запрос, который копирует 
данные из таблицы catalogs в таблицу cat, при этом 
для записей с конфликтующими первичными ключами в 
таблице cat должна производиться замена значениями из таблицы catalogs.*/

/*DROP TABLE IF EXISTS cat;
CREATE TABLE cat (
id SERIAL PRIMARY KEY,
name VARCHAR(255),
UNIQUE unique_name(name(10))
);

INSERT iNTO cat VALUES 
(NULL, 'Intel');

INSERT INTO sample.cat
SELECT * FROM shop.catalogs
ON DUPLICATE KEY UPDATE
name = VALUES(name);

SELECT * FROM sample.cat;*/

/*Cпроектируйте базу данных, которая позволяла бы хранить медиа-файлы
загружаемы пользователем (фото, аудио, фидео). Сами файлы будут
храниться в файловом хранилище, база данных предназначена для 
хранения пути к файлу, названия, описания, ключевых слов и 
принадлежности пользователю.*/

/*DROP TABLE IF EXISTS users;
CREATE TABLE users (
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT 'Имя пользователя',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Пользователи';

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
id SERIAL PRIMARY KEY,
alias VARCHAR(255) COMMENT 'Псеводоним',
name VARCHAR(255) COMMENT 'Описание медиа-типов: изображение, аудио, видео'
) COMMENT = 'Типы медиафайлов';

INSERT INTO media_types VALUES
(NULL,'image', 'Изображения'),
(NULL,'audio', 'Аудио-файлы'),
(NULL,'video', 'Видео');

DROP TABLE IF EXISTS medias;
CREATE TABLE medias (
id SERIAL PRIMARY KEY,
media_type_id INT,
user_id INT,
filename VARCHAR(255) COMMENT 'Название файла',
filesize INT COMMENT 'Размер файла',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
INDEX index_of_user_id(user_id),
INDEX index_of_media_type_id(media_type_id)
) COMMENT = 'Медиафайлы';

DROP TABLE IF EXISTS metadata;
CREATE TABLE metadata (
id SERIAL PRIMARY KEY,
media_type_id INT,
description TEXT COMMENT 'Описание',
duration INT COMMENT 'Длительность видео или аудио в секундах',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
INDEX index_of_media_type_id(media_type_id)
) COMMENT = 'Метаинформация';*/

