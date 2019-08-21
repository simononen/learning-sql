-- SELECT UPPER(REVERSE('Why does my cat look at me with such hatred?'));

-- I_like_cats

-- SELECT REPLACE(title, ' ', '->') FROM books;

-- SELECT author_lname AS forwards, REVERSE(author_lname) AS backwards FROM books;

-- SELECT UPPER(CONCAT(author_fname, ' ', author_lname)) AS 'full name in caps' FROM books;

-- SELECT CONCAT(title, ' was released in ', released_year) AS blurb FROM books;

-- SELECT title, CHAR_LENGTH(title) AS 'character count' FROM books;

-- SELECT CONCAT(SUBSTR(title, 1, 10), '...') AS 'short title', CONCAT_WS(',', author_lname, author_fname) AS author, CONCAT(stock_quantity, ' in stock') AS quantity FROM books

-- INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
-- VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256),
-- ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
-- ('Lincoln In the Bardo', 'George', 'Saunders', 2017, 1000, 367);

-- SELECT title FROM books WHERE title LIKE '%stories%';

-- SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;

-- SELECT CONCAT_WS(' - ', title, released_year) AS summary FROM books ORDER BY released_year DESC LIMIT 3;

-- SELECT title, author_lname FROM books WHERE author_lname LIKE '% %';

-- SELECT title, released_year, stock_quantity FROM books ORDER BY stock_quantity ASC LIMIT 3;

-- SELECT title, author_lname FROM books ORDER BY author_lname, title;

-- SELECT UPPER(CONCAT('My favourite author is ', author_fname, ' ', author_lname, '!')) AS yell FROM books ORDER BY author_lname;

-- SELECT COUNT(*) AS 'Number of books' FROM books;

-- SELECT author_lname, COUNT(*) FROM books
-- GROUP BY author_lname;

-- SELECT author_fname, author_lname, COUNT(*) FROM books GROUP BY author_lname, author_fname;

-- SELECT title, MAX(released_year) FROM books;

-- SELECT * FROM books WHERE pages = (SELECT MIN(pages) FROM books);

-- SELECT
--     author_fname,
--     author_lname,
--     MIN(released_year)
-- FROM books
-- GROUP BY author_lname, author_fname;

-- SELECT author_fname, author_lname, MAX(pages)
-- FROM books
-- GROUP BY author_lname, author_fname;

-- SELECT SUM(pages) FROM books;

-- SELECT SUM(released_year) FROM books;

-- SELECT author_fname, author_lname, SUM(pages)
-- FROM books
-- GROUP BY author_fname, author_lname
-- ORDER BY SUM(pages) DESC;

-- SELECT AVG(pages)
-- FROM books;

-- SELECT released_year, AVG(stock_quantity)
-- FROM books
-- GROUP BY released_year;

-- SELECT author_fname, author_lname, AVG(pages)
-- FROM books
-- GROUP BY author_fname, author_lname;

-- SELECT COUNT(*) AS 'Number of books' FROM books;

-- SELECT released_year, COUNT(*) AS 'Number of books'
-- FROM books
-- GROUP BY released_year;

-- SELECT SUM(stock_quantity)
-- FROM books
-- GROUP BY title;

-- SELECT author_fname, author_lname, AVG(released_year)
-- FROM books
-- GROUP BY author_fname, author_lname;

-- SELECT
--     CONCAT(author_fname, ' ', author_lname) AS 'full name',
--     MAX(pages)2
-- FROM books
-- GROUP BY author_fname, author_lname
-- ORDER BY MAX(pages) DESC LIMIT 1;

-- SELECT
--     released_year AS year,
--     COUNT(title) AS '# books',
--     AVG(pages) AS 'avg pages'
-- FROM books
-- GROUP BY released_year;

-- SELECT * FROM books WHERE CONCAT(author_fname, ' ', author_lname) LIKE '%Eggers%' OR CONCAT
-- (author_fname, ' ', author_lname) LIKE '%Chabon%';

-- SELECT * FROM books WHERE CONCAT(author_fname, ' ', author_lname) LIKE '%Lahiri%' AND released_year > 2000;

-- SELECT * FROM books WHERE pages BETWEEN 100 AND 200;

-- SELECT * FROM books WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%';

-- SELECT
--     title,
--     author_lname,
--     CASE WHEN title LIKE '%stories%' THEN 'Short Stories'
--     WHEN title LIKE '%just kids%' OR title LIKE '%A Heartbreaking Work%' THEN 'Memoir'
--     ELSE 'Novel'
--     END AS 'TYPE'
-- FROM books;

-- SELECT title, author_lname,
--     CASE WHEN COUNT(title) > 1 THEN CONCAT(COUNT(title), ' books')
--     ELSE CONCAT(COUNT(title), ' book')
--     END AS 'COUNT'
-- FROM books
-- GROUP BY author_lname;

CREATE TABLE customers (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8, 2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
    ON DELETE CASCADE
);

