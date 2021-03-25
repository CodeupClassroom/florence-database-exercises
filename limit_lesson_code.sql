##################### LIMIT Clause #############################

/*
SELECT column_name
FROM table
LIMIT count [OFFSET count];
*/
-- Use chipotle database;
USE employees;

-- Check out all of my data.
SELECT *
FROM employees;

-- Check out the first n rows of my data; in this case 10. (records 10_001 to 10_010) (page 1)
SELECT 
	emp_no,
	first_name,
	last_name
FROM employees
LIMIT 10;

-- Start on entry 11 and limit the return set to 10 records. (records 10_011 to 10_020) (page 2)
SELECT 
	emp_no,
	first_name,
	last_name
FROM employees
LIMIT 10 OFFSET 10;

-- Start on entry 21 and limit the return set to 10 records. (records 10_021 to 10_030) (page 3)
SELECT 
	emp_no,
	first_name,
	last_name
FROM employees
LIMIT 10 OFFSET 20;

-- Start on entry 31 and limit the return set to 10 records. (records 10_031 to 10_040) (page 4)
SELECT 
	emp_no,
	first_name,
	last_name
FROM employees
LIMIT 10 OFFSET 30;

SELECT *
FROM employees
OFFSET 30;