-- 01 Find all information about departments
SELECT *
FROM departments
ORDER BY department_id;

-- 02 Find all department names
SELECT `name`
FROM departments 
ORDER BY department_id;

-- 03 Find salary of each employee
SELECT first_name,last_name,salary
FROM employees
ORDER BY employee_id;

-- 04 Find full name of each employee
SELECT first_name,middle_name,last_name
FROM employees
ORDER BY employee_id;

-- 05 Find email address of each employee
SELECT 
CONCAT(first_name,'.',last_name,'@softuni.bg') AS 'full_email_address'
FROM employees
ORDER BY employee_id;

-- 06 Find all different employee's salaries
SELECT DISTINCT salary
FROM employees;

-- 07 Find all information about employees
SELECT *
FROM employees
WHERE job_title='Sales Representative'
ORDER BY employee_id;

-- 08 Find names of all employees by salary in range
SELECT first_name,last_name,job_title
FROM employees
WHERE salary BETWEEN 20000 AND 30000
ORDER BY employee_id;

-- 09 Find names of all employees
SELECT 
CONCAT_WS(' ',first_name,middle_name,last_name) AS 'Full Name'
FROM employees
WHERE salary IN(25000,14000,12500,23600);

-- 10 Find All Employees Without Manager 
SELECT first_name,last_name
FROM employees
WHERE manager_id IS NULL;

-- 11 Find All Employees with salary More Than 50000 
SELECT first_name,last_name,salary
FROM employees 
WHERE salary>5000
ORDER BY salary DESC;

-- 12 Find 5 Best Paid Employees 
SELECT first_name,last_name
FROM employees
ORDER BY salary DESC
LIMIT 5;

-- 13 Find All Employees Except Marketing 
SELECT first_name,last_name
FROM employees 
WHERE NOT(department_id=4);-- != or <>

-- 14 Sort Employees Table
SELECT *
FROM employees
ORDER BY salary DESC,first_name ASC,last_name DESC,middle_name ASC,employee_id ASC;

--  15 Create View Employees with Salaries 
CREATE VIEW v_employees_salaries AS 
SELECT first_name,last_name,salary
FROM employees;

-- 16 Create View Employees with Job Titles 
CREATE VIEW v_employees_job_titles  AS
SELECT 
CONCAT_WS(' ',first_name,middle_name,last_name) AS 'FULL NAME',
job_title
FROM employees;

-- 17 Distinct Job Titles 
SELECT DISTINCT job_title
FROM employees
ORDER BY job_title;

-- 18 Find First 10 Started Projects 
SELECT *
FROM projects
ORDER BY start_date,name,project_id
LIMIT 10;

-- 19 Last 7 Hired Employees 
SELECT first_name,last_name,hire_date
FROM employees
ORDER BY hire_date DESC
LIMIT 7;

-- 20 Increase Salaries 
UPDATE employees
SET salary=salary*1.12
WHERE department_id IN (4,1,2,11);

SELECT salary FROM employees;
