-- 01 Mountains and Peaks
CREATE DATABASE mountains;
USE mountains;

CREATE TABLE mountains(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL);

CREATE TABLE peaks (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100),
mountain_id INT NOT NULL,
CONSTRAINT fk_peaks_mountain_id_mountain_id
FOREIGN KEY (mountain_id)
REFERENCES mountains(id)
);

-- 02 Trip Organization
SELECT * FROM vehicles;
SELECT * FROM campers;

SELECT v.driver_id,v.vehicle_type,
CONCAT(c.first_name,' ',c.last_name) AS driver_name
FROM vehicles v
JOIN campers c ON v.driver_id=c.id;

-- 03 SoftUni Hiking
SELECT r.starting_point,r.end_point,r.leader_id,
CONCAT(c.first_name,' ',c.last_name) AS leader_name
FROM routes r
JOIN campers c ON r.leader_id=c.id;

-- 04 Delete Mountains
USE camp;
DROP DATABASE mountains;

CREATE TABLE mountains(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL);

CREATE TABLE peaks (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100),
mountain_id INT NOT NULL,
CONSTRAINT fk_peaks_mountain_id_mountain_id
FOREIGN KEY (mountain_id)
REFERENCES mountains(id)
ON DELETE CASCADE
);

-- 05 Project Management DB
CREATE DATABASE clients;

CREATE TABLE clients(
id INT AUTO_INCREMENT PRIMARY KEY,
client_name VARCHAR(100) );

CREATE TABLE projects(
id INT AUTO_INCREMENT PRIMARY KEY,
client_id INT ,
project_lead_id INT ,
CONSTRAINT fk_projects_clients
FOREIGN KEY (client_id)
REFERENCES clients(id));

CREATE TABLE employees(
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(30),
last_name VARCHAR(30),
project_id INT,
CONSTRAINT fk_employees_project_id_projects_id
FOREIGN KEY (project_id)
REFERENCES projects(id));

ALTER TABLE projects
ADD CONSTRAINT fk_projects_employees
FOREIGN KEY (project_lead_id) 
REFERENCES employees(id);