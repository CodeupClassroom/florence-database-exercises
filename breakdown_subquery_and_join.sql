-- The #1 Trick to "Getting" subqueries is to blow off the subquery (first for now)

-- show us emp_no 10001, 10002, 10003
-- Setup our where clauses using a handful of OR 
select *
from employees
where emp_no = 10001 
or emp_no = 10002
or emp_no = 10003;

-- Same query with an IN operator instead of 3 different ORs 
select *
from employees
where emp_no in (10001, 10002, 10003);


select emp_no
from employees
where emp_no in (10001, 10002, 10003);

-- 
select *
from employees
where emp_no in (
    select emp_no
    from employees
    where emp_no = 10001 
    or emp_no = 10002
    or emp_no = 10003
);


-- Find all the names, birthdates for people currently at this company earning between 70k and 80k
-- My approach: Make one query first, that query is most likely our inner query
-- First step: Find all the folks currently making between 70k and 80k
-- Next step: Ensure that the inner query is selecting only a single column...
select *
from salaries
where salary between 70000 and 80000
and to_date > curdate();

-- Let's narrow down the columns in the select to have one value (in common w/ another table)
select emp_no
from salaries
where salary between 70000 and 80000
and to_date > curdate();

select *
from employees
where emp_no IN (
    select emp_no
    from salaries
    where salary between 70000 and 80000
    and to_date > curdate()
);


-- Find the current titles for all current employees making between 70k and 80k
-- Find the limiting part of the query first
-- If we have multiple limiting/filtering parts, then we may have multiple subqueries
select *
from salaries
where salary between 70000 and 80000;

select emp_no
from salaries
where salary between 70000 and 80000;

select *
from titles
where to_date > curdate()
and emp_no IN (
    select emp_no
    from salaries
    where to_date > curdate()
    and salary between 70000 and 80000
);



-- Find the current titles, first_name, last_name, salary for all current employees making between 70k and 80k
-- Before starting any code on a join, here's what I do:
-- Step 1 of joining anything is blowing off any code!
-- Step 2: list out all of the tables we believe have the right columns we need (comments)
-- list our columns and tables:
-- titles comes from the titles table
-- first_name and last_name from employees
-- salary comes from the salaries table
-- Step 3: Look at each one of the tables we listed above. What column(s) do they have in common?
-- What do these 3 tables have in common?
-- SQL is a relational database, meaning we need to look at and discover the relationships between tables
-- they all share the emp_no, which means we'll be joining on that column
-- always joining on what's in common, almost always a key
-- Step 4: Which table do we start from? If all 3 tables use the same column, then it doesn't matte which table we talk to first.
-- Step 5: Start with select *, we can whittle down the columns later. keep it simple
-- Step 6: join on our second table...
-- Step 7: take stock of where we are.. Do your first join and take stock of where you are..
-- Step 8: Determine our next table to join and Which key(s) we join on
-- Step 9: Lather, rinse, repeat, for each new table...
-- Step 10: Narrow down the columns to what the problem asked for:
select title, salary, first_name, last_name, employees.emp_no
from employees
join titles on titles.emp_no = employees.emp_no
join salaries on employees.emp_no = salaries.emp_no
where salaries.to_date > now()
and titles.to_date > now();



use quotes_db;

-- Show quotes and their authors
select * from quotes; -- shows us quotes and an author_id foreign key
select * from authors; -- shows author name and an id column that is the same as author_id
-- A and B == B and A 
-- this is commutativity, and an inner join is like an "and" operation, which satisfied commutativity

select *
from authors
join quotes on quotes.author_id = authors.id;

select *
from quotes
join authors on quotes.author_id = authors.id;