INSERT INTO customers (first_name, last_name, email)
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Micheal', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'batte@cool.com');

INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/07/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 420.25, 5);

SELECT * FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id;

SELECT *
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id
ORDER BY orders.amount;

SELECT *
FROM customers
    INNER JOIN orders
    ON customers.id = orders.customer_id
GROUP BY orders.customer_id;

SELECT first_name, last_name, order_date, amount
FROM customers
    JOIN orders
    ON customers.id = orders.customer_id
GROUP BY orders.customer_id;

SELECT * FROM customers
INNER JOIN orders
    ON customers.id = orders.customer_id;

 CREATE TABLE students (
     id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
     first_name VARCHAR(100)
 );

 CREATE TABLE papers (
     id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
     title VARCHAR(255),
     grade INT,
     student_id INT,
     FOREIGN KEY(student_id)
     REFERENCES students(id) ON DELETE CASCADE
 );

INSERT INTO students (first_name)
VALUES ('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade)
VALUES (1, 'My First Book Report', 60),
       (1, 'My Second Book Report', 75),
       (2, 'Russian Lit Through The Ages', 94),
       (2, 'De Montaigne and The Art of The Essay', 98),
       (4, 'Borges and Magical Realism', 89);

SELECT first_name, title, grade
FROM students, papers
WHERE students.id = papers.student_id
ORDER BY first_name DESC, grade ASC;

SELECT s.first_name, p.title, p.grade
FROM students s
INNER JOIN papers p
ON s.id = p.student_id
ORDER BY grade DESC;

SELECT s.first_name, p.title, p.grade
FROM students s
LEFT JOIN papers p
ON s.id = p.student_id;

SELECT
    s.first_name,
    IFNULL(p.title, 'MISSING') AS title,
    IFNULL(p.grade, 0) AS grade
FROM students s
LEFT JOIN papers p
ON s.id = p.student_id;

SELECT
    s.first_name,
    IFNULL(AVG(p.grade), 0) AS average
FROM students s
LEFT JOIN papers p
ON s.id = p.student_id
GROUP BY s.first_name
ORDER BY average DESC;

SELECT
    s.first_name,
    IFNULL(AVG(p.grade), 0) AS average,
    CASE WHEN AVG(p.grade) > 0 THEN 'PASSING'
    ELSE 'FAILING'
    END AS passing_status
FROM students s
    LEFT JOIN papers p
    ON s.id = p.student_id
GROUP BY s.first_name
ORDER BY average DESC;

CREATE TABLE reviewers (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

CREATE TABLE series (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    title VARCHAR(255),
    release_year YEAR(4),
    genre VARCHAR(255)
);

CREATE TABLE reviews (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    rating DECIMAL(2, 1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY(series_id) REFERENCES series(id),
    FOREIGN KEY(reviewer_id) REFERENCES reviewers(id)
);

SELECT s.title, r.rating
FROM series s, reviews r
WHERE s.id = r.series_id;

SELECT s.title, r.rating
FROM series s
INNER JOIN reviews r
ON s.id = r.series_id;

SELECT s.title, AVG(r.rating) AS avg_rating
FROM series s
INNER JOIN reviews r
ON s.id = r.series_id
GROUP BY s.id
ORDER BY avg_rating;

SELECT rev.first_name, rev.last_name, r.rating
FROM reviewers rev
INNER JOIN reviews r
ON rev.id = r.reviewer_id;

SELECT s.title AS unreviewed_series
FROM series s
LEFT JOIN reviews r
ON s.id = r.series_id
WHERE s.id NOT IN (SELECT series_id FROM reviews);

SELECT s.title AS unreviewed_series
FROM series s
    LEFT JOIN reviews r
    ON s.id = r.series_id
WHERE r.series_id IS NULL;

SELECT
    s.genre,
    AVG(r.rating) AS avg_rating
FROM series s
INNER JOIN reviews r
ON s.id = r.series_id
GROUP BY s.genre;

SELECT
    rev.first_name,
    rev.last_name,
    COUNT(r.rating) AS 'COUNT',
    IFNULL(MIN(r.rating), 0) AS 'MIN',
    IFNULL(MAX(r.rating), 0) AS 'MAX',
    IFNULL(AVG(r.rating), 0) AS 'AVG',
    CASE WHEN COUNT(r.rating) >= 1 THEN 'ACTIVE'
    ELSE 'INACTIVE'
    END AS 'STATUS'
FROM reviewers rev
LEFT JOIN reviews r
ON rev.id = r.reviewer_id
GROUP BY rev.id;

SELECT
    s.title,
    r.rating,
    CONCAT(rev.first_name, ' ', rev.last_name) AS 'reviewer'
FROM reviewers rev
    JOIN reviews r
    ON rev.id = r.reviewer_id
    JOIN series s
    ON s.id = r.series_id
ORDER BY s.title;
