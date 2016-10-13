\c janphillipcarreon;

CREATE USER denormal_user;

DROP DATABASE IF EXISTS denormal_cars;

CREATE DATABASE denormal_cars OWNER denormal_user;

\c denormal_cars;

\i scripts/denormal_data.sql;

\dS car_models;

SELECT DISTINCT make_title
FROM car_models;

SELECT COUNT(*)
FROM (SELECT DISTINCT make_title FROM car_models) AS temp;

SELECT DISTINCT model_title
FROM car_models
WHERE make_code = 'VOLKS';

SELECT COUNT(*)
FROM (SELECT DISTINCT model_title FROM car_models WHERE make_code ='VOLKS')
AS othertemp;

SELECT make_code, model_code, model_title, year
FROM car_models
WHERE make_code = 'LAM';

SELECT COUNT (*)
FROM (SELECT make_code, model_code, model_title, year FROM car_models WHERE make_code = 'LAM')
AS temptemp;

SELECT * FROM car_models
WHERE year BETWEEN 2010 AND 2015;

SELECT COUNT (*)
FROM (SELECT * FROM car_models WHERE year BETWEEN 2010 AND 2015)
AS yearcount;