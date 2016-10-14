\c janphillipcarreon

DROP USER IF EXISTS normal_user;

CREATE USER normal_user;

DROP DATABASE IF EXISTS normal_cars;

CREATE DATABASE normal_cars OWNER normal_user;

\c normal_cars;

\i scripts/denormal_data.sql;

-- DROP TABLE IF EXISTS make, models;

CREATE TABLE make(
  make_code character varying(125) NOT NULL,
  make_title character varying(125) NOT NULL,
  id serial NOT NULL PRIMARY KEY
);

INSERT INTO make (make_code, make_title)
SELECT DISTINCT make_code, make_title
FROM car_models;


CREATE TABLE models (
  id  serial  NOT NULL  PRIMARY KEY,
  model_code character varying(125)  NOT NULL,
  model_title  character varying(125)  NOT NULL,
  year  integer  NOT NULL,
  make_id  integer  REFERENCES  make (id)
);

INSERT INTO models (model_code, model_title, year, make_id)
SELECT DISTINCT
  model_code,
  model_title,
  year,
  make.id
FROM car_models INNER JOIN make ON (make.make_code = car_models.make_code);


SELECT *
FROM models
WHERE models.year BETWEEN 2010 AND 2015
ORDER BY models.year;

SELECT COUNT (*)
FROM (SELECT make_title FROM make)
AS count1;

SELECT COUNT (*)
FROM (SELECT DISTINCT model_title FROM models INNER JOIN make ON (models.make_id = make.id)
WHERE make.make_code = 'VOLKS')
AS count2;

SELECT COUNT (*)
FROM (SELECT DISTINCT make_code, model_code, model_title, year FROM models INNER JOIN make ON (models.make_id = make.id) WHERE make.make_code = 'LAM')
AS count3;

SELECT COUNT (*)
FROM (SELECT * FROM models INNER JOIN make ON (models.make_id = make.id) WHERE models.year BETWEEN 2010 AND 2015)
AS yearcount;




