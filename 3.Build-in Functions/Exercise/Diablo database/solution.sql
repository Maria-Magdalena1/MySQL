-- 01 Games from 2011 and 2012 Year
SELECT name,date_format(start,'%Y-%m-%d') 
FROM games
WHERE YEAR(start) BETWEEN 2011 AND 2012
ORDER BY start,name
LIMIT 50;

-- 02 User Email Providers
SELECT user_name,SUBSTRING(email,locate('@',email)+1) AS `email provider`
FROM users
ORDER BY `email provider`,user_name;

-- 03 Get Users with IP Address Like Pattern
SELECT user_name,ip_address
FROM users
WHERE ip_address LIKE '___.1%.%.___'
ORDER BY user_name;

-- 04 Show All Games with Duration and Part of the Day
SELECT name,
CASE
	WHEN HOUR(start) BETWEEN 0 AND 11 THEN 'Morning'
	WHEN HOUR(start) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
END 'Part of the Day',
CASE 
	WHEN duration <=3 THEN 'Extra Short'
	WHEN duration >3 AND duration<=6 THEN 'Short'
	WHEN duration >6 AND duration<=10 THEN 'Long'
END 'Duration'
FROM games;
