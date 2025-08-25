-- 01 Records' Count
SELECT COUNT(*)
FROM wizzard_deposits;

-- 02 Longest Magic Wand
SELECT MAX(magic_wand_size) AS longest_magic_wand
FROM wizzard_deposits;

-- 03 Longest Magic Wand Per Deposit Group
SELECT deposit_group,MAX(magic_wand_size)AS longest_magic_wand
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY longest_magic_wand,deposit_group;

-- 04 Smallest Deposit Group Per Magic Wand Size
SELECT deposit_group
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY AVG(magic_wand_size) ASC
LIMIT 1;

-- 05 Deposits Sum
SELECT deposit_group,SUM(deposit_amount) AS total_sum
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY total_sum;

-- 06 Deposits Sum for Ollivander Family
SELECT deposit_group,SUM(deposit_amount) AS total_sum
FROM wizzard_deposits
WHERE magic_wand_creator LIKE '%Ollivander%'
GROUP BY deposit_group
ORDER BY deposit_group;

-- 07 Deposits Filter
SELECT deposit_group,SUM(deposit_amount) AS total_sum
FROM wizzard_deposits
WHERE magic_wand_creator LIKE '%Ollivander%'
GROUP BY deposit_group
HAVING total_sum<150000
ORDER BY total_sum DESC;

-- 08 Deposit Charge
SELECT deposit_group,magic_wand_creator,MIN(deposit_charge) AS min_deposit_charge
FROM wizzard_deposits
GROUP BY deposit_group,magic_wand_creator
ORDER BY magic_wand_creator,deposit_group;

-- 09 Age Groups
SELECT 
CASE 
	WHEN age BETWEEN 0 AND 10 THEN '[0-10]'
	WHEN age BETWEEN 11 AND 20 THEN '[11-20]'
	WHEN age BETWEEN 21 AND 30 THEN '[21-30]'
	WHEN age BETWEEN 31 AND 40 THEN '[31-40]'
	WHEN age BETWEEN 41 AND 50 THEN '[41-50]'
	WHEN age BETWEEN 51 AND 60 THEN '[51-60]'
	ELSE '[61+]'
END AS age_group,
COUNT(*) AS wizard_count
FROM wizzard_deposits
GROUP BY age_group
ORDER BY 
CASE 
        WHEN age_group='[0-10]' THEN 1
        WHEN age_group='[11-20]' THEN 2
        WHEN age_group='[21-30]' THEN 3
        WHEN age_group='[31-40]' THEN 4
        WHEN age_group='[41-50]' THEN 5
        WHEN age_group='[51-60]' THEN 6
        ELSE 7
    END;

-- 10 First Letters
SELECT LEFT(first_name,1) AS first_letter
FROM wizzard_deposits
WHERE deposit_group LIKE 'Troll Chest'
GROUP BY first_letter
ORDER BY first_letter;

-- 11 Average Interest
SELECT deposit_group,is_deposit_expired,AVG(deposit_interest) AS average_interest
FROM wizzard_deposits
WHERE deposit_start_date> '1985-01-01'
GROUP BY deposit_group,is_deposit_expired
ORDER BY deposit_group DESC,is_deposit_expired;
