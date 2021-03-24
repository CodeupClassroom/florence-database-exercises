-- 2. Select the albums database.
USE albums_db;


-- 3. Explore the structure of the albums table.
-- a. How many rows are in the albums table? (31 records returned)
SELECT *
FROM albums;


-- b. How many unique artist names are in the albums table? (23 records returned)
SELECT DISTINCT artist
FROM albums;


-- c. What is the primary key for the albums table? (id is the primary key for the albums table)
DESCRIBE albums;


-- d. What is the oldest release date for any album in the albums table? (1967)
-- What is the most recent release date? (2011)
SELECT DISTINCT release_date
FROM albums
ORDER BY release_date DESC;


-- 4. Write queries to find the following information:
-- a. The name of all albums by Pink Floyd (returns 2 records)
SELECT name
FROM albums
WHERE artist = 'Pink Floyd';


-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT name, release_date
FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';



-- c. The genre for the album Nevermind
SELECT genre
FROM albums
WHERE name = 'Nevermind';


-- d. Which albums were released in the 1990s (returns 11 records)
SELECT name, release_date
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;


-- e. Which albums had less than 20 million certified sales (return 13 records)
SELECT name, sales
FROM albums
WHERE sales < 20;


-- f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"? (Rock doesn't = Progressive Rock or Hard Rock)
SELECT *
FROM albums
WHERE genre = 'rock, funk, pop';

SELECT DISTINCT genre
FROM albums;
