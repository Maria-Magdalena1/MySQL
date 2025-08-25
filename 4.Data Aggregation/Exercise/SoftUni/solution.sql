-- 1 Employees Minimum Salaries
SELECT department_id,MIN(salary) AS minimum_salary
FROM employees
WHERE department_id IN (2,5,7) AND hire_date>'2000-01-01'
GROUP BY department_id
ORDER BY department_id;

-- 2 Employees Average Salaries
SELECT department_id,AVG(CASE 
			  WHEN department_id = 1 THEN salary + 5000
              ELSE salary
         END) AS avg_salary 
FROM employees
WHERE salary >30000 AND manager_id <> 42
GROUP BY department_id
ORDER BY department_id;

-- 3 Employees Maximum Salaries
SELECT department_id,MAX(salary) AS max_salary
FROM employees
GROUP BY department_id
HAVING max_salary<30000 OR max_salary>70000
-- HAVING max_Salary NOT BETWEEN 30000 AND 70000
ORDER BY department_id;

-- 4 Employees Count Salaries
SELECT COUNT(*) AS ''
FROM employees WHERE manager_id is NULL;

-- 5 3rd Highest Salary
SELECT e1.department_id,MAX(e1.salary) AS third_highest_salary
FROM employees e1
WHERE (
	SELECT COUNT(DISTINCT e2.salary)
    FROM employees e2
    WHERE e2.department_id=e1.department_id
    AND e2.salary>e1.salary)=3
    GROUP BY e1.department_id
    ORDER BY e1.department_id;
    
-- 6 Salary Challenge
SELECT first_name,last_name,department_id FROM employees e
WHERE salary>(
	SELECT AVG(salary)
	FROM employees
	WHERE department_id =e.department_id)
ORDER BY department_id,employee_id
LIMIT 10;

-- 7 Departments Total Salaries
SELECT department_id,SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
ORDER BY department_id;