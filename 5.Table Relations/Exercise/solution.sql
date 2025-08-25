-- 01 One-To-One Relationship
CREATE DATABASE passports;
CREATE TABLE passports(
passport_id INT PRIMARY KEY,
passport_number VARCHAR(50) UNIQUE);

CREATE TABLE people (
person_id INT ,
first_name VARCHAR(50) ,
salary DECIMAL(10,2),
passport_id INT,
CONSTRAINT fk_people_passport 
FOREIGN KEY (passport_id) REFERENCES passports(passport_id));

ALTER TABLE people
ADD CONSTRAINT pk_people
PRIMARY KEY (person_id);

INSERT INTO passports VALUES 
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2');

INSERT INTO people VALUES
(1, 'Roberto', 43300.00, 102),
(2, 'Tom', 56100.00, 103),
(3, 'Yana', 60200.00, 101);

-- 02 One-To-Many Relationship
CREATE DATABASE manufacturers;

CREATE TABLE manufacturers(
manufacturer_id INT PRIMARY KEY,
name VARCHAR(50),
established_on DATE);

CREATE TABLE models(
model_id INT PRIMARY KEY,
name VARCHAR(50),
manufacturer_id INT,
CONSTRAINT fk_models_manufacturers
FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturer_id));

INSERT INTO manufacturers (manufacturer_id, name, established_on) VALUES
(1, 'BMW', '1916-03-01'),
(2, 'Tesla', '2003-01-01'),
(3, 'Lada', '1966-05-01');

INSERT INTO models (model_id, name, manufacturer_id) VALUES
(101, 'X1', 1),
(102, 'i6', 1),
(103, 'Model S', 2),
(104, 'Model X', 2),
(105, 'Model 3', 2),
(106, 'Nova', 3);

-- 03 Many-To-Many Relationship
CREATE DATABASE exams;

CREATE TABLE exams(
exam_id INT PRIMARY KEY,
name VARCHAR(50));

CREATE TABLE students(
students_id INT PRIMARY KEY,
student_name VARCHAR(50));

CREATE TABLE students_exams(
student_id INT,
exam_id INT ,
CONSTRAINT pk_students_exams PRIMARY KEY(student_id,exam_id),
CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students(students_id),
CONSTRAINT fk_exam FOREIGN KEY (exam_id) REFERENCES exams(exam_id));

INSERT INTO exams (exam_id, name) VALUES
(101, 'Spring MVC'),
(102, 'Neo4j'),
(103, 'Oracle 11g');

INSERT INTO students (students_id, student_name) VALUES
(1, 'Mila'),
(2, 'Toni'),
(3, 'Ron');

INSERT INTO students_exams (student_id, exam_id) VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);

-- 04 Self-Referencing
CREATE TABLE teachers(
teacher_id INT PRIMARY KEY,
name VARCHAR(50),
manager_id INT,
CONSTRAINT fk_teachers_manager FOREIGN KEY (manager_id) REFERENCES teachers(teacher_id));

INSERT INTO teachers VALUES
(101,'John',NULL), 
(106,'Greta',101), 
(105,'Mark',101),  
(102,'Maya',106),  
(103,'Silvia',106),
(104,'Ted',105);

-- 05 Online Store Database
create database online_store;

CREATE TABLE customers(
customer_id INT PRIMARY KEY,
name VARCHAR(50),
birthday DATE,
city_id INT );

CREATE TABLE cities (
city_id INT PRIMARY KEY,
name VARCHAR(50));

ALTER TABLE customers
ADD CONSTRAINT fk_customers_cities FOREIGN KEY(city_id) REFERENCES cities(city_id);

CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT ,
CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id));

CREATE TABLE item_types (
item_type_id INT PRIMARY KEY,
name VARCHAR(50));

CREATE TABLE items(
items_id INT PRIMARY KEY,
name VARCHAR(50),
item_type_id INT ,
CONSTRAINT fk_items_item_types FOREIGN KEY (item_type_id) REFERENCES item_types(item_type_id));

CREATE TABLE order_items(
order_id INT,
item_id INT,
CONSTRAINT pk_order_items PRIMARY KEY(order_id,item_id),
CONSTRAINT fk_order_items_orders FOREIGN KEY (order_id) REFERENCES orders(order_id),
CONSTRAINT fk_order_items_items FOREIGN KEY (item_id) REFERENCES items(items_id));

-- 06 University Database
CREATE DATABASE university;
USE university;

CREATE TABLE majors(
major_id INT PRIMARY KEY,
name VARCHAR(50));

CREATE TABLE students (
student_id INT PRIMARY KEY,
student_number VARCHAR(12),
student_name VARCHAR(50),
major_id INT ,
CONSTRAINT fk_students_majors FOREIGN KEY (major_id) REFERENCES majors(major_id));

CREATE TABLE payments(
payment_id INT PRIMARY KEY,
payment_Date DATE,
payment_amount DECIMAL(8,2),
student_id INT ,
CONSTRAINT fk_payments_students FOREIGN KEY (student_id) REFERENCES students(student_id));

CREATE TABLE subjects (
subject_id INT PRIMARY KEY,
subject_name VARCHAR(50));

CREATE TABLE agenda(
student_id INT,
subject_id INT,
CONSTRAINT pk_students_subjects PRIMARY KEY (student_id,subject_id),
CONSTRAINT fk_agenda_students FOREIGN KEY (student_id) REFERENCES students (student_id),
CONSTRAINT fk_agenda_subjects FOREIGN KEY (subject_id) REFERENCES subjects(subject_id));

-- 09 Peaks in Rila
USE geography;
SELECT * FROM mountains;
SELECT m.mountain_range, p.peak_name,p.elevation AS peak_elevation
FROM mountains m
JOIN peaks p 
ON p.mountain_id=m.id
ORDER BY peak_elevation DESC;