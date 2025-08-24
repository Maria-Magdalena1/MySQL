-- 01 Find Names of All Employees by First Name
SELECT first_name,last_name
FROM employees
WHERE first_name LIKE 'Sa%'
ORDER BY employee_id;
-- LEFT(first_name,2)='Sa'

-- 02 Find Names of All Employees by Last Name
SELECT first_name,last_name
FROM employees
WHERE last_name LIKE '%ei%'
ORDER BY employee_id;

-- 03 Find First Names of All Employees
SELECT first_name 
FROM employees
WHERE (department_id IN (10,3) )
AND (YEAR(hire_date) BETWEEN 1995 AND 2005)
ORDER BY employee_id;

-- 04 Find All Employees Except Engineers
SELECT first_name,last_name 
FROM employees
WHERE job_title NOT LIKE '%engineer%'
ORDER BY employee_id;

-- 05 Find Towns with Name Length
SELECT name FROM towns
WHERE CHAR_LENGTH(name) between 5 and 6
ORDER BY name ASC;

-- 06 Find Towns Starting With
SELECT * FROM towns 
WHERE LEFT(name,1) IN ('M','K','B','E')
ORDER BY name;

-- 07 Find Towns Not Starting With
SELECT * FROM towns 
WHERE LEFT(name,1) NOT IN ('R','B','D')
ORDER BY name;

-- 08 Create View Employees Hired After 2000 Year
CREATE VIEW v_employees_hired_after_2000 AS
SELECT first_name,last_name
FROM employees
WHERE YEAR(hire_date)>2000;

select * from v_employees_hired_after_2000;

-- 09 Length of Last Name
SELECT first_name,last_name
FROM employees
WHERE CHAR_LENGTH(last_name)=5;
