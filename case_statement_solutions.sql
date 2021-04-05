USE employees;

SELECT *
FROM dept_emp;

-- 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.   (300_024 records returned without duplicate departments for any employee)

-- Explore the tables to make sure that my observations are what I think they are here.

-- Returns 331_603 rows because some employees have been in more than one department.

SELECT
	*
FROM dept_emp;

-- 331_603 rows because some employees have been in more than one department.

SELECT
	*
FROM employees_with_departments;

-- 300_024 rows because each row represents only one employee and is present only one time.

SELECT
	*
FROM employees;

-- All employee numbers, managers included, are in the dept_emp table and the employees_with_departments table.

SELECT
	emp_no
FROM dept_manager
WHERE emp_no NOT IN (SELECT
						emp_no
					FROM dept_emp);

-- All employee numbers, including managers, are in employees. 300_024 rows

SELECT
	emp_no
FROM dept_manager 
WHERE emp_no NOT IN (SELECT
				emp_no
			  FROM employees);


-- These are the max dates for departments with employee numbers, no duplicates.
-- (returns 300_024 records)
SELECT 
	emp_no,
	MAX(to_date) AS max_date
FROM dept_emp
GROUP BY emp_no;

-- Join these columns with dept_emp to get dept number. I'm using the start date for the employee's current department.
SELECT 
	de.emp_no,
	dept_no,
	from_date,
	to_date,
	IF(to_date > CURDATE(), 1, 0) AS current_employee
FROM dept_emp AS de
JOIN (SELECT 
			emp_no,
			MAX(to_date) AS max_date
		FROM dept_emp
		GROUP BY emp_no) as last_dept 
		ON de.emp_no = last_dept.emp_no
			AND de.to_date = last_dept.max_date;
			
-- Join these columns with dept_emp to get dept number. I'm going to join the employees table to get the original start, hire_date, date for the employee.
SELECT 
	de.emp_no,
	dept_no,
	hire_date,
	to_date,
	IF(to_date > CURDATE(), 1, 0) AS current_employee
FROM dept_emp AS de
JOIN (SELECT 
			emp_no,
			MAX(to_date) AS max_date
		FROM dept_emp
		GROUP BY emp_no) as last_dept 
		ON de.emp_no = last_dept.emp_no
			AND de.to_date = last_dept.max_date
JOIN employees AS e ON e.emp_no = de.emp_no;

-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT
	CONCAT(first_name, ' ', last_name) AS employee_name,
	CASE
		WHEN LEFT(last_name, 1) IN('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') THEN 'A-H'
		WHEN LEFT(last_name, 1) IN('i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q') THEN 'I-Q'
		ELSE 'R-Z'
	END AS alpha_group
FROM employees;

-- 3. How many employees (current or previous) were born in each decade?

-- Exploring birth_date, Oldest birth dates in 1952, 1965 the most recent.

SELECT
	* 
FROM employees
ORDER BY birth_date DESC
LIMIT 5;

-- Create and count the decade bins.

SELECT
	CASE
		WHEN birth_date LIKE '195%' THEN '50s'
		WHEN birth_date LIKE '196%' THEN '60s'
		ELSE 'YOUNG'
	END AS decade,
	COUNT(*)
FROM employees
GROUP BY decade;