CREATE TABLE users (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100) NOT NULL COMMENT 'Имя пользователя',
last_name VARCHAR(100) NOT NULL COMMENT 'Фамилия пользователя',
birthday DATE NOT NULL COMMENT 'Дата рождения',
gender CHAR(1) NOT NULL COMMENT 'Пол',
email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email пользователя',
phone VARCHAR(12) NOT NULL UNIQUE COMMENT 'Телефон пользователя',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Таблица пользователей';

-- UPDATE users.phone SET phone = CONCAT('+7', 9000000000 + FLOOR(999999999 * RAND())) WHERE id > 0;

ALTER TABLE users MODIFY gender ENUM('M', 'F') NOT NULL COMMENT 'Пол';

-- ALTER TABLE users ADD CONSTRAINT check_phone CHECK (REGEXP_LIKE (phone, '^\\+7[0-9]{10}$')); -- пользовательское правило

CREATE TABLE profiles (
user_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
city VARCHAR(100) COMMENT 'Город проживания',
country VARCHAR(100) COMMENT 'Страна проживания',
`status` ENUM('Online', 'Offline', 'Inactive') NOT NULL COMMENT 'Текущий статус',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Таблица профилей';

ALTER TABLE profiles ADD CONSTRAINT profiles_user_id FOREIGN KEY (user_id) REFERENCES users(id); 

CREATE TABLE IF NOT EXISTS friendship_request_types (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(150) NOT NULL UNIQUE COMMENT 'Название статуса',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Типы запроса на дружбу'; 

CREATE TABLE IF NOT EXISTS friendship (
user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на инициатора дружеских отношений',
friend_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на поулчателя запроса о дружбе',
request_type_id INT UNSIGNED NOT NULL COMMENT 'Тип запроса',
requested_at  DATETIME NOT NULL COMMENT 'Дата и время отправки приглашения',
confirmed_at DATETIME COMMENT 'Дата и время подтверждения приглашения',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
PRIMARY KEY (user_id, friend_id)
);

ALTER TABLE friendship ADD CONSTRAINT friendship_user_id FOREIGN KEY (user_id) REFERENCES users(id); 
ALTER TABLE friendship ADD CONSTRAINT friendship_friend_id FOREIGN KEY (friend_id) REFERENCES users(id); 
ALTER TABLE friendship ADD CONSTRAINT friendship_request_type_id FOREIGN KEY (request_type_id) REFERENCES friendship_request_types(id);

CREATE TABLE IF NOT EXISTS communities (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(150) NOT NULL UNIQUE COMMENT 'Название группы',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Группы'; 

CREATE TABLE IF NOT EXISTS communitiies_users (
user_id INT UNSIGNED NOT NULL,
community_id INT UNSIGNED NOT NULL,
PRIMARY KEY(user_id, community_id),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Связь между пользователями и группами'; 

ALTER TABLE communitiies_users ADD CONSTRAINT communities_user_id FOREIGN KEY (user_id) REFERENCES users(id); 
ALTER TABLE communitiies_users ADD CONSTRAINT communities_community_id FOREIGN KEY (community_id) REFERENCES communities(id); 

CREATE TABLE IF NOT EXISTS messages (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
from_user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на отправителя сообщения',
to_user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на получателя сообщения',
body TEXT NOT NULL COMMENT 'Текст сообщения',
is_important BOOLEAN COMMENT 'Признак важности',
is_delivered BOOLEAN COMMENT 'Признак доставки',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Сообщения'; 

ALTER TABLE messages ADD CONSTRAINT messages_from_user_id FOREIGN KEY (from_user_id) REFERENCES users(id); 
ALTER TABLE messages ADD CONSTRAINT messages_to_user_id FOREIGN KEY (to_user_id) REFERENCES users(id);

CREATE TABLE IF NOT EXISTS media_types (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(150) NOT NULL UNIQUE COMMENT 'Название типа',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Типы медиафайлов'; 

CREATE TABLE IF NOT EXISTS media (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
filename VARCHAR(255) NOT NULL COMMENT 'Полный путь к файлу вместе с его названием',
media_type_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на тип медиафайла',
user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на пользователя',
metadata JSON NOT NULL COMMENT 'Метаданные',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
) COMMENT 'Медиафайлы';

ALTER TABLE media ADD CONSTRAINT media_media_type_id FOREIGN KEY (media_type_id) REFERENCES media_types(id);
ALTER TABLE media ADD CONSTRAINT media_user_id FOREIGN KEY (user_id) REFERENCES users(id);

INSERT INTO media (filename, media_type_id, user_id, metadata) VALUES(
CONCAT('https://www.some_server.com/some_directory/', SUBSTR(MD5(RAND()),1,10)), 
FLOOR(1 + RAND()*4.99),
FLOOR(1 + RAND()*99.99),
'{}');

UPDATE media
SET metadata = CONCAT('{"size" : ', FLOOR(1 + RAND()*1000000),', "extension" : "wav", "duration" : ', FLOOR(1 + RAND()*10000),'}'),
filename = CONCAT_WS('.', filename, metadata->"$.extension")
WHERE media_type_id = 1;

UPDATE media 
SET metadata = CONCAT('{"size" : ', FLOOR(1 + RAND()*1000000),', "extension" : "png", "resolution" : "', CONCAT_WS('x', FLOOR(100 + RAND()*600), FLOOR(700 + RAND()*1300)), '"}'),
filename = CONCAT_WS('.', filename, metadata->"$.extension")
WHERE media_type_id = 2;