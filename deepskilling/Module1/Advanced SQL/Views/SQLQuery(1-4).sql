-- Drop old tables
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
GO

-- Drop old views if they exist
DROP VIEW IF EXISTS vw_EmployeeBasicInfo;
DROP VIEW IF EXISTS vw_EmployeeFullName;
DROP VIEW IF EXISTS vw_EmployeeAnnualSalary;
DROP VIEW IF EXISTS vw_EmployeeReport;
GO

USE OnlineRetailStore;
GO

---------------------------------------------------
-- Create Departments Table
---------------------------------------------------

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);
GO

---------------------------------------------------
-- Create Employees Table
---------------------------------------------------

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),
    Salary DECIMAL(10,2),
    JoinDate DATE
);
GO

---------------------------------------------------
-- Insert Departments
---------------------------------------------------

INSERT INTO Departments VALUES
(1,'HR'),
(2,'IT'),
(3,'Finance'),
(4,'Marketing');
GO

---------------------------------------------------
-- Insert Employees
---------------------------------------------------

INSERT INTO Employees VALUES
(101,'Alice','Johnson',1,30000,'2022-01-10'),
(102,'Bob','Smith',2,50000,'2021-06-15'),
(103,'Charlie','Brown',3,45000,'2020-03-20'),
(104,'David','Wilson',4,40000,'2019-09-05');
GO

---------------------------------------------------
-- Exercise 1: Simple View
---------------------------------------------------

CREATE VIEW vw_EmployeeBasicInfo AS
SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID;
GO

-- Output
SELECT * FROM vw_EmployeeBasicInfo;
GO

---------------------------------------------------
-- Exercise 2: Full Name View
---------------------------------------------------

CREATE VIEW vw_EmployeeFullName AS
SELECT
    EmployeeID,
    FirstName + ' ' + LastName AS FullName
FROM Employees;
GO

-- Output
SELECT * FROM vw_EmployeeFullName;
GO

---------------------------------------------------
-- Exercise 3: Annual Salary View
---------------------------------------------------

CREATE VIEW vw_EmployeeAnnualSalary AS
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    Salary * 12 AS AnnualSalary
FROM Employees;
GO

-- Output
SELECT * FROM vw_EmployeeAnnualSalary;
GO

---------------------------------------------------
-- Exercise 4: Employee Report View
---------------------------------------------------

CREATE VIEW vw_EmployeeReport AS
SELECT
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS FullName,
    d.DepartmentName,
    e.Salary * 12 AS AnnualSalary,
    (e.Salary * 12) * 0.10 AS Bonus
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID;
GO

-- Output
SELECT * FROM vw_EmployeeReport;
GO