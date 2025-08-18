-- 01 All mountain peaks
SELECT *
FROM peaks
ORDER BY peak_name;

-- 02 Biggest Countries by Population 
SELECT country_name,population
FROM countries
WHERE continent_code='EU'
ORDER BY population DESC,country_name ASC
LIMIT 30;

-- 03 Countries and Currency (Euro / Not Euro) 
SELECT country_name,country_code ,
CASE 
	WHEN currency_code ='EUR' THEN 'Euro'
    ELSE 'Not Euro'
END AS currency
FROM countries
ORDER BY country_name;

