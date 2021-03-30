Table 1
quotes
id, content, author_id
1, "You miss 100% of the shots you don't take.", 10
2, "'You miss 100% of the shots you don't take.' - Wayne Gretsky", 11
3, "Something funny", 11
4, "Another thing", 11

Table 2
authors
id, first_name, last_name
10, "Wayne", "Gretsky"
11, "Michael", "Scott"


id on authors is the primary key for the author
id on quotes is the primary key for the quote, so each quote has its own id
author_id is the foreign key on quotes that relates the author with the id that matches

A foreign key on Table 1 is a primary key on another table

3rd normal form => "The key, the whole key, and nothing but the key"

One author could have many quotes. One to Many relationship.
W/ a one-to many, the foreign key goes on the "many" table and points the "one" table


Many to Many:
Abstract: One entity can have many of another. And that other entity can have many of the 1st entity.
Example: One employee can have multiple departments. One department can have many employees
- a many to many is a couple of one-to-many's put together