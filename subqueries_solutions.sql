USE employees;

-- 1 Find all the current employees with the same hire date as employee 101010 using a sub-query.

SELECT *
FROM employees;

SELECT *
FROM dept_emp;

-- First, I need to grab the hire date for employee number 101010, so I can use this value to filter.
SELECT hire_date
FROM employees
WHERE emp_no = 101010;

-- Next, I will use this value to filter for other employees who share the same hire date and the salaries table to filter for current employees.
SELECT
	first_name,
	last_name,
	hire_date
FROM employees
JOIN salaries USING(emp_no)
WHERE to_date > CURDATE()
	AND hire_date = (
					SELECT hire_date
					FROM employees
					WHERE emp_no = 101010);

					
-- 2 Find all the titles ever held by all current employees with the first name Aamod.

SELECT *
FROM titles;

-- First I need to get a list of employee numbers, unique identifiers, for employees with the name Aamod.
SELECT emp_no
FROM employees
JOIN salaries USING(emp_no)
WHERE first_name = 'Aamod'
	AND to_date > CURDATE();

-- Next, I can return the titles for employees with an employee number in the list I'm grabbing from the employees table.
SELECT 
	title
FROM titles
WHERE emp_no IN (
				SELECT emp_no
				FROM employees
				JOIN salaries USING(emp_no)
				WHERE first_name = 'Aamod'
					AND to_date > CURDATE());

-- I can even go a step further if I want and check out the most common title for employees named Aamod.
SELECT 
	title,
	COUNT(title) AS number_of_employees
FROM titles
WHERE emp_no IN (
				SELECT emp_no
				FROM employees
				JOIN salaries USING(emp_no)
				WHERE first_name = 'Aamod'
					AND to_date > CURDATE())
GROUP BY title
ORDER BY number_of_employees DESC;

-- 3 How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

-- Here I'm exploring the dept_emp table before writing my queries. (331_603 records in the dept_emp table)
SELECT *
FROM dept_emp;

SELECT 
	COUNT(*) AS number_of_records 
FROM dept_emp;

-- Here I'm exploring the employees table ebfore writing my queries. (300_024)
SELECT
	COUNT(*) AS number_of_employees
FROM employees;

-- Do we have repeats of emp_no in the dept_emp table? (Yes; there are 300_024 unique employee numbers in the dept_emp table)
SELECT 
	COUNT(DISTINCT emp_no) AS unique_employee_nos
FROM dept_emp;

-- First, I select all of the employee numbers for current employee departments.
SELECT emp_no
FROM dept_emp
WHERE to_date = '9999-01-01';

-- Next, I use these employee numbers to filter for employees who no longer work for the company. I'll get a count. (59_900)
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

-- Return count of employees whose emp_no is not in this current employees list. (59_900 employees)
SELECT
	COUNT(*)
FROM employees
WHERE emp_no NOT IN (
					SELECT emp_no
					FROM salaries
					WHERE to_date = '9999-01-01'
					);
					
-- 4 Find all the current department managers that are female. List their names in a comment in your code.

-- First, grab the employee numbers of current managers.
SELECT emp_no
FROM dept_manager
WHERE to_date = '9999-01-01';

-- Next, use employees to pull in gender as a filter and return current female dept managers. (4 current managers are female.)
SELECT *
FROM employees
WHERE gender = 'F'
	AND emp_no IN (
					SELECT emp_no
					FROM dept_manager
					WHERE to_date = '9999-01-01');
					
-- 5 Find all the employees who currently have a higher salary than the companies overall, historical average salary.

-- First, I calculate the historical average salary (historical average salary 63810.7448)
SELECT AVG(salary)
FROM salaries;

-- Next, I join employees and salaries tables to filter for current salaries > our calculated historical average above.
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

-- 6 How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

-- What are the min, max, and standard deviation of the current salaries out of curiosity. I'm exploring a little here.
SELECT
	MAX(salary) AS max_salary,
	MIN(salary) AS min_salary,
	STDDEV(salary) AS std_dev
FROM salaries
WHERE to_date > CURDATE();

-- First, I calculate the cutoff for current salaries that are within one standard deviation of the highest salary. (140910.04066365326)
SELECT
	MAX(salary) - STDDEV(salary)
FROM salaries
WHERE to_date > CURDATE();

-- Now I can find the number of current salaries >= the above amount. (The value 83 is returned)
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
					
-- Next, grab a count of all current salaries. (240_124 current salaries)
SELECT
	COUNT(salary)
FROM salaries
WHERE to_date > CURDATE();

-- Now I can divide the numbers of salaries within 1 standard deviation of the max salary by number of all of the current salaries and convert it into a percentage. I can display it using a SELECT statement.
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




