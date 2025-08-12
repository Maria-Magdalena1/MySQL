-- 00.Create the database
CREATE DATABASE `minions`;

USE minions;
-- 01 Create the tables
CREATE TABLE minions (
id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(128) NOT NULL,
age INT 
);

CREATE TABLE towns(
town_id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(128) NOT NULL
);

-- 02 Alter minions table
ALTER TABLE `minions`.`towns`
CHANGE COLUMN `town_id` `id` INT NOT NULL AUTO_INCREMENT ;

ALTER TABLE minions
ADD COLUMN town_id INT ,
ADD FOREIGN KEY(town_id) REFERENCES towns(id);

-- 03 Insert records in both tables
INSERT INTO towns
VALUES 
(1,'Sofia'),
(2,'Plovdiv'),
(3,'Varna');

INSERT INTO minions
VALUES 
	(1,'Kevin',22,1),
	(2,'Bob',15,3),
    (3,'Steward',NULL,2);

-- 04 Truncate table minions
TRUNCATE minions;

-- 05 Drop all tables
DROP TABLE minions;
DROP TABLE towns;

-- 06 Create table people

CREATE TABLE people(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(200) NOT NULL,
picture LONGBLOB ,
height DECIMAL(3,2),
weigth DECIMAL(5,2),
gender ENUM('m','f') NOT NULL,
birthdate DATE NOT NULL,
biography LONGTEXT
);

INSERT INTO people (name,picture,height,weigth,gender,birthdate,biography)
VALUES ('Pesho',NULL,1.80,123.11,'m','1990-10-12',NULL),
	('Ivan',NULL,1.54,103.11,'m','1970-10-12',NULL),
    ('Dragan',NULL,1.80,123.11,'m','2003-05-12',NULL),
    ('Petkan',NULL,1.70,30.11,'m','1979-10-16',NULL),
    ('Ivanka',NULL,1.55,123.11,'f','2000-10-12',NULL);

-- Create table users

CREATE TABLE users (
id BIGINT PRIMARY KEY AUTO_INCREMENT,
username VARCHAR(30) CHAR SET ascii UNIQUE,
password VARCHAR(26) CHAR SET ascii NOT NULL,
profile_picture MEDIUMBLOB,
last_login_time DATETIME,
is_deleted BOOL
);

INSERT INTO users
VALUES
	(null,'user123','123456',NULL,'2023-04-18 17:20:06',false),
    (null,'user12','123456',NULL,'2023-04-18 17:20:06',false),
    (null,'user1237812','123456',NULL,'2021-04-18 17:20:06',false),
    (null,'user12302','123456',NULL,'2023-04-18 17:20:06',false),
    (null,'user12302-','123456',NULL,'2025-06-18 17:20:06',false);

-- 08 Change primary key
ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users PRIMARY KEY (id,username);

-- 09 Set default time
ALTER TABLE users
MODIFY last_login_time DATETIME DEFAULT NOW();

-- 10 Set unique field
ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users PRIMARY KEY (id),
ADD CONSTRAINT unq_username UNIQUE(username);

-- 11 Movies database

CREATE DATABASE movies;
USE movies;

CREATE TABLE directors(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
director_name VARCHAR(128) NOT NULL,
notes TEXT);

CREATE TABLE genres (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
genre_name VARCHAR(128) NOT NULL,
notes TEXT);

CREATE TABLE categories (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
category_name VARCHAR(128) NOT NULL,
notes TEXT);

CREATE TABLE movies (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
title VARCHAR(128) NOT NULL,
director_id INT NOT NULL,
copyright_year YEAR NOT NULL,
length INT NOT NULL,
genre_id INT NOT NULL,
category_id INT NOT NULL,
rating DECIMAL(2,1),
notes TEXT,
FOREIGN KEY (director_id) REFERENCES directors(id),
FOREIGN KEY (genre_id) REFERENCES genres(id),
FOREIGN KEY (category_id) REFERENCES categories(id)
);

