-- 2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file. (7 unique titles)

USE employees;

-- I can return the unique titles.
SELECT DISTINCT
	title
FROM titles;

-- I can reutrn the actual count.
SELECT
	COUNT(DISTINCT title) AS number_of_unique_titles
FROM titles;

-- 3. Write a query to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

SELECT
	last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;

/*
Eldridge
Erbe
Erde
Erie
Etalle
*/

-- What if I want to know how many employees have that last name in the table?
SELECT
	last_name,
	COUNT(*) AS number_of_employees_with_last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;


-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'. (846 unique combinations)

SELECT
	first_name,
	last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY first_name, last_name;

-- What if I want to see the number of people with each unique combintion of first_name and last_name?
SELECT
	first_name,
	last_name,
	COUNT(*) AS number_of_employees
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY first_name, last_name
ORDER BY number_of_employees DESC;

-- What if I want to know how many employees share the same unique combination of first_name and last_name with at least one other person at their company? (129 employees share their name with at least one other person.)
SELECT
	first_name,
	last_name,
	COUNT(*) AS number_of_employees
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY first_name, last_name
HAVING number_of_employees > 1
ORDER BY number_of_employees DESC;

-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code. (3 unique last names)

SELECT
	last_name
FROM employees
WHERE last_name LIKE '%q%' 
	AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

/*
Chleq
Lindqvist
Qiwen
*/

-- If I just want the the unique last names, I can use the DISTINCT keyword, too.
SELECT DISTINCT
	last_name
FROM employees
WHERE last_name LIKE '%q%' 
	AND last_name NOT LIKE '%qu%';

-- 6. Add a COUNT() to your results (the query above) and use ORDER BY to make it easier to find employees whose unusual name is shared with others.

SELECT
	last_name,
	COUNT(last_name) AS count_of_names
FROM employees
WHERE last_name LIKE '%q%' 
	AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY count_of_names DESC;

/*
Lindqvist	190
Chleq	    189
Qiwen	    168
*/

-- 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT
	first_name,
	gender,
	COUNT(*) AS number_of_employees
FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
GROUP BY gender, first_name
ORDER BY first_name, number_of_employees DESC;

/*
Irena	M	144
Irena	F	97
Maya	M	146
Maya	F	90
Vidya	M	151
Vidya	F	81
*/

-- 8. Using your query that generates a username for all of the employees, generate a count of employees for each unique username. Are there any duplicate usernames? 

-- Yes, there are duplicate usernames. (285_872 usernames in total)

SELECT 
	LOWER(
			CONCAT(
				SUBSTR(first_name, 1, 1),
				SUBSTR(last_name, 1, 4),
				'_',
				SUBSTR(birth_date, 6, 2),
				SUBSTR(birth_date, 3, 2)
				)
			) AS username,
	COUNT(*) AS number_of_duplicates
FROM employees
GROUP BY username
ORDER BY number_of_duplicates DESC;

-- I can also return the number of unique usernames using the DISTINCT keyword. This doesn't tell me how many are duplicates.

SELECT
	COUNT(
		DISTINCT LOWER(
					CONCAT(
						SUBSTR(first_name, 1, 1),
						SUBSTR(last_name, 1, 4),
						'_',
						SUBSTR(birth_date, 6, 2),
						SUBSTR(birth_date, 3, 2)
							)
						)
				) as number_of_unique_usernames
FROM employees;


-- BONUS: How many duplicate usernames are there? 

-- There are 13_251 duplicate usernames bc now each row represents a username with duplicates.

SELECT 
	LOWER(
		CONCAT(
			SUBSTR(first_name, 1, 1),
			SUBSTR(last_name, 1, 4),
			'_',
			SUBSTR(birth_date, 6, 2),
			SUBSTR(birth_date, 3, 2)
			)
		) AS username,
	COUNT(*) AS number_of_duplicates
FROM employees
GROUP BY username
-- The HAVING clause allows me to filter my aggregate function columns.
HAVING number_of_duplicates > 1
ORDER BY number_of_duplicates DESC;


-- If I want to perform calculations with these created columns, I have to use the query that created these columns as a derived table. That just means the original query becomes a subquery in the FROM clause.
-- I MUST give an alias to my derived table to be able to select the columns in it, in this case username and number_of_duplicates.
-- A derived table ONLY exists within the query in which it is created.

-- Now I can return the number of unique duplicate usernames AND the total of duplicate usernames.

SELECT
	COUNT(t.number_of_duplicates) AS count_of_unique_duplicate_usernames,
	SUM(t.number_of_duplicates) AS total_of_duplicate_usernames
FROM (SELECT 
		LOWER(
				CONCAT(
					SUBSTR(first_name, 1, 1),
					SUBSTR(last_name, 1, 4),
					'_',
					SUBSTR(birth_date, 6, 2),
					SUBSTR(birth_date, 3, 2)
					)
				) AS username,
	COUNT(*) AS number_of_duplicates
	FROM employees
	GROUP BY username
	HAVING number_of_duplicates > 1) as t;