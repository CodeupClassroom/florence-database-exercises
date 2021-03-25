##################### ORDER BY Clause #############################

/*
SELECT column_name
FROM table
ORDER BY column_name [ASC|DESC];
*/
-- Use chipotle database;
USE chipotle;


-- Return all of the items in the orders table and return the records in alphabetical order.
SELECT item_name
FROM orders
ORDER BY item_name;



-- Return all of the items in the orders table and return the records in reverse alphabetical order.
SELECT item_name
FROM orders
ORDER BY item_name DESC;



-- Alias the item_name column and return in reverse alphabetical order.

SELECT 
	item_name AS item,
	quantity AS number
FROM orders
ORDER BY item DESC;


########################### Chaining ORDER BY Clauses #####################

-- Alias the items and quantity columns and return in ascending order by the number and then the item.
SELECT 
	item_name AS item,
	quantity AS number
FROM orders
ORDER BY number, item;




/*
Alias the items and quantity columns and return in descending order by the number 
and then the item in alphabetical order.
*/
SELECT 
	item_name AS item,
	quantity AS number
FROM orders
ORDER BY number DESC, item ASC;




