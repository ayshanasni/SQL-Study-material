USE assignment;
CREATE TABLE patients (
    Patient_ID         INT PRIMARY KEY,
    Patient_Name       VARCHAR(50),
    Age                INT,
    Gender             VARCHAR(10),
    Department         VARCHAR(30),
    Diagnosis          VARCHAR(50),
    Doctor_Name        VARCHAR(50),
    Admission_Date     DATE,
    Treatment_Cost     DECIMAL(10,2),
    Email              VARCHAR(60),
    Phone              VARCHAR(15),
    Insurance_Provider VARCHAR(40)
);

INSERT INTO patients VALUES
(1, 'Anita Menon', 34, 'Female', 'Cardiology', 'Hypertension', 'Dr. Nair', '2025-01-10', 45000, 'anita@mail.com', '9876500001', 'Star Health'),
(2, 'Arun Kumar', 52, 'Male', 'Cardiology', 'Heart Failure', 'Dr. Nair', '2025-01-15', 120000, NULL, '9876500002', NULL),
(3, 'Rahul Das', 28, 'Male', 'Orthopedics', 'Fracture', 'Dr. Thomas', '2025-02-02', 60000, 'rahul@mail.com', NULL, 'HDFC Ergo'),
(4, 'Sneha Pillai', 41, 'Female', 'Neurology', 'Migraine', 'Dr. Iyer', '2025-02-10', 25000, NULL, NULL, NULL),
(5, 'Vijay Anand', 67, 'Male', 'Neurology', 'Stroke', 'Dr. Iyer', '2025-02-18', 150000, 'vijay@mail.com', '9876500005', 'Star Health'),
(6, 'Meera Joseph', 23, 'Female', 'Pediatrics', 'Viral Fever', 'Dr. George', '2025-03-01', 8000, 'meera@mail.com', '9876500006', NULL),
(7, 'Alan Varghese', 8, 'Male', 'Pediatrics', 'Asthma', 'Dr. George', '2025-03-05', NULL, NULL, '9876500007', 'New India Assurance'),
(8, 'Nisha Raj', 45, 'Female', 'Orthopedics', 'Knee Replacement', 'Dr. Thomas', '2025-03-12', 180000, 'nisha@mail.com', '9876500008', 'HDFC Ergo'),
(9, 'Ajay Krishnan', 59, 'Male', 'Cardiology', 'Angioplasty', 'Dr. Nair', '2025-03-20', NULL, 'ajay@mail.com', NULL, 'Star Health'),
(10, 'Fathima Beevi', 36, 'Female', 'Gynecology', 'Pregnancy Care', 'Dr. Susan', '2025-04-02', 35000, NULL, '9876500010', 'New India Assurance'),
(11, 'Kiran Nair', 31, 'Male', 'Dermatology', 'Eczema', 'Dr. Paul', '2025-04-08', 6000, 'kiran@mail.com', '9876500011', NULL),
(12, 'Anjali Suresh', 26, 'Female', 'Dermatology', 'Acne', 'Dr. Paul', '2025-04-15', 4500, 'anjali@mail.com', NULL, NULL),
(13, 'Naveen Mathew', 49, 'Male', 'Oncology', 'Lung Cancer', 'Dr. Rao', '2025-05-01', 300000, 'naveen@mail.com', '9876500013', 'HDFC Ergo'),
(14, 'Divya Menon', 38, 'Female', 'Oncology', 'Breast Cancer', 'Dr. Rao', '2025-05-10', 250000, NULL, '9876500014', 'Star Health'),
(15, 'Sam Eapen', 72, 'Male', 'Neurology', 'Parkinsons', 'Dr. Iyer', '2025-05-18', NULL, NULL, NULL, NULL);

-- Q1. Display all the details from the patients table.
SELECT * FROM patients;

-- Q2. Find the unique departments in the hospital.
SELECT DISTINCT Department
FROM patients;

