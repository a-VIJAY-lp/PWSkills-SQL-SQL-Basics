-- 1) CREATE DATABASE & TABLE
CREATE DATABASE student_db;
USE student_db;

create table Student
(   student_id INT PRIMARY KEY, 
	name VARCHAR(50), 
	course VARCHAR(30), 
	score INT, 
	attendance INT, 
	mentor VARCHAR(50),
	join_date DATE, 
	city VARCHAR(50)
);

-- 2) INSERT SAMPLE DATA (change if your assignment gave specific rows)
INSERT INTO Student_Performance(student_id,name,course,score,attendance,mentor,join_date,city) VALUES 
(101,'Aarav Mehta','Data Science',88,92,'Dr. Sharma','2023-06-12','Mumbai'),
(102,'Riya Singh','Data Science',76,85,'Dr. Sharma','2023-07-01','Delhi'),
(103,'Kabir Khanna','Python',91,96,'Ms. Nair','2023-06-20','Mumbai'),
(104,'Tanvi Patel','SQL',84,89,'Mr. Iyer','2023-05-30','Bengaluru'),
(105,'Ayesha Khan','Python',67,81,'Ms. Nair','2023-07-10','Hyderabad'),
(106,'Dev Sharma','SQL',73,78,'Mr. Iyer','2023-05-28','Pune'),
(107,'Arjun Verma','Tableau',95,98,'Ms. Kapoor','2023-06-15','Delhi'),
(108,'Meera Pillai','Tableau',82,87,'Ms. Kapoor','2023-06-18','Kochi'),
(109,'Nikhil Rao','Data Science',79,82,'Dr. Sharma','2023-07-05','Chennai'),
(110,'Priya Desai','SQL',92,94,'Mr. Iyer','2023-05-27','Bengaluru'),
(111,'Siddharth Jain','Python',85,90,'Ms. Nair','2023-07-02','Mumbai'),
(112,'Sneha Kulkarni','Tableau',74,83,'Ms. Kapoor','2023-06-10','Pune'),
(113,'Rohan Gupta','SQL',89,91,'Mr. Iyer','2023-05-25','Delhi'),
(114,'Ishita Joshi','Data Science',93,97,'Dr. Sharma','2023-06-25','Bengaluru'),
(115,'Yuvraj Rao','Python',71,84,'Ms. Nair','2023-07-12','Hyderabad');
#1
SELECT
    student_id,
    name,
    score,
    RANK() OVER (ORDER BY score DESC) AS score_rank
FROM student;

#2
SELECT
    student_id,
    name,
    score,
    LAG(score) OVER (ORDER BY score DESC) AS prev_score
FROM student;

#3
SELECT
    student_id,
    UPPER(name) AS student_name_upper,
    join_date,
    MONTHNAME(join_date) AS join_month
FROM student;

#4
SELECT
    student_id,
    name,
    attendance,
    LEAD(attendance) OVER (ORDER BY attendance) AS next_attendance
FROM student;

#5
SELECT
    student_id,
    name,
    score,
    NTILE(4) OVER (ORDER BY score DESC) AS performance_group
FROM student;

#6
SELECT
    student_id,
    name,
    course,
    attendance,
    ROW_NUMBER() OVER (
        PARTITION BY course
        ORDER BY attendance DESC
    ) AS attendance_rank_in_course
FROM student;

#7
SELECT
    student_id,
    name,
    join_date,
    DATEDIFF('2025-01-01', join_date) AS days_enrolled
FROM student;

#8
SELECT
    student_id,
    name,
    DATE_FORMAT(join_date, '%M %Y') AS join_month_year
FROM student;

#9
SELECT
    student_id,
    name,
    course,
    score,
    join_date,
    attendance,
    CASE
        WHEN city = 'Mumbai' THEN 'MUM'
        ELSE city
    END AS display_city
FROM student;

#10
SELECT
    student_id,
    name,
    course,
    score,
    FIRST_VALUE(score) OVER (
        PARTITION BY course
        ORDER BY score DESC
    ) AS highest_score_in_course
FROM student;
