-- 01 Find Book Titles
SELECT title FROM books 
WHERE SUBSTRING(title,1,3)='The'
ORDER BY id;

-- 02 Replace Titles
-- SELECT CONCAT('***',SUBSTRING(title,4)if we want ony the beginning
SELECT title,
REPLACE(title,'The','***') FROM books 
WHERE SUBSTRING(title,1,3)='The'
ORDER BY id;

-- 03 Sum Cost of All Books
SELECT ROUND(SUM(cost),2) FROM books;

-- 04 Days Lived
SELECT  CONCAT(first_name,' ',last_name) AS 'Full Name'
,TIMESTAMPDIFF(DAY ,born,died) AS 'Days Lived'
FROM authors;

-- 05 Harry Potter Books
SELECT * FROM books WHERE title LIKE 'Harry Potter%'
ORDER BY id;