-- 01 Managers
SELECT e.employee_id,CONCAT(first_name,' ',last_name) AS full_name,
d.department_id,d.name
FROM employees e
INNER JOIN departments d
ON e.employee_id=d.manager_id
ORDER BY e.employee_id
LIMIT 5;

-- 02 Towns Addresses
SELECT t.town_id,t.name,a.address_text FROM addresses a 
INNER JOIN towns t ON a.town_id=t.town_id
AND t.name IN('San Francisco','Sofia','Carnation')
ORDER BY t.town_id,a.address_id;

-- 03 Employees Without Managers
SELECT employee_id,first_name,last_name,department_id,salary
FROM employees 
WHERE manager_id IS NULL;

-- 04 Higher Salary
SELECT COUNT(*) AS count
FROM employees 
WHERE salary>(SELECT AVG(salary) FROM employees);