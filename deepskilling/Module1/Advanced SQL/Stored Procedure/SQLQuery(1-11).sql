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
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
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
(2,'Finance'),
(3,'IT'),
(4,'Marketing');
GO

INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary, JoinDate)
VALUES
('John','Doe',1,5000,'2020-01-15'),
('Jane','Smith',2,6000,'2019-03-22'),
('Michael','Johnson',3,7000,'2018-07-30'),
('Emily','Davis',4,5500,'2021-11-05');
GO

---------------------------------------------------
-- Exercise 1: Create Stored Procedure
---------------------------------------------------

CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT *
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

EXEC sp_GetEmployeesByDepartment 1;
GO

---------------------------------------------------
-- Exercise 2: Modify Stored Procedure
---------------------------------------------------

ALTER PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT EmployeeID, FirstName, LastName, Salary
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

EXEC sp_GetEmployeesByDepartment 1;
GO

---------------------------------------------------
-- Exercise 3: Delete Stored Procedure
---------------------------------------------------

DROP PROCEDURE IF EXISTS sp_InsertEmployee;
GO

---------------------------------------------------
-- Exercise 4: Execute Stored Procedure
---------------------------------------------------

EXEC sp_GetEmployeesByDepartment 2;
GO

---------------------------------------------------
-- Exercise 5: Return Total Employees
---------------------------------------------------

CREATE PROCEDURE sp_CountEmployees
    @DepartmentID INT
AS
BEGIN
    SELECT COUNT(*) AS TotalEmployees
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

EXEC sp_CountEmployees 3;
GO

---------------------------------------------------
-- Exercise 6: Output Parameter
---------------------------------------------------

CREATE PROCEDURE sp_TotalSalary
    @DepartmentID INT,
    @TotalSalary DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @TotalSalary = SUM(Salary)
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

DECLARE @Result DECIMAL(10,2);

EXEC sp_TotalSalary 1, @Result OUTPUT;

SELECT @Result AS TotalSalary;
GO

---------------------------------------------------
-- Exercise 7: Multiple Parameters
---------------------------------------------------

CREATE PROCEDURE sp_UpdateEmployeeSalary
    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)
AS
BEGIN
    UPDATE Employees
    SET Salary = @NewSalary
    WHERE EmployeeID = @EmployeeID;
END;
GO

EXEC sp_UpdateEmployeeSalary 1, 5500.00;
GO

SELECT * FROM Employees;
GO

---------------------------------------------------
-- Exercise 8: Conditional Logic
---------------------------------------------------

CREATE PROCEDURE sp_GiveBonus
    @DepartmentID INT,
    @BonusAmount DECIMAL(10,2)
AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + @BonusAmount
    WHERE DepartmentID = @DepartmentID;
END;
GO

EXEC sp_GiveBonus 1, 500;
GO

SELECT * FROM Employees;
GO

---------------------------------------------------
-- Exercise 9: Transaction
---------------------------------------------------

CREATE PROCEDURE sp_TransactionSalaryUpdate
    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)
AS
BEGIN
    BEGIN TRANSACTION;

    UPDATE Employees
    SET Salary = @NewSalary
    WHERE EmployeeID = @EmployeeID;

    COMMIT TRANSACTION;
END;
GO

EXEC sp_TransactionSalaryUpdate 2, 6500;
GO

---------------------------------------------------
-- Exercise 10: Dynamic SQL
---------------------------------------------------

CREATE PROCEDURE sp_DynamicSearch
    @ColumnName VARCHAR(50),
    @Value VARCHAR(50)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = 'SELECT * FROM Employees WHERE ' 
               + @ColumnName + ' = ''' + @Value + '''';

    EXEC sp_executesql @SQL;
END;
GO

EXEC sp_DynamicSearch 'FirstName', 'John';
GO

---------------------------------------------------
-- Exercise 11: Error Handling
---------------------------------------------------

CREATE PROCEDURE sp_SafeSalaryUpdate
    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        UPDATE Employees
        SET Salary = @NewSalary
        WHERE EmployeeID = @EmployeeID;

        PRINT 'Salary Updated Successfully';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred while updating salary';
    END CATCH
END;
GO

EXEC sp_SafeSalaryUpdate 3, 8000;
GO