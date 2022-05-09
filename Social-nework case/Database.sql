CREATE TABLE users (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100) NOT NULL COMMENT '��� ������������',
last_name VARCHAR(100) NOT NULL COMMENT '������� ������������',
birthday DATE NOT NULL COMMENT '���� ��������',
gender CHAR(1) NOT NULL COMMENT '���',
email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email ������������',
phone VARCHAR(11) NOT NULL UNIQUE COMMENT '������� ������������',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������'
-- photo
) COMMENT '������� �������������';

CREATE TABLE profiles (
user_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
city VARCHAR(100) COMMENT '����� ����������',
country VARCHAR(100) COMMENT '������ ����������',
`status` VARCHAR(10) COMMENT '������� ������',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������'
) COMMENT '������� ��������';

ALTER TABLE profiles ADD CONSTRAINT profiles_user_id FOREIGN KEY (user_id) REFERENCES users(id); 

CREATE TABLE IF NOT EXISTS friendship_request_types (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(150) NOT NULL UNIQUE COMMENT '�������� �������',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������'
) COMMENT '���� ������� �� ������'; 

CREATE TABLE IF NOT EXISTS friendship (
user_id INT UNSIGNED NOT NULL COMMENT '������ �� ���������� ��������� ���������',
friend_id INT UNSIGNED NOT NULL COMMENT '������ �� ���������� ������� � ������',
request_type VARCHAR(10) COMMENT '��� �������',
requested_at  DATETIME COMMENT '���� � ����� �������� �����������',
confirmed_at DATETIME COMMENT '���� � ����� ������������� �����������',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� � ����� �������� ������',
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� � ����� ���������� ������',
PRIMARY KEY (user_id, friend_id)
);

ALTER TABLE friendship ADD CONSTRAINT friendship_user_id FOREIGN KEY (user_id) REFERENCES users(id); 
ALTER TABLE friendship ADD CONSTRAINT friendship_friend_id FOREIGN KEY (friend_id) REFERENCES users(id); 