-- Q3. Find patients whose name starts with the letter A.
SELECT *
FROM patients
WHERE Patient_Name LIKE 'A%';

-- Q4. Find patients whose name ends with the letter n.
SELECT * FROM
patients
WHERE Patient_Name LIKE '%N';

-- Q5. Using a CTE, find the average treatment cost for each department, then display only the departments
-- where the average cost is greater than ₹50,000.
WITH DepartmentCost AS (
    SELECT
        Department,
        AVG(Treatment_Cost) AS Average_Cost
    FROM patients
    GROUP BY Department
)

SELECT * FROM
DepartmentCost
WHERE Average_Cost>50000;

-- Q6. Using a CTE, calculate the number of patients handled by each doctor,
-- then display only doctors who handled more than 2 patients.
WITH patientcount AS
(
     SELECT Doctor_Name,
     COUNT(Patient_ID) AS numberofpatient
     FROM patients
     GROUP BY Doctor_Name
)
 
 SELECT * FROM patientcount
 WHERE numberofpatient > 2;

-- Q7. Write Question 5 without a CTE (using GROUP BY and HAVING) and compare both approaches.
--  Write 2 lines on which one is easier to read.
SELECT Department,
AVG(Treatment_Cost) AS Average_Cost
FROM patients
GROUP BY Department
HAVING Average_Cost>50000;

-- The CTE approach is easier to read because it separates the calculation and filtering into two steps.
-- The GROUP BY and HAVING approach is shorter and simpler for this particular query.

-- Q8. Create a column Cost_Category using these rules, and display Patient_Name, Department, Treatment_Cost, and Cost_Category:
-- –	Treatment_Cost ≥ 150000 → 'Critical Care'
-- –	Treatment_Cost ≥ 50000 → 'Moderate'
-- –	Otherwise → 'Basic'

SELECT Patient_Name , Department , Treatment_Cost , 
CASE
    WHEN Treatment_Cost >= 150000 THEN 'Critical Care'
    WHEN Treatment_Cost >=50000 THEN 'Moderate'
    ELSE 'Basic'
  END AS Cost_Category
FROM patients;

-- Q9. Create a column Age_Group:
-- –	Age < 18 → 'Child'
-- –	Age between 18 and 59 → 'Adult'
-- –	Age ≥ 60 → 'Senior'
SELECT AGE,
CASE
    WHEN Age < 18 THEN 'Child'
    WHEN Age BETWEEN 18 AND 59 THEN 'Adult'
    WHEN Age >= 60 THEN 'Senior'
 END AS Age_Group
FROM patients;

-- Q10. Using CASE, create a column Insurance_Status that shows 'Insured' 
-- if Insurance_Provider is not NULL, otherwise 'Self-Pay'.
SELECT Insurance_Provider,
CASE 
    WHEN Insurance_Provider IS NOT NULL THEN 'Insured'
    ELSE 'Self-Pay'
 END AS Insurance_Status
FROM patients;

-- Q11. ISNULL(): Find all patients whose Treatment_Cost is missing.
SELECT * FROM patients
WHERE ISNULL(Treatment_Cost);

-- Q12. IFNULL(): Display Patient_Name and Treatment_Cost, replacing a missing cost with 0.
SELECT Patient_Name , 
IFNULL(Treatment_Cost,0) AS MissingCost
FROM patients;

-- Q13. COALESCE(): Create a Contact_Info column that shows Email first, 
-- then Phone, and if both are missing shows 'No Contact Available'.
SELECT Patient_Name,
COALESCE(Email,Phone,'No Contact Available')
FROM patients;

-- Q14. Fill in the blanks:
-- IFNULL use ----> Replaces a NULL value with a specified alternative value.
-- ISNULL use ----> Checks whether a value is NULL. Returns 1 if NULL, otherwise 0 (in MySQL).
-- COALESCE use ----> Returns the first non-NULL value from a list of expressions.

