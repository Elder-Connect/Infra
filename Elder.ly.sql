DROP DATABASE elder_ly;

CREATE DATABASE elder_ly;

USE elder_ly;

CREATE TABLE genders(
id BIGINT PRIMARY KEY AUTO_INCREMENT,
gender VARCHAR (20)
);

CREATE TABLE users_types(
id BIGINT PRIMARY KEY AUTO_INCREMENT,
user_type VARCHAR (45)
);

CREATE TABLE users(
id BIGINT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR (255),
email VARCHAR (100),
password VARCHAR (8),
document VARCHAR (14),
gender_id BIGINT, FOREIGN KEY (gender_id) REFERENCES genders(id),
user_type_id BIGINT, FOREIGN KEY (user_type_id) REFERENCES users_types(id)
);

CREATE TABLE availabilities(
id BIGINT PRIMARY KEY AUTO_INCREMENT,
timestamp DATETIME,
descrition VARCHAR (255),
user_id BIGINT, FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE messages(
id BIGINT PRIMARY KEY AUTO_INCREMENT,
content VARCHAR(255),
timestamp DATETIME,
destination_id BIGINT, FOREIGN KEY (destination_id) REFERENCES users(id),
sender_id BIGINT, FOREIGN KEY (sender_id) REFERENCES users(id)
);

CREATE TABLE appointments(
id BIGINT PRIMARY KEY AUTO_INCREMENT,
descrition VARCHAR(255),
timestamp DATETIME,
caregiver_id BIGINT, FOREIGN KEY (caregiver_id) REFERENCES users(id),
client_id BIGINT, FOREIGN KEY (client_id) REFERENCES users(id)
);

CREATE TABLE specialites(
id BIGINT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR (100)
);

CREATE TABLE resumes (
user_id BIGINT, FOREIGN KEY (user_id) REFERENCES users(id),
specialtie_id BIGINT, FOREIGN KEY (specialtie_id) REFERENCES specialites(id),
CONSTRAINT PRIMARY KEY (user_id, specialtie_id) 
);