/*� ������� ���� shop ������������ ������� catalogs. 
����� � ���� ������ sample ������� ������� cat, 
� ������� ����� �������������� ������ � ������ �� 
���������� �������. �������� ������, ������� �������� 
������ �� ������� catalogs � ������� cat, ��� ���� 
��� ������� � �������������� ���������� ������� � 
������� cat ������ ������������� ������ ���������� �� ������� catalogs.*/

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

/*C������������ ���� ������, ������� ��������� �� ������� �����-�����
���������� ������������� (����, �����, �����). ���� ����� �����
��������� � �������� ���������, ���� ������ ������������� ��� 
�������� ���� � �����, ��������, ��������, �������� ���� � 
�������������� ������������.*/

/*DROP TABLE IF EXISTS users;
CREATE TABLE users (
id SERIAL PRIMARY KEY,
name VARCHAR(255) COMMENT '��� ������������',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '������������';

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
id SERIAL PRIMARY KEY,
alias VARCHAR(255) COMMENT '����������',
name VARCHAR(255) COMMENT '�������� �����-�����: �����������, �����, �����'
) COMMENT = '���� �����������';

INSERT INTO media_types VALUES
(NULL,'image', '�����������'),
(NULL,'audio', '�����-�����'),
(NULL,'video', '�����');

DROP TABLE IF EXISTS medias;
CREATE TABLE medias (
id SERIAL PRIMARY KEY,
media_type_id INT,
user_id INT,
filename VARCHAR(255) COMMENT '�������� �����',
filesize INT COMMENT '������ �����',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
INDEX index_of_user_id(user_id),
INDEX index_of_media_type_id(media_type_id)
) COMMENT = '����������';

DROP TABLE IF EXISTS metadata;
CREATE TABLE metadata (
id SERIAL PRIMARY KEY,
media_type_id INT,
description TEXT COMMENT '��������',
duration INT COMMENT '������������ ����� ��� ����� � ��������',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
INDEX index_of_media_type_id(media_type_id)
) COMMENT = '��������������';*/

