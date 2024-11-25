-- init.sql

CREATE SCHEMA elder_ly;

CREATE SEQUENCE elder_ly.seq_co_user_type;
CREATE SEQUENCE elder_ly.seq_co_gender;
CREATE SEQUENCE elder_ly.seq_co_user;
CREATE SEQUENCE elder_ly.seq_co_calendar;
CREATE SEQUENCE elder_ly.seq_co_message;
CREATE SEQUENCE elder_ly.seq_co_proposal;
CREATE SEQUENCE elder_ly.seq_co_specialtie;
CREATE SEQUENCE elder_ly.seq_co_resume;
CREATE SEQUENCE elder_ly.seq_co_adresse;
CREATE SEQUENCE elder_ly.seq_co_residence;
CREATE SEQUENCE elder_ly.seq_co_profit;

CREATE TABLE elder_ly.tb_user_types(
    co_user_type BIGINT PRIMARY KEY DEFAULT nextval('elder_ly.seq_co_user_type'),
    name VARCHAR(25)
);

CREATE TABLE elder_ly.tb_genders(
    co_gender BIGINT PRIMARY KEY DEFAULT nextval('elder_ly.seq_co_gender'),
    name VARCHAR(25)
);

CREATE TABLE elder_ly.tb_users(
    co_user BIGINT PRIMARY KEY DEFAULT nextval('elder_ly.seq_co_user'),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(75) NOT NULL,
    document VARCHAR(18) UNIQUE NOT NULL,
    birth_date DATE NULL,
    biography VARCHAR(511) NULL,
    profile_picture VARCHAR(511) NULL,
    user_type_id BIGINT REFERENCES elder_ly.tb_user_types(co_user_type),
    gender_id BIGINT REFERENCES elder_ly.tb_genders(co_gender)
);

CREATE TABLE elder_ly.tb_calendars(
    co_calendar BIGINT PRIMARY KEY DEFAULT nextval('elder_ly.seq_co_calendar'),
    calendar_id VARCHAR(255),
    type VARCHAR(45),
    user_id BIGINT REFERENCES elder_ly.tb_users(co_user)
);

CREATE TABLE elder_ly.tb_messages(
    co_message BIGINT PRIMARY KEY DEFAULT nextval('elder_ly.seq_co_message'),
    content VARCHAR(511),
    date_time TIMESTAMP,
    recipient_id BIGINT REFERENCES elder_ly.tb_users(co_user),
    sender_id BIGINT REFERENCES elder_ly.tb_users(co_user)
);

CREATE TABLE elder_ly.tb_proposals(
    co_proposal BIGINT PRIMARY KEY DEFAULT nextval('elder_ly.seq_co_proposal'),
    description VARCHAR(255),
    day_start_time TIMESTAMP,
    day_time_end TIMESTAMP,
    price NUMERIC(10,2),
    accepted BOOLEAN,
    message_id BIGINT REFERENCES elder_ly.tb_messages(co_message)
);

CREATE TABLE elder_ly.tb_specialties(
    co_specialtie BIGINT PRIMARY KEY DEFAULT nextval('elder_ly.seq_co_specialtie'),
    name VARCHAR(100)
);

CREATE TABLE elder_ly.tb_resumes(
    co_resume BIGINT PRIMARY KEY DEFAULT nextval('elder_ly.seq_co_resume'),
    user_id BIGINT REFERENCES elder_ly.tb_users(co_user),
    specialtie_id BIGINT NULL REFERENCES elder_ly.tb_specialties(co_specialtie)
);

CREATE TABLE elder_ly.tb_adresses(
    co_adresse BIGINT PRIMARY KEY DEFAULT nextval('elder_ly.seq_co_adresse'),
    zip_code VARCHAR(10),
    street VARCHAR(255),
    complement VARCHAR(10) NULL,
    neighborhood VARCHAR(225),
    number VARCHAR(10) NULL,
    city VARCHAR(25),
    uf VARCHAR(4)
);

CREATE TABLE elder_ly.tb_residences(
    co_residence BIGINT DEFAULT nextval('elder_ly.seq_co_residence'),
    user_id BIGINT REFERENCES elder_ly.tb_users(co_user),
    adresse_id BIGINT REFERENCES elder_ly.tb_adresses(co_adresse),
    PRIMARY KEY (co_residence, user_id, adresse_id)
);

CREATE TABLE elder_ly.tb_profit(
    co_profit BIGINT PRIMARY KEY DEFAULT nextval('elder_ly.seq_co_profit'),
	profit DECIMAL (15, 2),
    user_id BIGINT REFERENCES elder_ly.tb_users(co_user)
);

INSERT INTO elder_ly.tb_genders (name) values
('Masculino'),
('Feminino'),
('Prefiro não informar');

INSERT INTO elder_ly.tb_user_types (name) values
('ADM'),
('Colaborador'),
('Cliente');