-- CREATE SCHEMA elder_ly;

CREATE SEQUENCE elder_ly.seq_co_user_type;
CREATE TABLE elder_ly.tb_user_types(
	co_user_type BIGINT PRIMARY KEY,
	name VARCHAR(25)
);

CREATE SEQUENCE elder_ly.seq_co_gender;
CREATE TABLE elder_ly.tb_genders(
	co_gender BIGINT PRIMARY KEY,
	name VARCHAR(25)
);

CREATE SEQUENCE elder_ly.seq_co_user;
CREATE TABLE elder_ly.tb_users(
	co_user BIGINT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	email VARCHAR(75) NOT NULL,
	document VARCHAR(18) UNIQUE NOT NULL,
	birth_date DATE NULL,
	biography VARCHAR(511) NULL,
	profile_picture VARCHAR (511) NULL,
	user_type_id INTEGER, FOREIGN KEY (user_type_id) REFERENCES elder_ly.tb_user_types(co_user_type),
	gender_id INTEGER, FOREIGN KEY (gender_id) REFERENCES elder_ly.tb_genders(co_gender)
);

CREATE SEQUENCE elder_ly.seq_co_calendar;
CREATE TABLE elder_ly.tb_calendars(
	co_calendar BIGINT PRIMARY KEY,
	calendar_id VARCHAR(255),
	type VARCHAR(45),
	user_id INTEGER, FOREIGN KEY (user_id) REFERENCES elder_ly.tb_users(co_user)
);

CREATE SEQUENCE elder_ly.seq_co_message;
CREATE TABLE elder_ly.tb_messages(
	co_message BIGINT PRIMARY KEY,
	content VARCHAR(511),
	date_time TIMESTAMP,
	recipient_id INTEGER, FOREIGN KEY (recipient_id) REFERENCES elder_ly.tb_users(co_user),
	sender_id INTEGER, FOREIGN KEY (sender_id) REFERENCES elder_ly.tb_users(co_user)
);

CREATE SEQUENCE elder_ly.seq_co_proposal;
CREATE TABLE elder_ly.tb_proposals(
	co_proposal BIGINT PRIMARY KEY,
	description VARCHAR(255),
	day_start_time TIMESTAMP,
	day_time_end TIMESTAMP,
	price NUMERIC(10,2),
	accepted BOOLEAN,
	message_id INTEGER, FOREIGN KEY (message_id) REFERENCES elder_ly.tb_messages(co_message)
);

CREATE SEQUENCE elder_ly.seq_co_specialtie;
CREATE TABLE elder_ly.tb_specialties(
	co_specialtie BIGINT PRIMARY KEY,
	name VARCHAR(100)
);

CREATE SEQUENCE elder_ly.seq_co_resume;
CREATE TABLE elder_ly.tb_resumes(
	co_resume BIGINT PRIMARY KEY,
	user_id SERIAL, FOREIGN KEY (user_id) REFERENCES elder_ly.tb_users(co_user),
	specialtie_id INTEGER NULL, FOREIGN KEY (specialtie_id) REFERENCES elder_ly.tb_specialties(co_specialtie) 
);

CREATE SEQUENCE elder_ly.seq_co_adresse;
CREATE TABLE elder_ly.tb_adresses(
	co_adresse BIGINT PRIMARY KEY,
	zip_code VARCHAR(10),
	street VARCHAR(255),
	complement VARCHAR(10) NULL,
	neighborhood VARCHAR(225),
	number VARCHAR(10) NULL,
	city VARCHAR(25),
	uf VARCHAR(4)
);

CREATE SEQUENCE elder_ly.seq_co_residence;
CREATE TABLE elder_ly.tb_residences(
	co_residence BIGINT,
	user_id INTEGER, FOREIGN KEY (user_id) REFERENCES elder_ly.tb_users(co_user),
	adresse_id INTEGER, FOREIGN KEY (adresse_id) REFERENCES elder_ly.tb_adresses(co_adresse),
	PRIMARY KEY (co_residence, user_id, adresse_id)
);