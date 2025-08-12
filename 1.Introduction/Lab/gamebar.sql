CREATE DATABASE gamebar;

USE gamebar;
CREATE TABLE `employees` (
`id` INT NOT NULL AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE `categories` (
`id` INT NOT NULL AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE `products` (
`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(50) NOT NULL,
`category_id` INT NOT NULL
);

INSERT INTO employees(first_name,last_name)
VALUES
	('Pesho','Last 1'),
	('Gosho','Last 2'),
    ('Penka','Last 3');

ALTER TABLE `employees`
MODIFY COLUMN `middle_name` VARCHAR(100);

SELECT * FROM employees;

ALTER TABLE employees 
ADD COLUMN `middle_name` VARCHAR(50);

ALTER TABLE categories
ADD CONSTRAINT `fk_id_products_category_id`
FOREIGN KEY(`id`)
REFERENCES `gamebar`.`products`(`id`);