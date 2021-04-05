################################## CASE Statement ###########################

USE chipotle;


-- Create buckets or bins for my items.
SELECT 
	item_name,
	CASE
		WHEN item_name LIKE '%chicken%' THEN 'Chicken Item'
		WHEN item_name LIKE '%veggie%' THEN 'Veggie Item'
		WHEN item_name LIKE '%beef%' THEN 'Beef Item'
		WHEN item_name LIKE '%barbacoa%' 
			OR item_name LIKE '%carnitas%' 
			OR item_name LIKE '%steak%' THEN 'Specialty Item'		
		WHEN item_name LIKE '%chips%' THEN 'Side'
		ELSE 'Other'
		END AS item_type
FROM orders;


-- How many different items do I have for each item type category?
SELECT 
	CASE
		WHEN item_name LIKE '%chicken%' THEN 'Chicken Item'
		WHEN item_name LIKE '%veggie%' THEN 'Veggie Item'
		WHEN item_name LIKE '%beef%' THEN 'Beef Item'
		WHEN item_name LIKE '%barbacoa%' 
			OR item_name LIKE '%carnitas%' 
			OR item_name LIKE '%steak%' THEN 'Specialty Item'		
		WHEN item_name LIKE '%chips%' THEN 'Side'
		ELSE 'Other'
		END AS item_type,
	COUNT(*) count_of_records
FROM orders
GROUP BY item_type
ORDER BY count_of_records DESC;


-- Filter my return set to Specialty Items item types only and see which item in this category is most popular.
SELECT 
	item_name,
	CASE
		WHEN item_name LIKE '%chicken%' THEN 'Chicken Item'
		WHEN item_name LIKE '%veggie%' THEN 'Veggie Item'
		WHEN item_name LIKE '%beef%' THEN 'Beef Item'
		WHEN item_name LIKE '%barbacoa%' 
			OR item_name LIKE '%carnitas%' 
			OR item_name LIKE '%steak%' THEN 'Specialty Item'
		WHEN item_name LIKE '%chips%' THEN 'Side'
		ELSE 'Other'
		END AS item_type,
	COUNT(*) AS count_of_records
FROM orders
GROUP BY item_type, item_name
HAVING item_type = 'Specialty Item'
ORDER BY count_of_records DESC;


-- Create buckets for quantity to create a new categorical variable.

-- What values do I have in quantity?
SELECT DISTINCT quantity
FROM orders;


SELECT
	item_name,
	CASE
		WHEN quantity = 1 THEN 'single_item'
		WHEN quantity BETWEEN 2 AND 5 THEN 'family_and_friends'
		WHEN quantity BETWEEN 6 AND 9 THEN 'small_gathering'
		WHEN quantity > 9 THEN 'party'
		ELSE 'other'
		END AS quant_cats
FROM orders;


-- Add a GROUP BY Clause to Zoom Out and take a look at my new categorical variables quant_cats
SELECT
	COUNT(*) AS count_of_records,
	CASE
		WHEN quantity = 1 THEN 'single_item'
		WHEN quantity BETWEEN 2 AND 5 THEN 'family_and_friends'
		WHEN quantity BETWEEN 6 AND 9 THEN 'small_gathering'
		WHEN quantity > 9 THEN 'party'
		ELSE 'other'
		END AS quant_cats
FROM orders
GROUP BY quant_cats
ORDER BY count_of_records DESC;


-- Use the mall_customers database.
USE mall_customers;


-- Check out the customers table.
SELECT *
FROM customers;


-- Reference more than one column in CASE Statement logic.
SELECT
	gender,
	age,
	CASE
		WHEN gender = 'Male' AND age < 20 THEN 'Teen Male'
		WHEN gender = 'Male' AND age < 30 THEN 'Twenties Male'
		WHEN gender = 'Male' AND age < 40 THEN 'Thirties Male'
		WHEN gender = 'Male' AND age < 50 THEN 'Forties Male'
		WHEN gender = 'Male' AND age < 60 THEN 'Fifties Male'
		WHEN gender = 'Male' AND age < 70 THEN 'Sixties Male'
		WHEN gender = 'Male' AND age >= 70 THEN 'Older Male'
		WHEN gender = 'Female' AND age < 20 THEN 'Teen Female'
		WHEN gender = 'Female' AND age < 30 THEN 'Twenties Female'
		WHEN gender = 'Female' AND age < 40 THEN 'Thirties Female'
		WHEN gender = 'Female' AND age < 50 THEN 'Forties Female'
		WHEN gender = 'Female' AND age < 60 THEN 'Fifties Female'
		WHEN gender = 'Female' AND age < 70 THEN 'Sixties Female'
		WHEN gender = 'Female' AND age >= 70 THEN 'Older Female'
		ELSE 'Other'
		END AS gen_age_cat
FROM customers;


-- Zoom Out by adding a Group By Clause
SELECT
	CASE
		WHEN gender = 'Male' AND age < 20 THEN 'Teen Male'
		WHEN gender = 'Male' AND age < 30 THEN 'Twenties Male'
		WHEN gender = 'Male' AND age < 40 THEN 'Thirties Male'
		WHEN gender = 'Male' AND age < 50 THEN 'Forties Male'
		WHEN gender = 'Male' AND age < 60 THEN 'Fifties Male'
		WHEN gender = 'Male' AND age < 70 THEN 'Sixties Male'
		WHEN gender = 'Male' AND age >= 70 THEN 'Older Male'
		WHEN gender = 'Female' AND age < 20 THEN 'Teen Female'
		WHEN gender = 'Female' AND age < 30 THEN 'Twenties Female'
		WHEN gender = 'Female' AND age < 40 THEN 'Thirties Female'
		WHEN gender = 'Female' AND age < 50 THEN 'Forties Female'
		WHEN gender = 'Female' AND age < 60 THEN 'Fifties Female'
		WHEN gender = 'Female' AND age < 70 THEN 'Sixties Female'
		WHEN gender = 'Female' AND age >= 70 THEN 'Older Female'
		ELSE 'Other'
		END AS gen_age_cat,
	COUNT(*) AS count_of_customers
FROM customers
GROUP BY gen_age_cat
ORDER BY count_of_customers DESC;


#################################### IF() Function ###############################
-- Use the mall_customers database.
USE mall_customers;

-- Check out the customers table.
SELECT *
FROM customers;

-- Use an IF Function to create a dummy variable for gender.
SELECT
	gender,
	IF(gender = 'Female', True, False) AS is_female
FROM customers;

-- I can create this new boolean column in another simple way, just evaulate the equality statement to True or False.
SELECT
	gender,
	gender = 'Female' AS is_female
FROM customers;