INSERT INTO directors (director_name, notes) VALUES
('Christopher Nolan', 'Known for mind-bending thrillers'),
('Quentin Tarantino', 'Famous for non-linear storytelling'),
('Steven Spielberg', 'Master of blockbuster films'),
('Greta Gerwig', 'Known for fresh, character-driven stories'),
('Hayao Miyazaki', 'Legendary Japanese animator');

INSERT INTO genres (genre_name, notes) VALUES
('Action', 'High-paced sequences'),
('Drama', 'Emotionally intense'),
('Comedy', 'Humorous content'),
('Fantasy', 'Magical or imaginary worlds'),
('Sci-Fi', 'Science fiction themes');

INSERT INTO categories (category_name, notes) VALUES
('Blockbuster', 'Large-scale commercial release'),
('Indie', 'Independent production'),
('Classic', 'Older, influential films'),
('Animated', 'Cartoon or CGI-based'),
('Documentary', 'Non-fiction film');

INSERT INTO movies (title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
VALUES
('Inception', 1, 2010, 148, 5, 1, 8.8, 'Dream within a dream'),
('Pulp Fiction', 2, 1994, 154, 2, 3, 8.9, 'Non-linear storytelling'),
('Jurassic Park', 3, 1993, 127, 1, 1, 8.1, 'Dinosaurs come alive'),
('Lady Bird', 4, 2017, 94, 2, 2, 7.4, 'Coming-of-age drama'),
('Spirited Away', 5, 2001, 125, 4, 4, 8.6, 'Animated fantasy adventure');


-- 12 Car rental database
CREATE DATABASE car_rental;

CREATE TABLE categories (
id INT PRIMARY KEY AUTO_INCREMENT,
category VARCHAR(50) NOT NULL,
daily_rate DECIMAL(7,2) NOT NULL,
weekly_rate DECIMAL(7,2) NOT NULL,
monthly_rate DECIMAL(7,2) NOT NULL,
weekend_rate DECIMAL(7,2) NOT NULL
);

CREATE TABLE cars (
id INT PRIMARY KEY AUTO_INCREMENT,
plate_number VARCHAR(15) NOT NULL UNIQUE,
make VARCHAR(50) NOT NULL,
model VARCHAR(50) NOT NULL,
car_year YEAR NOT NULL,
category_id INT NOT NULL,
doors INT NOT NULL,
picture BLOB,
car_condition VARCHAR(100) NOT NULL,
available BOOLEAN NOT NULL DEFAULT TRUE,
FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE employees (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
first_name VARCHAR(180) NOT NULL,
last_name VARCHAR(180) NOT NULL,
title VARCHAR(50),
notes TEXT
);

CREATE TABLE customers (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
driver_licence_number VARCHAR(30) NOT NULL UNIQUE,
full_name VARCHAR(180) NOT NULL,
address VARCHAR(250),
city VARCHAR(190),
zip_code VARCHAR(20),
nodes TEXT
);

CREATE TABLE rental_orders (
id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    customer_id INT NOT NULL,
    car_id INT NOT NULL,
    car_condition VARCHAR(100) NOT NULL,
    tank_level VARCHAR(50) NOT NULL,
    kilometrage_start INT NOT NULL,
    kilometrage_end INT,
    total_kilometrage INT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_days INT NOT NULL,
    rate_applied VARCHAR(20) NOT NULL,
    tax_rate DECIMAL(4,2) NOT NULL,
    order_status VARCHAR(50) NOT NULL,
    notes TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (car_id) REFERENCES cars(id)
    );

INSERT INTO categories (category, daily_rate, weekly_rate, monthly_rate, weekend_rate) VALUES
('Economy', 25.00, 150.00, 550.00, 30.00),
('SUV', 50.00, 300.00, 1100.00, 60.00),
('Luxury', 100.00, 600.00, 2200.00, 120.00);

INSERT INTO cars (plate_number, make, model, car_year, category_id, doors, picture, car_condition, available) VALUES
('ABC1234', 'Toyota', 'Corolla', 2019, 1, 4, 'toyota_corolla.jpg', 'Excellent', TRUE),
('XYZ5678', 'Ford', 'Explorer', 2021, 2, 5, 'ford_explorer.jpg', 'Good', TRUE),
('LMN8910', 'BMW', '7 Series', 2020, 3, 4, 'bmw_7series.jpg', 'Excellent', FALSE);

INSERT INTO employees (first_name, last_name, title, notes) VALUES
('John', 'Smith', 'Manager', 'Experienced in fleet management'),
('Emily', 'Davis', 'Sales Agent', 'Friendly and efficient'),
('Michael', 'Brown', 'Technician', 'Maintains all vehicles');

INSERT INTO customers (driver_licence_number, full_name, address, city, zip_code, notes) VALUES
('DL1234567', 'Alice Johnson', '123 Main St', 'New York', '10001', 'Frequent renter'),
('DL7654321', 'Robert Wilson', '456 Elm St', 'Los Angeles', '90001', NULL),
('DL5557777', 'Maria Garcia', '789 Oak St', 'Chicago', '60601', 'VIP customer');

INSERT INTO rental_orders (employee_id, customer_id, car_id, car_condition, tank_level, kilometrage_start, kilometrage_end, total_kilometrage, start_date, end_date, total_days, rate_applied, tax_rate, order_status, notes) VALUES
(1, 1, 1, 'Excellent', 'Full', 15000, 15200, 200, '2025-07-01', '2025-07-07', 7, 'weekly_rate', 0.08, 'Completed', 'No issues'),
(2, 2, 2, 'Good', 'Half', 30000, NULL, NULL, '2025-08-01', '2025-08-05', 5, 'daily_rate', 0.08, 'Ongoing', NULL),
(3, 3, 3, 'Excellent', 'Full', 5000, NULL, NULL, '2025-08-10', '2025-08-15', 6, 'daily_rate', 0.08, 'Reserved', 'Customer requested luxury car');

-- 13 Basic insert

CREATE DATABASE soft_uni;

CREATE TABLE towns (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
name VARCHAR(180) NOT NULL
);

CREATE TABLE addresses (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
address_text VARCHAR(180),
town_id INT NOT NULL,
FOREIGN KEY (town_id) REFERENCES towns(id)
);

CREATE TABLE departments (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
name VARCHAR(180)
);

CREATE TABLE employees (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
first_name VARCHAR(50),
middle_name VARCHAR(50),
last_name VARCHAR(50),
job_title VARCHAR(50),
department_id INT NOT NULL,
hire_date DATE NOT NULL,
salary DECIMAL(10,2) NOT NULL,
address_id INT NOT NULL,
FOREIGN KEY (department_id) REFERENCES departments(id),
FOREIGN KEY (address_id) REFERENCES addresses (id)
);

INSERT INTO towns(name)
VALUES ('Sofia'),
	   ('Plovdiv'),
       ('Varna'),
       ('Burgas');

INSERT INTO departments (name) 
VALUES ('Engineering'),
	   ('Sales'),
       ('Marketing'),
       ('Software Development'),
       ('Quality Assurance');
       
INSERT INTO addresses (address_text, town_id) VALUES
('123 Main St', 1),  
('45 Central Blvd', 2), 
('78 Seaside Ave', 3), 
('9 Beach Road', 4); 

INSERT INTO employees 
(first_name, middle_name, last_name, job_title, department_id, hire_date, salary, address_id) VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00, 1),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00, 2),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25, 3),
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00, 4),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88, 1);

-- 14 Basic select all fields

SELECT * FROM towns;
SELECT * FROM departments;
SELECT * FROM employees;

-- 15 basic select all fields and order them

SELECT * FROM towns 
ORDER BY name ASC;

SELECT * FROM departments 
ORDER BY name ASC;

SELECT * FROM employees 
ORDER BY salary DESC;

-- 16 Basic select some fields 

SELECT name FROM towns 
ORDER BY name ASC;

SELECT name FROM departments 
ORDER BY name ASC;

SELECT first_name,last_name,job_title,salary FROM employees
ORDER BY salary DESC;

-- 17 Increase employees salary 
UPDATE employees
SET salary=salary + salary*0.10
WHERE id>=1;

SELECT salary FROM employees;