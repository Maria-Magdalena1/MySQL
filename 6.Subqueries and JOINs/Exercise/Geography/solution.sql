-- 01 Highest Peaks in Bulgaria
SELECT c.country_code,m.mountain_range,p.peak_name,p.elevation
FROM countries c
JOIN mountains_countries mc ON c.country_code=mc.country_code
JOIN mountains m ON mc.mountain_id=m.id
JOIN peaks p ON m.id=p.mountain_id
WHERE c.country_name='Bulgaria' AND p.elevation>2835
ORDER BY p.elevation DESC;

-- 02 Count Mountain Ranges
SELECT c.country_code,COUNT(m.mountain_range) AS mountain_range
FROM countries c
JOIN mountains_countries mc ON c.country_code=mc.country_code
JOIN mountains m ON mc.mountain_id=m.id
WHERE c.country_name IN ('United States','Russia','Bulgaria')
GROUP BY c.country_code
ORDER BY mountain_range DESC;

-- 03 Countries with Rivers
SELECT c.country_name,r.river_name
FROM countries c 
JOIN countries_rivers cr ON c.country_code=cr.country_code
JOIN rivers r ON cr.river_id=r.id
WHERE c.continent_code='AF'
ORDER BY c.country_name
LIMIT 5;

-- 04 Continents and Currencies
SELECT c.continent_code,c.currency_code,COUNT(*) AS currency_usage
FROM countries c
GROUP BY c.continent_code,c.currency_code
HAVING COUNT(*)>1
ORDER BY c.continent_code,c.currency_code;

-- 05 Countries Without Any Mountains
select * from mountains_countries;
SELECT COUNT(*) AS country_count
FROM countries AS c
LEFT JOIN mountains_countries mc ON mc.country_code=c.country_code
LEFT JOIN mountains m ON mc.mountain_id=m.id
WHERE m.id IS NULL;

-- 06 Highest Peak and Longest River by Country
SELECT c.country_name,MAX(p.elevation) AS highest_peak_elevation,
MAX(r.length) AS longest_river_length
FROM countries c
LEFT JOIN mountains_countries mc ON c.country_code=mc.country_code
LEFT JOIN mountains m ON mc.mountain_id=m.id
LEFT JOIN peaks p ON m.id=p.mountain_id
LEFT JOIN countries_rivers cr ON c.country_code=cr.country_code
LEFT JOIN rivers r ON cr.river_id=r.id
GROUP BY c.country_name
ORDER BY highest_peak_elevation DESC,
longest_river_length DESC,
country_name
LIMIT 5;