-- Q15. Using a CTE + CASE, first calculate the average treatment cost per department (use IFNULL to treat missing costs as 0). 
-- Then label each department as:
-- –'High Revenue' (average > 100000)
-- –'Medium Revenue' (average between 30000 and 100000)
-- –'Low Revenue' (otherwise)

WITH DepartmentCost AS (
    SELECT
        Department,
        AVG(IFNULL(Treatment_Cost,0)) AS Average_Cost,
		CASE 
	       WHEN AVG(IFNULL(Treatment_Cost,0)) > 100000 THEN 'High Revenue'
		   WHEN AVG(IFNULL(Treatment_Cost,0)) BETWEEN 30000 AND 100000 THEN 'Medium Revenue'
		   ELSE 'Low Revenue'
		 END AS Average_level
    FROM patients
    GROUP BY Department
)
SELECT * FROM DepartmentCost;

-- Q16. Find the number of patients with no contact details (both Email and Phone are NULL) in each department.
SELECT
    Department,
    COUNT(*) AS Patient_Count
FROM patients
WHERE Email IS NULL
AND Phone IS NULL
GROUP BY Department;

-- Q17. Find the total treatment cost for each insurance provider, showing 'Self-Pay' for 
-- patients with no provider and treating missing costs as 0.
SELECT 
     COALESCE(Insurance_Provider,'Self-Pay') AS Insurance_name,
     SUM(IFNULL(Treatment_Cost,0)) AS Treatmentlevel
FROM patients
GROUP BY Insurance_name;

-- Q18. Use any Text-to-SQL AI tool to generate queries for the following English questions:
-- –	"Show all patients admitted after March 2025."

SELECT * FROM patients
WHERE Admission_Date > '2025-03-31';

-- –	"Show the highest treatment cost in each department."
 
 SELECT Department,
 MAX(Treatment_Cost) AS Highest_Treatmentcost
 FROM patients
 GROUP BY Department;
 
-- –	"Show patients older than 60 who are treated in the Neurology department."
   
   SELECT Patient_Name,Department,Age
   FROM patients
   WHERE Age > 60 AND Department='Neurology';
   
  --  Q19. For each generated query, answer:
-- –	Was the query correct? Run it on your dataset to verify.
-- –	Did the AI handle NULL values properly?
-- –	What changes (if any) did you have to make?
-- **1. Show all patients admitted after March 2025.**

-- - The query was correct and executed successfully.
-- - NULL values in the Admission_Date column were automatically excluded.
-- - No major changes were required.

-- **2. Show the highest treatment cost in each department.**

-- - The query was correct and returned the highest treatment cost for each department.
-- - NULL values in Treatment_Cost were ignored by the MAX() function.
-- - No major changes were required.

-- **3. Show patients older than 60 who are treated in the Neurology department.**

-- - The query was correct and returned patients satisfying both conditions.
-- - NULL values in Age or Department were automatically excluded.
-- - No major changes were required.

-- Q20. Create a summary report with one row per department showing the columns below. Use a CTE to organize your solution.
-- •	Department
-- •	Total patients
-- •	Total treatment cost (NULL treated as 0)
-- •	Number of patients with missing treatment cost
-- •	Revenue level (using CASE)
WITH DepartmentSummary AS
(
    SELECT
        Department,
        COUNT(Patient_ID) AS Total_Patients,
        SUM(IFNULL(Treatment_Cost, 0)) AS Total_Treatment_Cost,
        SUM(CASE
                WHEN Treatment_Cost IS NULL THEN 1
                ELSE 0
            END) AS Missing_Treatment_Cost
    FROM patients
    GROUP BY Department
)

SELECT
    Department,
    Total_Patients,
    Total_Treatment_Cost,
    Missing_Treatment_Cost,
    CASE
        WHEN Total_Treatment_Cost > 100000 THEN 'High Revenue'
        WHEN Total_Treatment_Cost BETWEEN 30000 AND 100000 THEN 'Medium Revenue'
        ELSE 'Low Revenue'
    END AS Revenue_Level
FROM DepartmentSummary;


   
      

 