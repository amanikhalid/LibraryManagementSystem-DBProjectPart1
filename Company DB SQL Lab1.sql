--1. Display all the employees Data.
SELECT * FROM Employee;

--2. Display the employee First name, last name, Salary and Department number.
SELECT Fname, Lname, Salary, Dno FROM Employee;

-- 3.Display all the projects names, locations and the department which is responsible about it.
SELECT Pname, Plocation, Dnum FROM Project;

-- 4.Display each employee full name and his annual commission (10% of annual salary)
SELECT 
  Fname + ' ' + Lname AS FullName,
  Salary * 12 * 0.10 AS ANNUAL_COMM
FROM Employee;

-- 5.Display the employees Id, name who earns more than 1000 LE monthly.
SELECT SSN, Fname + ' ' + Lname AS FullName
FROM Employee
WHERE Salary > 1000;

-- 6.Display the employees Id, name who earns more than 10000 LE annually.
SELECT SSN, Fname + ' ' + Lname AS FullName
FROM Employee
WHERE Salary * 12 > 10000;

-- 7.Display the names and salaries of the female employees
SELECT Fname + ' ' + Lname AS FullName, Salary
FROM Employee
WHERE Sex = 'F';

-- 8. Display each department id, name which is managed by a manager with id = 968574.
SELECT Dnum, Dname
FROM Departments
WHERE MGRSSN = 968574;

-- 9. Display the ids, names and locations of the projects controlled by department 10.
SELECT Pnumber, Pname, Plocation
FROM Project
WHERE Dnum = 10;

-- 10. Insert your personal data to the employee table
INSERT INTO Employee (Fname, Lname, SSN, Dno, Superssn, Salary)
VALUES ('Amani', 'Alshekaili', 102622, 30, 112233, 3000);

-- 11. Insert your friend's data with NULL salary and supervisor
INSERT INTO Employee (Fname, Lname, SSN, Dno)
VALUES ('Farid', 'AlAlawi', 102669, 30);

-- 12. Upgrade your salary by 20% of its last value
UPDATE Employee
SET Salary = Salary * 1.20
WHERE SSN = 102672;


-- 8. Display each department id, name which managed by a manager with id equals 968574.
SELECT Dnum, Dname
FROM Departments
WHERE MGRSSN = 968574;

-- 9. Display the ids, names and locations of the projects which controlled by department 10.
SELECT Pnumber, Pname, Plocation
FROM Project
WHERE Dnum = 10;

-- 10. Insert your personal data to the employee table as a new employee in department number 30
INSERT INTO Employee (Fname, Lname, SSN, Dno, Superssn, Salary)
VALUES ('Amani', 'Alshekaili', 112672, 30, 112233, 3000);

-- 11. Insert another employee with your friend’s data and null salary and supervisor
INSERT INTO Employee (Fname, Lname, SSN, Dno)
VALUES ('Farid', 'AlAlawi', 112660, 30);

-- 12. Upgrade your salary by 20 % of its last value
UPDATE Employee
SET Salary = Salary * 1.20
WHERE SSN = 102672;
