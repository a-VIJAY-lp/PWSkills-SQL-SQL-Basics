#1)
CREATE DATABASE company_db;
create table employees (
 employee_id INT  PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  department VARCHAR(50),
  salary int,
  hire_date date
  );
  
  #2
insert into employees (employee_id,first_name,last_name,department,salary,hire_date)
values(101,'Amit','Sharma','HR',50000,'2020-01-15'),
(102,'Riya','Kapoor','Sales',75000,'2019-03-22'),
(103,'Raj','Mehta','IT',90000,'2018-07-11'),
(104,'Neha','Verma','IT',85000,'2021-09-01'),
(105,'Arjun','Singh','Finance',60000,'2022-02-10');


select * from employees;
#3)
select * from employees order by salary;
SELECT * FROM employees  order by salary ASC;
#4)	;
select * from employees order by department,salary desc;
select * from employees order by department ASC, salary DESC;
#5)
select * from employees where department='IT' order by hire_date desc
#6)
create table sales(
sale_id   INT AUTO_INCREMENT PRIMARY KEY,
customer_name VARCHAR(50),
amount int,
 sale_date date
  );
INSERT INTO sales (sale_id, customer_name, amount, sale_date)
VALUES
(1, 'Aditi', 1500, '2024-08-01'),
(2, 'Rohan', 2200, '2024-08-03'),
(3, 'Aditi', 3500, '2024-09-05'),
(4, 'Meena', 2700, '2024-09-15'),
(5, 'Rohan', 4500, '2024-09-25');

#7)
SELECT * FROM sales ORDER BY amount DESC;
#8)
SELECT * FROM sales WHERE customer_name = 'Aditi';
#9)A primary key uniquely identifies each row in a table and cannot be null. A foreign key is a column in one table that refers to the primary key of another table to create a relationship between the two tables.
#10)	Constraints are rules applied to table columns to control the type of data that can be stored, such as primary key, foreign key, unique and not null check. They are used to maintain data integrity, prevent invalid data entry, and enforce relationships between tables.
