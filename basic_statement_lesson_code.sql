-- Select the database.
USE fruits_db;

-- Inspect the columns and data types from a table.
DESCRIBE fruits;

-- Another way to Inspect the columns and data types from a table.
SHOW COLUMNS
FROM fruits;

-- Return all of the rows and columns from a table.
SELECT *
FROM fruits;

-- Select specific column(s) and all of the rows from those column(s).
SELECT name
FROM fruits;

SELECT name, quantity
FROM fruits;

-- Use chiplotle database to demo a db with duplicates.
USE chipotle;

-- Inspect the columns and data types from a table.
DESCRIBE orders;

-- Return all of the rows and columns from a table. (4622 records)
SELECT *
FROM orders;

-- Select specific column(s) and all of the rows from those column(s). (4622 records)
SELECT item_name
FROM orders;

SELECT item_name, item_price
FROM orders;

-- Return only the unique values from a column using the DISTINCT keyword (50 records)
SELECT DISTINCT item_name
FROM orders;

/*
Filter so that only records with the value 'Chicken Bowl' in item_name are returned.
(726 records returned)
*/

SELECT *
FROM orders
WHERE item_name = 'Chicken Bowl';

-- Why doesn't the query below run? Never forget this lesson!

SELECT *
FROM orders
WHERE item_price = $4.45;

-- Filter using the primary key column; only one record will be returned because the value must be unique.
SELECT *
FROM orders
WHERE id = 15;

-- Filter using a WHERE clause with the BETWEEN & AND operators. (Returns 39 records)
SELECT *
FROM orders 
WHERE quantity BETWEEN 3 AND 5;

-- Filter using a WHERE statement >, <, <> operators.
SELECT *
FROM orders 
WHERE order_id > 1500;

SELECT *
FROM orders
WHERE quantity <> 1;

-- Create an alias for a column using the AS keyword. (Return 267 records)

SELECT 
	item_name AS 'Multiple Item Order',
	quantity AS Number
FROM orders
WHERE quantity >= 2;
	