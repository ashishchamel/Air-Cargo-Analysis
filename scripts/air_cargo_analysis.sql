CREATE DATABASE AirCargo;
USE AirCargo;

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender CHAR(1)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer.csv'
INTO TABLE customer
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE routes (
    route_id INT PRIMARY KEY,
    flight_num INT,
    origin_airport VARCHAR(10),
    destination_airport VARCHAR(10),
    aircraft_id VARCHAR(20),
    distance_miles INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/routes.csv'
INTO TABLE routes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE passengers_on_flights (
    customer_id INT,
    aircraft_id VARCHAR(20),
    route_id INT,
    depart VARCHAR(10),
    arrival VARCHAR(10),
    seat_num VARCHAR(10),
    class_id VARCHAR(20),
    travel_date DATE,
    flight_num INT,
    PRIMARY KEY (customer_id, flight_num),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/passengers_on_flights.csv'
INTO TABLE passengers_on_flights
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE ticket_details (
    p_date DATE,
    customer_id INT,
    aircraft_id VARCHAR(20),
    class_id VARCHAR(20),
    no_of_tickets INT,
    a_code VARCHAR(10),
    price_per_ticket DECIMAL(10,2),
    brand VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ticket_details.csv'
INTO TABLE ticket_details
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE ticket_details
CHANGE COLUMN a_code airport_code VARCHAR(3); -- Assuming a_code is VARCHAR(3)

SELECT * FROM customer LIMIT 50;
SELECT * FROM routes LIMIT 100;
SELECT * FROM passengers_on_flights LIMIT 100;
SELECT * FROM ticket_details LIMIT 100;

SELECT * FROM passengers_on_flights WHERE route_id BETWEEN 1 AND 25;

SELECT 
    COUNT(*) AS num_passengers,
    SUM(price_per_ticket * no_of_tickets) AS total_revenue
FROM ticket_details
WHERE class_id = 'Business';

SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM customer;

SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN ticket_details t ON c.customer_id = t.customer_id;


SELECT c.first_name, c.last_name
FROM customer c
JOIN ticket_details t ON c.customer_id = t.customer_id
WHERE t.brand = 'Emirates';

SELECT c.first_name, c.last_name
FROM customer c
JOIN ticket_details t ON c.customer_id = t.customer_id
WHERE LOWER(TRIM(t.brand)) = 'Emirates';

SELECT c.customer_id, t.customer_id
FROM customer c
LEFT JOIN ticket_details t ON c.customer_id = t.customer_id
WHERE t.brand = 'Emirates';

SELECT DISTINCT brand FROM ticket_details;

SELECT * FROM ticket_details WHERE LOWER(TRIM(brand)) = 'emirates';

SELECT DISTINCT customer_id FROM customer;

SELECT * FROM ticket_details WHERE LOWER(TRIM(brand)) = 'emirates';

SELECT t.customer_id, c.customer_id
FROM ticket_details t
LEFT JOIN customer c ON t.customer_id = c.customer_id
WHERE LOWER(TRIM(t.brand)) = 'emirates';

DESC customer;
DESC ticket_details;

SELECT * FROM ticket_details WHERE customer_id IS NULL;

SELECT DISTINCT t.customer_id 
FROM ticket_details t
LEFT JOIN customer c ON t.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT DISTINCT LENGTH(customer_id) FROM customer;
SELECT DISTINCT LENGTH(customer_id) FROM ticket_details;

SELECT customer_id, LENGTH(customer_id)
FROM customer
GROUP BY customer_id
ORDER BY LENGTH(customer_id);

SELECT customer_id, LENGTH(customer_id)
FROM ticket_details
GROUP BY customer_id
ORDER BY LENGTH(customer_id);

SET SQL_SAFE_UPDATES = 0;
UPDATE customer SET customer_id = CAST(customer_id AS UNSIGNED);
UPDATE ticket_details SET customer_id = CAST(customer_id AS UNSIGNED);

SELECT DISTINCT LENGTH(customer_id) FROM customer;
SELECT DISTINCT LENGTH(customer_id) FROM ticket_details;

SELECT customer_id, LENGTH(customer_id) 
FROM customer
ORDER BY LENGTH(customer_id);

SELECT customer_id, LENGTH(customer_id) 
FROM ticket_details
ORDER BY LENGTH(customer_id);

SELECT customer_id FROM customer WHERE customer_id REGEXP '[^0-9]';
SELECT customer_id FROM ticket_details WHERE customer_id REGEXP '[^0-9]';

SELECT customer_id FROM ticket_details WHERE customer_id IS NULL OR customer_id = '';

UPDATE ticket_details 
SET customer_id = CAST(customer_id AS UNSIGNED);

SELECT DISTINCT LENGTH(customer_id) FROM ticket_details;

SELECT customer_id, LENGTH(customer_id) 
FROM ticket_details
GROUP BY customer_id
ORDER BY LENGTH(customer_id);

SELECT customer_id, LENGTH(customer_id)
FROM ticket_details
WHERE LENGTH(customer_id) = 1;

SELECT customer_id, LENGTH(customer_id)
FROM ticket_details
WHERE LENGTH(customer_id) = 1;

UPDATE ticket_details 
SET customer_id = LPAD(customer_id, 2, '0'); -- Pads single digits with a leading zero

UPDATE customer 
SET customer_id = LPAD(customer_id, 2, '0');

SELECT DISTINCT LENGTH(customer_id) FROM ticket_details;
SELECT DISTINCT LENGTH(customer_id) FROM customer;

SELECT customer_id, HEX(customer_id), LENGTH(customer_id)
FROM ticket_details
WHERE LENGTH(customer_id) = 1;

SELECT customer_id, HEX(customer_id), LENGTH(customer_id)
FROM ticket_details
WHERE LENGTH(customer_id) = 2;

SELECT customer_id, HEX(customer_id), LENGTH(customer_id)
FROM ticket_details
WHERE customer_id REGEXP '[^0-9]';

UPDATE ticket_details 
SET customer_id = CAST(customer_id AS UNSIGNED)
WHERE customer_id REGEXP '[^0-9]';

UPDATE ticket_details 
SET customer_id = CAST(TRIM(customer_id) AS UNSIGNED);

UPDATE customer 
SET customer_id = CAST(TRIM(customer_id) AS UNSIGNED);
   
SELECT DISTINCT LENGTH(customer_id) FROM customer;

DELETE FROM ticket_details;
DELETE FROM customer;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM passengers_on_flights;

DELETE FROM ticket_details;

DELETE FROM customer;

SET FOREIGN_KEY_CHECKS = 1;

UPDATE ticket_details 
SET customer_id = REGEXP_REPLACE(customer_id, '[^0-9]', '');

UPDATE ticket_details 
SET customer_id = CAST(customer_id AS UNSIGNED);

UPDATE customer 
SET customer_id = REGEXP_REPLACE(customer_id, '[^0-9]', '');

UPDATE customer 
SET customer_id = CAST(customer_id AS UNSIGNED);

SELECT c.first_name, c.last_name
FROM customer c
JOIN ticket_details t 
ON c.customer_id = t.customer_id
WHERE LOWER(TRIM(t.brand)) = 'emirates';

SELECT 
    c.customer_id AS cust_id_customer, 
    t.customer_id AS cust_id_ticket
FROM customer c
LEFT JOIN ticket_details t 
ON c.customer_id = t.customer_id
WHERE c.customer_id IS NULL OR t.customer_id IS NULL;

SELECT DISTINCT customer_id 
FROM ticket_details 
WHERE customer_id NOT IN (SELECT customer_id FROM customer);

SELECT DISTINCT brand FROM ticket_details;

SELECT DISTINCT brand, HEX(brand) FROM ticket_details;

UPDATE ticket_details 
SET brand = TRIM(brand);

SELECT DISTINCT customer_id 
FROM ticket_details 
WHERE LOWER(TRIM(brand)) = 'emirates';

SELECT DISTINCT customer_id 
FROM ticket_details 
WHERE LOWER(TRIM(brand)) = 'emirates';

SELECT DISTINCT customer_id 
FROM ticket_details 
WHERE LOWER(TRIM(brand)) = 'emirates';

SELECT customer_Id, first_name, last_name
FROM customer
WHERE customer_id IN (SELECT DISTINCT customer_id
 FROM ticket_details
 WHERE brand = 'emirates');
 
 SELECT DISTINCT customer_id
FROM ticket_details
WHERE brand = 'Emirates';

SELECT DISTINCT brand FROM ticket_details;
SHOW TABLES;
SELECT COUNT(*) FROM ticket_details;

DROP database aircargo

SELECT customer_Id, first_name, last_name
FROM customer
WHERE customer_id IN (SELECT DISTINCT customer_id
 FROM ticket_details
 WHERE brand = 'emirates');
 
 SELECT customer_id
FROM passengers_on_flights
WHERE class_id = 'Economy Plus';

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (SELECT DISTINCT customer_id
 FROM passengers_on_flights
 WHERE class = 'Economy Plus');
 
 SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN passengers_on_flights p 
ON c.customer_id = p.customer_id
WHERE p.class_id = 'Economy Plus';

SELECT 
    IF(SUM(price_per_ticket * no_of_tickets) > 10000, 'Revenue Exceeded', 'Below Threshold') AS revenue_status
FROM ticket_details;

CREATE USER 'analyst'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT, INSERT, UPDATE ON AirCargo.* TO 'analyst'@'localhost';

SELECT class_id, MAX(price_per_ticket) OVER (PARTITION BY class_id) AS max_price
FROM ticket_details;

CREATE INDEX idx_route ON passengers_on_flights(route_id);
SHOW INDEX FROM passengers_on_flights;

EXPLAIN SELECT * FROM passengers_on_flights WHERE route_id = 4;

SELECT customer_id, SUM(price_per_ticket * no_of_tickets) AS total_spent
FROM ticket_details
GROUP BY customer_id WITH ROLLUP;

CREATE VIEW business_class_customers AS
SELECT customer_id, brand FROM ticket_details WHERE class_id = 'Business';

SELECT * FROM business_class_customers;

DELIMITER //
CREATE PROCEDURE GetLongRoutes()
BEGIN
    SELECT * FROM routes WHERE distance_miles > 2000;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetLongRoutes()
BEGIN
    SELECT * FROM routes WHERE distance_miles > 2000;
END //
DELIMITER ;

CALL GetLongRoutes();

SELECT customer_id, SUM(no_of_tickets) AS total_tickets, SUM(price_per_ticket * no_of_tickets) AS total_price
FROM ticket_details
GROUP BY customer_id;

SELECT a_id, AVG(distance_miles) AS avg_distance, COUNT(DISTINCT customer_id) AS avg_passengers
FROM routes r
JOIN passengers_on_flights p ON r.route_id = p.route_id
GROUP BY aircraft_id
HAVING COUNT(DISTINCT travel_date) > 1;

SELECT r.aircraft_id, AVG(distance_miles) AS avg_distance, COUNT(DISTINCT customer_id) AS avg_passengers 
FROM routes r 
JOIN passengers_on_flights p ON r.route_id = p.route_id 
GROUP BY r.aircraft_id 
HAVING COUNT(DISTINCT travel_date) > 1 
LIMIT 0, 1000;

SELECT User FROM mysql.user WHERE User = 'analyst' AND Host = 'localhost';

SHOW GRANTS FOR 'analyst'@'localhost';
