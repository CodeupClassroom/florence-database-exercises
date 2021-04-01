use test3;

CREATE TEMPORARY TABLE current_salary AS (
    select employees.employees.first_name, 
    employees.employees.last_name, 
    employees.salaries.salary
    from employees.salaries
    join employees.employees using(emp_no)
    where to_date > curdate()
);

-- If we do 5% raises for all current employees
-- what is the sum of those salaries

-- UPDATE my_numbers SET n = n + 1 (where clause, if needed)

update current_salary set salary = salary + salary * .05;

use test3;
select sum(salary) from current_salary;

select sum(salary) from employees.salaries where to_date > curdate();

select (select sum(salary) from current_salary) - 
(select sum(salary) from employees.salaries
where to_date > curdate());

select 3 + 2;


CREATE temporary table fruits as (
    select *
    from fruits_db.fruits
);


update current_salary set salary = 100;

select *
from current_salary;