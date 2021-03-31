USE employees;

-- 1
SELECT hire_date
FROM employees
WHERE emp_no = 101010;

SELECT
	first_name,
	last_name
FROM employees
WHERE hire_date IN (
					SELECT hire_date
					FROM employees
					WHERE emp_no = 101010);
					
-- 2
SELECT *
FROM titles;

SELECT emp_no
FROM employees
WHERE first_name = 'Aamod';

SELECT 
	title,
	COUNT(title) AS number_of_employees
FROM titles
WHERE emp_no IN (
				SELECT emp_no
				FROM employees
				WHERE first_name = 'Aamod')
GROUP BY title
ORDER BY number_of_employees DESC;

-- 3

-- employees who no longer work for the company
SELECT 
	COUNT(*) AS number_of_records 
FROM dept_emp;

-- do we have repeats of emp_no in the dept_emp table?
SELECT 
	COUNT(DISTINCT emp_no) AS unique_employee_nos
FROM dept_emp;

-- employee numbers of current employees
SELECT DISTINCT emp_no
FROM dept_emp
WHERE to_date = '9999-01-01';

-- number of employees in the employees table who no longer work for the company.
SELECT 
	COUNT(*) AS number_of_non_employees
FROM employees
WHERE emp_no NOT IN (
				SELECT emp_no
				FROM dept_emp
				WHERE to_date = '9999-01-01');

-- You could have come at it from this table, too.
-- If you're getting a salary, you're a current employee.			
SELECT emp_no
FROM salaries
WHERE to_date = '9999-01-01';

-- Return count of employees whose emp_no is not in this current employees list.
SELECT
	COUNT(*)
FROM employees
WHERE emp_no NOT IN (
					SELECT emp_no
					FROM salaries
					WHERE to_date = '9999-01-01'
					);
					
-- 4

-- Get the employees number of current managers.
SELECT emp_no
FROM dept_manager
WHERE to_date = '9999-01-01';

-- Use employees to pull in gender as a filter and return current female dept managers.
SELECT *
FROM employees
WHERE gender = 'F'
	AND emp_no IN (
					SELECT emp_no
					FROM dept_manager);
					
-- 5

-- Calculate historical average salary (historical average salary 63810.7448)
SELECT AVG(salary)
FROM salaries;

-- Join employees and salaries tables to filter for current salaries > our calculated historical average above.
-- Filter for current salaries in Join. (154_543 employees returned)
SELECT 
	e.emp_no,
	first_name,
	last_name,
	salary
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND to_date = '9999-01-01'
WHERE salary > (
				SELECT AVG(salary)
				FROM salaries
				);
				
-- Filter for current salaries in WHERE clause. (154_543 employees returned)
SELECT 
	e.emp_no,
	first_name,
	last_name,
	salary
FROM employees AS e
JOIN salaries AS s USING(emp_no)
WHERE salary > (
				SELECT AVG(salary)
				FROM salaries
				)
	AND to_date = '9999-01-01';

-- 6
-- Get the number of salaries that are within 1 standard deviation from the current highest salary.

-- What are the min, max, and standard deviation of the current salaries out of curiosity. I'm getting my bearings here.
SELECT
	MAX(salary) AS max_salary,
	MIN(salary) AS min_salary,
	STDDEV(salary) AS std_dev
FROM salaries
WHERE to_date > CURDATE();

-- Calculate the cutoff for salaries that are within one standard deviation of the highest salary. (140910.04066365326)
SELECT
	MAX(salary) - STDDEV(salary)
FROM salaries
WHERE to_date > CURDATE();

-- Now I can find the number of current salaries >= the above amount. (83 records returned)
SELECT
	COUNT(salary)
FROM salaries
WHERE to_date > CURDATE()
	AND salary >= (
					SELECT
					MAX(salary) - STDDEV(salary)
					FROM salaries
					WHERE to_date > CURDATE()
					);
					
-- Count of all current salaries. (240_124 current salaries)
SELECT
	COUNT(salary)
FROM salaries
WHERE to_date > CURDATE();

-- Now I can divide the numbers of salaries within 1 standard deviation of the max salary by number of all of the current salaries and convert it into a percentage.
-- Basically, 83 / 240_124 * 100
SELECT
(SELECT
	COUNT(salary)
FROM salaries
WHERE to_date > CURDATE()
	AND salary >= (
					SELECT
					MAX(salary) - STDDEV(salary)
					FROM salaries
					WHERE to_date > CURDATE()
					))
/
(SELECT
	COUNT(salary)
FROM salaries
WHERE to_date > CURDATE()) * 100 AS percent_of_salaries;

