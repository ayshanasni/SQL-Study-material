# SQL ASSIGNMENT – FULL OUTER JOIN

### 1. Create Student Table


CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    CourseID INT
);

INSERT INTO Student VALUES
(1, 'Aisha', 201),
(2, 'Arjun', 202),
(3, 'Diya', 203),
(4, 'Rahul', 204),
(5, 'Sneha', NULL);

### 2. Create Course Table


CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);

INSERT INTO Course VALUES
(201, 'Python'),
(202, 'Data Science'),
(203, 'SQL'),
(205, 'Power BI'),
(206, 'Machine Learning');

### 3. Display Both Tables


SELECT * FROM Student;

SELECT * FROM Course;

### 4. Assignment Questions

-- **Q1.** Display all students and all courses, including records that do not have matching values in both tables.
 SELECT *
FROM Student
LEFT JOIN Course
ON Student.CourseID = Course.CourseID

UNION

SELECT *
FROM Student
RIGHT JOIN Course
ON Student.CourseID = Course.CourseID;

-- **Q2.** Display StudentID, StudentName, CourseID and CourseName.
SELECT Student.StudentID,
       Student.StudentName,
       Student.CourseID,
       Course.CourseName
FROM Student
INNER JOIN Course
ON Student.CourseID = Course.CourseID;

-- **Q3.** Write a query to achieve FULL OUTER JOIN using LEFT JOIN, RIGHT JOIN and UNION.
SELECT Student.StudentID,
       Student.StudentName,
       Student.CourseID,
       Course.CourseName
FROM Student
LEFT JOIN Course
ON Student.CourseID = Course.CourseID

UNION

SELECT Student.StudentID,
       Student.StudentName,
       Student.CourseID,
       Course.CourseName
FROM Student
RIGHT JOIN Course
ON Student.CourseID = Course.CourseID;
