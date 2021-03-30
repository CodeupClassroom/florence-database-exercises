-- 1. Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;
SELECT * FROM roles;
SELECT * FROM users;

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT * FROM users
JOIN roles ON users.role_id = roles.id;

SELECT * FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT * FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query
SELECT r.name, COUNT(u.name)
FROM roles AS r
LEFT JOIN users AS u ON r.id = u.role_id
GROUP BY r.name;

-- employees database:
-- 1. Use the employees database.
USE employees;


-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT departments.dept_name, CONCAT(employees.first_name, ' ', employees.last_name) AS manager_name FROM
departments
JOIN  dept_manager ON
departments.dept_no = dept_manager.dept_no
JOIN employees ON
dept_manager.emp_no = employees.emp_no
WHERE dept_manager.to_date > NOW()
ORDER BY dept_name;


-- 3. Find the name of all departments currently managed by women.
-- OUTPUT: department name, manager names
SELECT * FROM departments LIMIT 5;

SELECT departments.dept_name,
CONCAT(employees.first_name, ' ', employees.last_name)
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employes ON  dept_manager.emp_no = employees.emp_no
WHERE dept_manager.to_date > NOW()
AND employees.gender = 'F'
ORDER BY dept_name;


-- 4. Find the current titles of employees currently working in the Customer Service department.
SELECT titles.title,
		COUNT(titles.emp_no)
FROM departments
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN titles ON titles.emp_no = dept_emp.emp_no
	WHERE titles.to_date > NOW() 
	AND dept_emp.to_date > NOW()
	AND dept_name LIKE 'cust%'
GROUP BY title;

-- 5. Find the current salary of all current managers.
SELECT d.dept_name, CONCAT(employees.first_name, ' ', employees.last_name) 
AS employee_name,
s.salary
FROM employees
JOIN salaries s ON employees.emp_no = s.emp_no
JOIN dept_manager ON s.emp_no = dept_manager.emp_no
JOIN departments d ON d.dept_no = dept_manager.dept_no
WHERE s.to_date > NOW() AND dept_manager.to_date > NOW()
ORDER BY dept_name;

-- 6. Find the number of current employees in each department.
SELECT d.dept_no, d.dept_name, COUNT(de.emp_no) AS num_employees
FROM departments AS d
JOIN current_dept_emp AS de ON d.dept_no = de.dept_no
WHERE de.to_date > NOW()
GROUP BY d.dept_name
ORDER BY d.dept_no;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.
SELECT d.dept_name, AVG(s.salary) AS average_salary
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
	AND de.to_date > NOW()
JOIN salaries AS s ON s.emp_no = de.emp_no
	AND s.to_date > NOW()
GROUP BY dept_name
ORDER BY average_salary DESC LIMIT 1;


-- 8. Who is the highest paid employee in the Marketing department?
SELECT e.first_name, e.last_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
	AND de.to_date > NOW()
JOIN salaries AS s ON de.emp_no = s.emp_no
	AND s.to_date > NOW()
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Marketing'
ORDER BY s.salary DESC
LIMIT 1;

-- 9 . Which current department manager has the highest salary?
SELECT e.first_name,
e.last_name,
s.salary,
d.dept_name
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
	AND dm.to_date > NOW()
JOIN salaries AS s ON e.emp_no =s.emp_no
	AND s.to_date > NOW()
JOIN departments AS d ON d.dept_no = dm.dept_no
ORDER BY s.salary DESC
LIMIT 1;


-- 10. (BONUS) Find the names of all current employees, their department name, and their current manager's name.

-- Self Join on employees back around to employees
SELECT CONCAT(e.first_name, ' ', e.last_name) 
AS employee_name, 
d.dept_name, 
CONCAT(m.first_name, ' ', m.last_name) 
AS manager_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN dept_manager as dm ON d.dept_no = dm.dept_no
JOIN employees as m on dm.emp_no = m.emp_no
WHERE de.to_date > NOW() and dm.to_date > NOW();


-- 11. (BONUS)  Who is the highest paid employee within each department?

SELECT CONCAT(e.first_name, ' ', e.last_name), 
smax.sal, -- smax is the alias we use on the joined query.  we want salaries from there, not the raw salaries tables
d.dept_name
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no
	AND s.to_date > NOW()
JOIN current_dept_emp de ON e.emp_no = de.emp_no
	AND de.to_date > NOW()
JOIN departments d ON de.dept_no = d.dept_no
JOIN(
-- This join contains an entire query that gives us the maximum salary from each department name
-- We use this, aliased as smax in order to join back to our initial query with two key-pairings between dept_name and salary, eliminating the duplicate case if we were to use a subquery for salaries.
SELECT MAX(s.salary) AS sal, d.dept_name
FROM departments AS d
    JOIN current_dept_emp AS de ON de.dept_no = d.dept_no
JOIN salaries AS s ON de.emp_no = s.emp_no
	WHERE s.to_date > NOW() AND de.to_date > NOW()
GROUP BY de.dept_no
) 
AS smax 
ON (smax.dept_name=d.dept_name AND smax.sal = s.salary)
	WHERE s.to_date > NOW() AND de.to_date > NOW();

