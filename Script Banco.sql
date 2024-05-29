CREATE TABLE genders(
	id SERIAL PRIMARY KEY,
	name VARCHAR(25)
);

CREATE TABLE user_types(
	id SERIAL PRIMARY KEY,
	name VARCHAR(25)
);

CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	email VARCHAR(75) NOT NULL,
	document VARCHAR(18) UNIQUE NOT NULL,
	birth_date TIMESTAMP NULL,
	biography VARCHAR(511) NULL,
	profile_picture VARCHAR (511) NULL,
	user_type_id INTEGER, FOREIGN KEY (user_type_id) REFERENCES user_types(id),
	gender_id INTEGER NULL, FOREIGN KEY (gender_id) REFERENCES genders(id)
);

CREATE TABLE calendars(
	id SERIAL PRIMARY KEY,
	calendar_id VARCHAR(255),
	type VARCHAR(45),
	user_id INTEGER, FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE messages(
	id SERIAL PRIMARY KEY,
	content VARCHAR(511),
	date_time TIMESTAMP,
	recipient_id INTEGER, FOREIGN KEY (recipient_id) REFERENCES users(id),
	sender_id INTEGER, FOREIGN KEY (sender_id) REFERENCES users(id)
);

CREATE TABLE proposals(
	id SERIAL PRIMARY KEY,
	description VARCHAR(255),
	day_start_time TIMESTAMP,
	day_time_end TIMESTAMP,
	price NUMERIC(10,2),
	message_id INTEGER, FOREIGN KEY (message_id) REFERENCES messages(id)
);

CREATE TABLE ratings(
	id SERIAL PRIMARY KEY,
	rating INT,
	proposal_id INTEGER, FOREIGN KEY (proposal_id) REFERENCES proposals(id)
);

CREATE TABLE specialties(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100)
);

CREATE TABLE resumes(
	id SERIAL PRIMARY KEY,
	user_id SERIAL, FOREIGN KEY (user_id) REFERENCES users(id),
	specialtie_id INTEGER NULL, FOREIGN KEY (specialtie_id) REFERENCES specialties(id) 
);

CREATE TABLE adresses(
	id SERIAL PRIMARY KEY,
	zip_code VARCHAR(10),
	street VARCHAR(255),
	complement VARCHAR(10) NULL,
	neighborhood VARCHAR(225),
	number VARCHAR(10) NULL,
	city VARCHAR(25),
	uf VARCHAR(4)
);

CREATE TABLE residences(
	id SERIAL,
	user_id INTEGER, FOREIGN KEY (user_id) REFERENCES users(id),
	adresse_id INTEGER, FOREIGN KEY (adresse_id) REFERENCES adresses(id),
	PRIMARY KEY (id, user_id, adresse_id)
);