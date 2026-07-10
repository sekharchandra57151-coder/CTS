-- Clean old tables
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
GO

USE OnlineRetailStore;
GO

---------------------------------------------------
-- Create Tables
---------------------------------------------------

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);
GO

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
-- Insert Sample Data
---------------------------------------------------

INSERT INTO Departments VALUES
(1,'HR'),
(2,'IT'),
(3,'Finance');
GO

INSERT INTO Employees VALUES
(1,'John','Doe',1,5000.00,'2020-01-15'),
(2,'Jane','Smith',2,6000.00,'2019-03-22'),
(3,'Bob','Johnson',3,5500.00,'2021-07-01');
GO

---------------------------------------------------
-- Exercise 1: Scalar Function
---------------------------------------------------

CREATE FUNCTION fn_CalculateAnnualSalary (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 12;
END;
GO

-- Test
SELECT EmployeeID, Salary,
dbo.fn_CalculateAnnualSalary(Salary) AS AnnualSalary
FROM Employees;
GO

---------------------------------------------------
-- Exercise 2: Table-Valued Function
---------------------------------------------------

CREATE FUNCTION fn_GetEmployeesByDepartment (@DepartmentID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM Employees
    WHERE DepartmentID = @DepartmentID
);
GO

-- Test (IT Department)
SELECT * FROM dbo.fn_GetEmployeesByDepartment(2);
GO

---------------------------------------------------
-- Exercise 3: User Defined Function
---------------------------------------------------

CREATE FUNCTION fn_CalculateBonus (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.10;
END;
GO

-- Test
SELECT EmployeeID, Salary,
dbo.fn_CalculateBonus(Salary) AS Bonus
FROM Employees;
GO

---------------------------------------------------
-- Exercise 4: Modify Function
---------------------------------------------------

ALTER FUNCTION fn_CalculateBonus (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.15;
END;
GO

-- Test Modified Function
SELECT EmployeeID, Salary,
dbo.fn_CalculateBonus(Salary) AS Bonus
FROM Employees;
GO

---------------------------------------------------
-- Exercise 5: Delete Function
---------------------------------------------------

DROP FUNCTION fn_CalculateBonus;
GO

-- Verify
SELECT OBJECT_ID('fn_CalculateBonus');
GO

---------------------------------------------------
-- Recreate Bonus Function (for next exercises)
---------------------------------------------------

CREATE FUNCTION fn_CalculateBonus (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.15;
END;
GO

---------------------------------------------------
-- Exercise 6: Execute Scalar Function
---------------------------------------------------

SELECT EmployeeID,
dbo.fn_CalculateAnnualSalary(Salary) AS AnnualSalary
FROM Employees;
GO

---------------------------------------------------
-- Exercise 7: Annual Salary for Specific Employee
---------------------------------------------------

SELECT EmployeeID,
dbo.fn_CalculateAnnualSalary(Salary) AS AnnualSalary
FROM Employees
WHERE EmployeeID = 1;
GO

---------------------------------------------------
-- Exercise 8: Finance Department Employees
---------------------------------------------------

SELECT * 
FROM dbo.fn_GetEmployeesByDepartment(3);
GO

---------------------------------------------------
-- Exercise 9: Nested Function
---------------------------------------------------

CREATE FUNCTION fn_CalculateTotalCompensation (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN dbo.fn_CalculateAnnualSalary(@Salary)
         + dbo.fn_CalculateBonus(@Salary);
END;
GO

-- Test
SELECT EmployeeID, Salary,
dbo.fn_CalculateTotalCompensation(Salary) AS TotalCompensation
FROM Employees;
GO

---------------------------------------------------
-- Exercise 10: Modify Nested Function
---------------------------------------------------

ALTER FUNCTION fn_CalculateTotalCompensation (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN dbo.fn_CalculateAnnualSalary(@Salary)
         + (@Salary * 0.20);
END;
GO

-- Test Modified Function
SELECT EmployeeID, Salary,
dbo.fn_CalculateTotalCompensation(Salary) AS TotalCompensation
FROM Employees;
GO