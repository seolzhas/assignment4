CREATE TABLE car_data (
    model VARCHAR(50),
    year INT,
    price INT,
    transmission VARCHAR(20),
    mileage INT,
    fuelType VARCHAR(20),
    tax INT,
    mpg FLOAT,
    engineSize FLOAT
);

SELECT * FROM car_data LIMIT 70

SELECT AVG(price) AS average_price FROM car_data;

---

SELECT MAX(price) AS max_price, MIN(price) AS min_price FROM car_data;

---

SELECT fuel_type, AVG(mileage) AS average_mileage
FROM car_data
GROUP BY fuel_type;

---

SELECT transmission, COUNT(*) AS count_of_cars
FROM car_data
GROUP BY transmission;

---

SELECT model, MAX(price) AS max_price
FROM car_data
GROUP BY model
ORDER BY max_price DESC
LIMIT 3;

---

SELECT model, year, engine_size
FROM car_data
WHERE engine_size > 3.0
ORDER BY engine_size DESC;

---

SELECT year, COUNT(*) AS count_of_cars
FROM car_data
GROUP BY year
ORDER BY year DESC;

---

SELECT model, year, price
FROM car_data
WHERE price > 50000
ORDER BY price DESC;

---

SELECT model, AVG(engine_size) AS average_engine_size
FROM car_data
GROUP BY model
ORDER BY average_engine_size DESC;

---
 "Yearly Trend of Average Car Prices"

SELECT year, AVG(price) AS average_price
FROM car_data
GROUP BY year
ORDER BY year ASC;

---

"Cars with Both High Mileage and Low Price (Potential Good Deals)"

WITH price_quartile AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS low_price
    FROM car_data
),
mileage_quartile AS (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY mileage) AS high_mileage
    FROM car_data
)
SELECT model, year, price, mileage
FROM car_data, price_quartile, mileage_quartile
WHERE price < low_price AND mileage > high_mileage
ORDER BY mileage DESC, price ASC;

---

"Top 3 Models with the Best MPG for Engine Sizes Above 3.0"

WITH large_engines AS (
    SELECT model, year, mpg, engine_size
    FROM car_data
    WHERE engine_size > 3.0
)
SELECT model, year, mpg, engine_size
FROM large_engines
ORDER BY mpg DESC
LIMIT 3;

---

"Cars Grouped by Age Bracket"

SELECT CASE
           WHEN (2024 - year) BETWEEN 0 AND 5 THEN '0-5 years'
           WHEN (2024 - year) BETWEEN 6 AND 10 THEN '6-10 years'
           WHEN (2024 - year) BETWEEN 11 AND 15 THEN '11-15 years'
           ELSE '16+ years'
       END AS age_bracket,
       COUNT(*) AS count_of_cars
FROM car_data
GROUP BY age_bracket
ORDER BY age_bracket;



