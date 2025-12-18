CREATE DATABASE employee_db;
USE employee_db;

CREATE TABLE employee (
    emp_id        INT PRIMARY KEY,
    name          VARCHAR(50),
    department_id VARCHAR(10),
    salary        INT
);

CREATE TABLE department (
    department_id   VARCHAR(10) PRIMARY KEY,
    department_name VARCHAR(50),
    location        VARCHAR(50)
);

CREATE TABLE sales (
    sale_id     INT PRIMARY KEY,
    emp_id      INT,
    sale_amount INT,
    sale_date   DATE,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

INSERT INTO employee (emp_id, name, department_id, salary) VALUES
(101, 'Abhishek', 'D01', 62000),
(102, 'Shubham',  'D01', 58000),
(103, 'Priya',    'D02', 67000),
(104, 'Rohit',    'D02', 64000),
(105, 'Neha',     'D03', 72000),
(106, 'Aman',     'D03', 55000),
(107, 'Ravi',     'D04', 60000),
(108, 'Sneha',    'D04', 75000),
(109, 'Kiran',    'D05', 70000),
(110, 'Tanuja',   'D05', 65000);

INSERT INTO department (department_id, department_name, location) VALUES
('D01', 'Sales',    'Mumbai'),
('D02', 'Marketing','Delhi'),
('D03', 'Finance',  'Pune'),
('D04', 'HR',       'Bengaluru'),
('D05', 'IT',       'Hyderabad');

INSERT INTO sales (sale_id, emp_id, sale_amount, sale_date) VALUES
(201, 101,  4500, '2025-01-05'),
(202, 102,  7800, '2025-01-10'),
(203, 103,  6700, '2025-01-14'),
(204, 104, 12000, '2025-01-20'),
(205, 105,  9800, '2025-02-02'),
(206, 106, 10500, '2025-02-05'),
(207, 107,  3200, '2025-02-09'),
(208, 108,  5100, '2025-02-15'),
(209, 109,  3900, '2025-02-20'),
(210, 110,  7200, '2025-03-01');
#1
SELECT name
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee);
#2
SELECT e.*
FROM employee e
WHERE e.department_id = (
    SELECT department_id
    FROM employee
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);
#3
SELECT DISTINCT e.*
FROM employee e
WHERE e.emp_id IN (SELECT emp_id FROM sales);

SELECT DISTINCT e.*
FROM employee e 
JOIN sales s on e.emp_id=s.emp_id;
#4
SELECT e.*, s.sale_amount
FROM sales s
JOIN employee e ON e.emp_id = s.emp_id
WHERE s.sale_amount = (SELECT MAX(sale_amount) FROM sales);
#5
SELECT name
FROM employee
WHERE salary > (
    SELECT salary
    FROM employee
    WHERE name = 'Shubham'
);
# Intermediate Level
#1
SELECT *
FROM employee
WHERE department_id = (
    SELECT department_id
    FROM employee
    WHERE name = 'Abhishek'
);
#2
SELECT DISTINCT d.*
FROM department d
WHERE d.department_id IN (
    SELECT department_id
    FROM employee
    WHERE salary > 60000
);

#3
SELECT d.department_name
FROM sales s
JOIN employee e   ON s.emp_id = e.emp_id
JOIN department d ON e.department_id = d.department_id
WHERE s.sale_amount = (SELECT MAX(sale_amount) FROM sales);

#4
SELECT DISTINCT e.*
FROM employee e
JOIN sales s ON e.emp_id = s.emp_id
WHERE s.sale_amount > (SELECT AVG(sale_amount) FROM sales);

#5
SELECT SUM(s.sale_amount) AS total_sales
FROM sales s
WHERE s.emp_id IN (
    SELECT emp_id
    FROM employee
    WHERE salary > (SELECT AVG(salary) FROM employee)
);

# Advanced level 
#1 
SELECT *
FROM employee
WHERE emp_id NOT IN (SELECT DISTINCT emp_id FROM sales);

#2
SELECT d.*
FROM department d
WHERE d.department_id IN (
    SELECT department_id
    FROM employee
    GROUP BY department_id
    HAVING AVG(salary) > 55000
);

#3
SELECT d.department_name
FROM department d
JOIN employee e ON d.department_id = e.department_id
JOIN sales s    ON e.emp_id = s.emp_id
GROUP BY d.department_id, d.department_name
HAVING SUM(s.sale_amount) > 10000;

#4
SELECT e.*, s.sale_amount
FROM sales s
JOIN employee e ON e.emp_id = s.emp_id
WHERE s.sale_amount = (
    SELECT DISTINCT sale_amount
    FROM sales
    ORDER BY sale_amount DESC
    LIMIT 1 OFFSET 1
);

#5
SELECT *
FROM employee
WHERE salary > (SELECT MAX(sale_amount) FROM sales);




