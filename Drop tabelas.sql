DROP TABLE elder_ly.tb_residences;
DROP TABLE elder_ly.tb_adresses;
DROP TABLE elder_ly.tb_resumes;
DROP TABLE elder_ly.tb_specialties;
DROP TABLE elder_ly.tb_proposals;
DROP TABLE elder_ly.tb_messages;
DROP TABLE elder_ly.tb_calendars;
DROP TABLE elder_ly.tb_users;
DROP TABLE elder_ly.tb_genders;
DROP TABLE elder_ly.tb_user_types;

DROP SEQUENCE IF EXISTS elder_ly.seq_co_user_type CASCADE;
DROP SEQUENCE IF EXISTS elder_ly.seq_co_gender CASCADE;
DROP SEQUENCE IF EXISTS elder_ly.seq_co_user CASCADE;
DROP SEQUENCE IF EXISTS elder_ly.seq_co_calendar CASCADE;
DROP SEQUENCE IF EXISTS elder_ly.seq_co_message CASCADE;
DROP SEQUENCE IF EXISTS elder_ly.seq_co_proposal CASCADE;
DROP SEQUENCE IF EXISTS elder_ly.seq_co_specialtie CASCADE;
DROP SEQUENCE IF EXISTS elder_ly.seq_co_resume CASCADE;
DROP SEQUENCE IF EXISTS elder_ly.seq_co_adresse CASCADE;
DROP SEQUENCE IF EXISTS elder_ly.seq_co_residence CASCADE;