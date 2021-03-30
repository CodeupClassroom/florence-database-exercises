-- Default Join is an Inner Join
-- Inner Join filters nulls from the joined tables
-- Inner Join here gives us only users with roles and roles with users
select *
from users
join roles on users.role_id = roles.id;

-- Left Join
-- Left join is All of Table A along w/ any nulls from Table B
-- Left Join says "give me all the records from Table A even if there's no relation on Table B"
select *
from users
left join roles on users.role_id = roles.id;

-- What if we flip the Table A and table B?
-- Left join gets all the records from Table A
select *
from roles
left join users on users.role_id = roles.id;


-- Right Join says get all records from the 2nd table, show any nulls from table 1
select *
from roles
right join users on users.role_id = roles.id;

-- Right Join shows all records from the 2nd table
select *
from users
right join roles on users.role_id = roles.id;



-- Inner join of authors and quotes
-- we'll get authors with quotes, quotes with authors, no nulls
select *
from authors
join quotes on quotes.author_id = authors.id;


-- Inner join of authors and quotes
-- we'll get authors with quotes, quotes with authors, no nulls
-- We can do a second join, to add a 3rd table (add the quote_topic)
-- Then a 3rd join to add on the topics table to get the name of the topic
select *
from authors
join quotes on quotes.author_id = authors.id
join quote_topic on quote_topic.quote_id = quotes.id
join topics on topics.id = quote_topic.topic_id;

-- Example of a left join
-- We keep all the records from the FIRST table
select *
from authors
left join quotes on quotes.author_id = authors.id;


-- Notice, we're performing a Left Join... 
-- So we get all the records from Quotes table
-- Not all authors have quotes
select *
from quotes
left join authors on quotes.author_id = authors.id;

-- If you get the same results from an inner join as a left join
-- that means that Table B doesn't have any nulls
-- All quotes have an author
select *
from quotes
join authors on quotes.author_id = authors.id;
