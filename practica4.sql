-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

COMMENT ON SCHEMA public IS 'standard public schema';

-- DROP SEQUENCE doctors_id_seq;

CREATE SEQUENCE doctors_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE doctors_id_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE doctors_id_seq TO postgres;

-- DROP SEQUENCE patient_visits_id_seq;

CREATE SEQUENCE patient_visits_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE patient_visits_id_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE patient_visits_id_seq TO postgres;

-- DROP SEQUENCE patients_id_seq;

CREATE SEQUENCE patients_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE patients_id_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE patients_id_seq TO postgres;

-- DROP SEQUENCE specialty_id_specialty_seq;

CREATE SEQUENCE specialty_id_specialty_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE specialty_id_specialty_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE specialty_id_specialty_seq TO postgres;
-- public.doctors определение

-- Drop table

-- DROP TABLE doctors;

CREATE TABLE doctors (
	id_doctor int4 DEFAULT nextval('doctors_id_seq'::regclass) NOT NULL,
	name_doctors varchar NOT NULL,
	lastname varchar NOT NULL,
	otchestvo varchar NULL,
	id_specialty serial4 NOT NULL,
	CONSTRAINT doctors_pk PRIMARY KEY (id_doctor)
);

-- Permissions

ALTER TABLE doctors OWNER TO postgres;
GRANT ALL ON TABLE doctors TO postgres;


-- public.patients определение

-- Drop table

-- DROP TABLE patients;

CREATE TABLE patients (
	id_patient int4 DEFAULT nextval('patients_id_seq'::regclass) NOT NULL,
	name_patients varchar NOT NULL,
	lastname varchar NOT NULL,
	otchestvo varchar NULL,
	date_birth date NOT NULL,
	address varchar NOT NULL,
	CONSTRAINT patients_pk PRIMARY KEY (id_patient)
);

-- Permissions

ALTER TABLE patients OWNER TO postgres;
GRANT ALL ON TABLE patients TO postgres;


-- public.patient_visits определение

-- Drop table

-- DROP TABLE patient_visits;

CREATE TABLE patient_visits (
	id serial4 NOT NULL,
	visit_date date NOT NULL,
	id_patient int4 NOT NULL,
	id_doctor int4 NOT NULL,
	price money NULL,
	CONSTRAINT patient_visits_pk PRIMARY KEY (id),
	CONSTRAINT patient_visits_doctors_fk FOREIGN KEY (id_doctor) REFERENCES doctors(id_doctor) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT patient_visits_patients_fk FOREIGN KEY (id_patient) REFERENCES patients(id_patient) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Permissions

ALTER TABLE patient_visits OWNER TO postgres;
GRANT ALL ON TABLE patient_visits TO postgres;


-- public.specialty определение

-- Drop table

-- DROP TABLE specialty;

CREATE TABLE specialty (
	id_specialty serial4 NOT NULL,
	name_specialty varchar NOT NULL,
	id_doctor serial4 NOT NULL,
	CONSTRAINT specialty_pk PRIMARY KEY (id_specialty),
	CONSTRAINT specialty_doctors_fk FOREIGN KEY (id_doctor) REFERENCES doctors(id_doctor) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT specialty_specialty_fk FOREIGN KEY (id_specialty) REFERENCES specialty(id_specialty) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Permissions

ALTER TABLE specialty OWNER TO postgres;
GRANT ALL ON TABLE specialty TO postgres;




-- Permissions

GRANT ALL ON SCHEMA public TO pg_database_owner;
GRANT USAGE ON SCHEMA public TO public;

INSERT INTO public.doctors (id_doctor,name_doctors,lastname,otchestvo,id_specialty) VALUES
	 (1,'Роман','Романов','Романович',1),
	 (2,'Игорь','Иванов','Игоревич',2),
	 (3,'Анастасия','Петрова','Евгеньевна',3),
	 (4,'Павел','Смирнов','Алексеевич',4),
	 (5,'Мария','Росткова','Юрьевна',5),
	 (6,'Оксана','Быкова','Владимировна',6),
	 (7,'Арсений','Потапов','Павлович',7),
	 (8,'Регина','Агаповна','Семеновна',8),
	 (9,'Алексей','Бирюков','Вятчеславович',9),
	 (10,'Анна','Веревочкина','Александровна',10);
INSERT INTO public.patient_visits (id,visit_date,id_patient,id_doctor,price) VALUES
	 (1,'2024-09-13',1,4,2 100,00 ?),
	 (2,'2024-09-14',2,7,4 000,00 ?),
	 (3,'2024-09-15',3,5,2 400,00 ?),
	 (4,'2024-09-19',4,10,1 500,00 ?),
	 (5,'2024-09-21',5,1,3 200,00 ?),
	 (6,'2024-09-22',6,6,1 900,00 ?),
	 (7,'2024-09-23',7,2,2 400,00 ?),
	 (8,'2024-09-26',8,3,2 000,00 ?),
	 (9,'2024-09-28',9,8,4 100,00 ?),
	 (10,'2024-10-01',10,9,3 900,00 ?);
INSERT INTO public.patients (id_patient,name_patients,lastname,otchestvo,date_birth,address) VALUES
	 (1,'Михаил','Крюков','Семенович','1999-03-12','Ленина 8'),
	 (2,'Павел','Наумов','Андреевич','1989-12-30','Фрунзе 5'),
	 (3,'Мира','Мишина','Алексеевна','2000-04-07','Гагарина 87'),
	 (4,'Ирина','Блинова','Анатольевна','1998-06-24','Мира 2А'),
	 (5,'Ваня','Щербаков','Васильевич','2001-08-10','Дружба 71'),
	 (6,'Лия','Тимофеева','Григорьева','2005-05-05','Науки 33'),
	 (7,'Игорь','Савельев','Михайлович','2003-09-16','Отдыха 15'),
	 (8,'Артем','Фадеев','Сергеевич','1995-06-15','Спортивная 8'),
	 (9,'Алексей','Белов','Александрович','1993-06-07','Цепная 6'),
	 (10,'Ева','Макарова','Алексеевна','2002-04-19','Домашняя 21');
INSERT INTO public.specialty (id_specialty,name_specialty,id_doctor) VALUES
	 (1,'кардиолог',1),
	 (2,'кардиолог',2),
	 (3,'хирург',3),
	 (4,'офтальмолог',4),
	 (5,'терапевт',5),
	 (6,'хирург',6),
	 (7,'офтальмолог',7),
	 (8,'терапевт',8),
	 (9,'офтальмолог',9),
	 (10,'терапевт',10);

