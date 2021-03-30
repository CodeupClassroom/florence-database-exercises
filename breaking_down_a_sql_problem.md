-- write a query that 
-- shows each department along with the name of the current manager for that department.

/*   Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  ... */
  
 -- Game called "what table has the thing I need?"
 -- If a given table doesn't have what I need, how do I get it?
 
-- List out the tables we think we'll need
 
-- If we need the department name, the only table that has that info is departments
-- If we need first and last names, which table has that?
-- How the heck do employees and deparments relate??
-- We've got to find the associative table... 
-- There must be a table that relates these somewhere...
-- Titles table has a listing of all titles and manger is there...
-- Dept_manager table looks pretty good b/c it tells us the emp_no of the employee, the dept_no of the dept they manage, range of dates

-- what table should we start with?
-- employees, dept_manager, departments
-- if these tables are all related to eachother... it doesn't matter which table you start with



```mysql
-- Part 1 is to start with one of our 3 tables
select * from departments;


-- Part 2 is to join a table that shares a key in common with our 1st table
select * from departments
join dept_manager on dept_manager.dept_no = departments.dept_no;


-- Part 3 is to join our 3rd table
select * from departments
join dept_manager on dept_manager.dept_no = departments.dept_no
join employees on employees.emp_no = dept_manager.emp_no;


-- Part 4 is to ensure that we have only current managers
select * from departments
join dept_manager on dept_manager.dept_no = departments.dept_no
join employees on employees.emp_no = dept_manager.emp_no
where dept_manager.to_date > curdate();


-- Part 5, we'll 
select dept_name as "Department Name", concat(employees.first_name, " ", employees.last_name) as "Department Manager"
from departments
join dept_manager on departments.dept_no = dept_manager.dept_no
join employees on employees.emp_no = dept_manager.emp_no
where dept_manager.to_date > curdate()
order by dept_name ASC; 
```

