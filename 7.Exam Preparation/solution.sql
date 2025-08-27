-- 01 Database Overview and Table Design

CREATE DATABASE summer_olympics;

CREATE TABLE countries(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(40) NOT NULL UNIQUE);

CREATE TABLE sports(
id INT AUTO_INCREMENT PRIMARY KEY ,
name VARCHAR(20) NOT NULL UNIQUE);

CREATE TABLE disciplines(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(40) NOT NULL,
sport_id INT NOT NULL,
CONSTRAINT fk_disciplines_sports
FOREIGN KEY (sport_id) REFERENCES sports(id));

CREATE TABLE athletes (
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(40) NOT NULL,
last_name VARCHAR(40) NOT NULL,
age INT NOT NULL,
country_id INT NOT NULL,
CONSTRAINT fk_athletes_countries 
FOREIGN KEY (country_id) REFERENCES countries(id));

CREATE TABLE medals (
id INT PRIMARY KEY AUTO_INCREMENT,
type VARCHAR(10) NOT NULL UNIQUE);

CREATE TABLE disciplines_athletes_medals (
discipline_id INT NOT NULL,
athlete_id INT NOT NULL,
medal_id INT NOT NULL,
CONSTRAINT fk_dam_disciplines
        FOREIGN KEY (discipline_id) REFERENCES disciplines(id),
    CONSTRAINT fk_dam_athletes
        FOREIGN KEY (athlete_id) REFERENCES athletes(id),
    CONSTRAINT fk_dam_medals
        FOREIGN KEY (medal_id) REFERENCES medals(id),
    -- Prevents same medal in same discipline being awarded to multiple athletes
    CONSTRAINT uq_discipline_medal UNIQUE (discipline_id, medal_id),
    -- Prevents an athlete from winning more than one medal in the same discipline
    CONSTRAINT uq_discipline_athlete UNIQUE (discipline_id, athlete_id));
    
-- 02 Insert
INSERT INTO athletes (first_name, last_name, age, country_id)
SELECT 
    UPPER(a.first_name),
    CONCAT(a.last_name, ' comes from ', c.name),
    a.age + a.country_id,
    a.country_id
FROM athletes a
JOIN countries c ON a.country_id = c.id
WHERE c.name LIKE 'A%';

-- 03 Update
UPDATE disciplines
SET name=REPLACE(name,'weight','')
WHERE name LIKE '%weight%';

-- 04 Delete
DELETE FROM athletes 
WHERE age>35;

-- 05 Countries without athletes
SELECT c.id ,c.name
FROM countries c
LEFT JOIN athletes a ON c.id=a.country_id
WHERE a.id IS NULL 
ORDER BY c.name DESC 
LIMIT 15;

-- 06 Yongest medalists
SELECT CONCAT(a.first_name,' ',a.last_name) AS full_name,
a.age 
FROM athletes a
JOIN disciplines_athletes_medals dam ON a.id=dam.athlete_id
GROUP BY a.id
ORDER BY a.age,a.id
LIMIT 2;

-- 07 Athletes without medals
SELECT a.id, a.first_name, a.last_name
FROM athletes a
LEFT JOIN disciplines_athletes_medals dam ON a.id = dam.athlete_id
WHERE dam.athlete_id IS NULL
ORDER BY a.id;

-- 08 Athletes with medals divided by sports
SELECT a.id,a.first_name,a.last_name,COUNT(dam.medal_id) AS medal_count,s.name
FROM athletes a
JOIN disciplines_athletes_medals dam ON a.id=dam.athlete_id
JOIN disciplines d ON dam.discipline_id=d.id
JOIN sports s ON d.sport_id=s.id
GROUP BY a.id,s.id
ORDER BY medal_count DESC ,a.first_name
LIMIT 10;

-- 09 Age groups of the athletes
SELECT CONCAT(first_name,' ',last_name)AS full_name,
CASE 
	WHEN age<=18 THEN 'Teenager'
    WHEN age>18 AND age<=25 THEN 'Young adult'
    ELSE 'Adult'
END AS age_group
FROM athletes
ORDER BY age DESC,first_name; 

-- 10 Find the total count of medals by country
DELIMITER $$
CREATE FUNCTION udf_total_medals_count_by_country (country_name VARCHAR(40))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE total_medals INT;
	SELECT COUNT(dam.medal_id)
    INTO total_medals
    FROM athletes a
    JOIN countries c ON a.country_id=c.id
    JOIN disciplines_athletes_medals dam ON a.id = dam.athlete_id
    WHERE c.name=country_name;
    
    RETURN total_medals;
END $$

DELIMITER $$;

SELECT c.name, udf_total_medals_count_by_country('Bahamas') AS count_of_medals
FROM countries c
WHERE c.name = 'Bahamas';

-- 11 Udate athletes's information
DELIMITER $$

CREATE PROCEDURE udp_first_name_to_upper_case(IN letter CHAR(1))
BEGIN
    UPDATE athletes
    SET first_name = UPPER(first_name)
    WHERE RIGHT(first_name, 1) = letter;
END$$

DELIMITER ;
CALL udp_first_name_to_upper_case('s');
