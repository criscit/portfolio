CREATE TABLE users (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100) NOT NULL COMMENT 'Имя пользователя',
last_name VARCHAR(100) NOT NULL COMMENT 'Фамилия пользователя',
birthday DATE NOT NULL COMMENT 'Дата рождения',
gender CHAR(1) NOT NULL COMMENT 'Пол',
email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email пользователя',
phone VARCHAR(11) NOT NULL UNIQUE COMMENT 'Телефон пользователя',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки'
-- photo
) COMMENT 'Таблица пользователей';

CREATE TABLE profiles (
user_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
city VARCHAR(100) COMMENT 'Город проживания',
country VARCHAR(100) COMMENT 'Страна проживания',
`status` VARCHAR(10) COMMENT 'Текущий статус',
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
request_type VARCHAR(10) COMMENT 'Тип запроса',
requested_at  DATETIME COMMENT 'Дата и время отправки приглашения',
confirmed_at DATETIME COMMENT 'Дата и время подтверждения приглашения',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата и время обновления строки',
PRIMARY KEY (user_id, friend_id)
);

ALTER TABLE friendship ADD CONSTRAINT friendship_user_id FOREIGN KEY (user_id) REFERENCES users(id); 
ALTER TABLE friendship ADD CONSTRAINT friendship_friend_id FOREIGN KEY (friend_id) REFERENCES users(id); 