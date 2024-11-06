-- Create the department table
CREATE TABLE dept (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(255),
    dept_location VARCHAR(255)
);

-- Create the employee table
CREATE TABLE employee (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_id INT,
    emp_fname VARCHAR(255),
    emp_lname VARCHAR(255),
    emp_position VARCHAR(255),
    emp_salary INT,
    emp_join_date DATE,
    FOREIGN KEY (dept_id) REFERENCES dept(dept_id)
);

-- Create the projects table
CREATE TABLE projects (
    proj_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_id INT,
    proj_name VARCHAR(255),
    proj_location VARCHAR(255),
    proj_cost INT,
    proj_year INT,
    FOREIGN KEY (dept_id) REFERENCES dept(dept_id) ON DELETE CASCADE
);

-- Insert values into the dept table
INSERT INTO dept(dept_name, dept_location)
VALUES  ("Administration", "Mumbai"),
        ("IT", "Bangalore"),
        ("Finance", "Mumbai"),
        ("IT", "Pune"),
        ("Marketing", "Mumbai"),
        ("Production", "Kolkata"),
        ("Business", "Nashik"),
        ("Sales", "Nagpur");

-- Insert values into the employee table
INSERT INTO employee (dept_id, emp_fname, emp_lname, emp_position, emp_salary, emp_join_date)
VALUES  (2, 'Ayush', 'Chavan', 'Project Manager', 2000000, '2024-02-05'),
        (6, 'Aditya', 'Bhosle', 'Manager', 1000000, '2022-06-12'),
        (8, 'Bhushan', 'Joshi', 'Accountant', 800000, '2025-08-12'),
        (1, 'Amit', 'Kumar', 'HR Manager', 900000, '2023-02-15'),
        (4, 'Sneha', 'Verma', 'Software Engineer', 9000000, '2024-11-20'),
        (5, 'Priya', 'Sharma', 'Marketing Coordinator', 2500000, '2023-07-10'),
        (5, 'Piyush', 'Sahoo', 'Financial Analyst', 3000000, '2023-07-10'),
        (7, 'Rahul', 'Gupta', 'Business Analyst', 1500000, '2024-04-30');

-- Insert values into the projects table
INSERT INTO projects (dept_id, proj_name, proj_location, proj_cost, proj_year)
VALUES  (8, "Development of CRM", "Pune", 70000, 2020),
        (6, 'Design of New Products', 'Bangalore', 1000000, 2024),
        (3, 'Financial Analysis System', 'Mumbai', 100000, 2024),
        (1, 'HR Training Program', 'Mumbai', 200000, 2019),
        (4, 'IT System Upgrade', 'Pune', 1200000, 2024),
        (5, 'Marketing Campaign', 'Mumbai', 100000, 2020),
        (7, 'Business Expansion Plan', 'Nashik', 2500000, 2024),
        (8, 'Sales Strategy Revamp', 'Nagpur', 75000, 2024);

-- Query for employees in IT or Computer department whose first name starts with 'p' or 'h'
SELECT * FROM employee 
WHERE dept_id IN (SELECT dept_id FROM dept WHERE dept_name = 'IT') 
AND (emp_fname LIKE 'p%' OR emp_fname LIKE 'h%');

-- Query for unique employee positions
SELECT emp_position FROM employee GROUP BY emp_position HAVING COUNT(emp_position) = 1;

-- Update employee salary for those who joined before 1985 (no entries based on your data)
UPDATE employee
SET emp_salary = emp_salary * 1.1
WHERE emp_join_date < '1985-01-01';

-- Delete departments located in Mumbai
DELETE FROM dept WHERE dept_location = 'Mumbai';

-- Select project names in Pune
SELECT proj_name FROM projects WHERE proj_location = 'Pune';

-- Select projects with cost between 1,000,000 and 5,000,000
SELECT * FROM projects WHERE proj_cost BETWEEN 1000000 AND 5000000;

-- Get maximum and average project costs grouped by project name
-- SELECT proj_name, MAX(proj_cost) AS "Maximum Cost", AVG(proj_cost) AS "Average Project Cost"
-- FROM projects GROUP BY proj_name;

-- Query for maximum priced project
SELECT proj_name, proj_cost
FROM projects
WHERE proj_cost = (SELECT MAX(proj_cost) FROM projects);

-- Query for average project cost
SELECT AVG(proj_cost) AS "Average Project Cost"
FROM projects;

-- Select employee names ordered by last name descending
SELECT emp_id, emp_fname, emp_lname 
FROM employee 
ORDER BY emp_lname DESC;

-- Select project details for specific years
SELECT proj_name AS "Name", proj_location AS "Location", proj_cost AS "Cost" 
FROM projects
WHERE proj_year IN (2004, 2005, 2007);
