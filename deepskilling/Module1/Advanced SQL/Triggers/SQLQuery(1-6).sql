-- Clean old tables
DROP TABLE IF EXISTS EmployeeChanges;
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
(2,'Finance'),
(3,'IT'),
(4,'Marketing');
GO

INSERT INTO Employees VALUES
(1,'John','Doe',1,5000.00,'2022-01-15'),
(2,'Jane','Smith',2,6000.00,'2021-03-22'),
(3,'Michael','Johnson',3,7000.00,'2020-07-30'),
(4,'Emily','Davis',4,5500.00,'2019-11-05');
GO

---------------------------------------------------
-- Exercise 1: AFTER Trigger
---------------------------------------------------

CREATE TABLE EmployeeChanges (
    ChangeID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    ChangeDate DATETIME DEFAULT GETDATE()
);
GO

CREATE TRIGGER trg_AfterSalaryUpdate
ON Employees
AFTER UPDATE
AS
BEGIN
    INSERT INTO EmployeeChanges (EmployeeID, OldSalary, NewSalary)
    SELECT 
        d.EmployeeID,
        d.Salary,
        i.Salary
    FROM deleted d
    INNER JOIN inserted i
    ON d.EmployeeID = i.EmployeeID
    WHERE d.Salary <> i.Salary;
END;
GO

-- Test Trigger
UPDATE Employees
SET Salary = 5500
WHERE EmployeeID = 1;
GO

SELECT * FROM EmployeeChanges;
GO

---------------------------------------------------
-- Exercise 2: INSTEAD OF DELETE Trigger
---------------------------------------------------

CREATE TRIGGER trg_PreventDelete
ON Employees
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR ('Deletion of employee records is not allowed.',16,1);
END;
GO

-- Test Trigger
DELETE FROM Employees WHERE EmployeeID = 2;
GO

---------------------------------------------------
-- Exercise 3: LOGON Trigger
---------------------------------------------------
-- Must be created in master database

USE master;
GO

CREATE TRIGGER trg_RestrictLogin
ON ALL SERVER
FOR LOGON
AS
BEGIN
    IF DATEPART(HOUR, GETDATE()) BETWEEN 2 AND 3
    BEGIN
        ROLLBACK;
        PRINT 'Login restricted during maintenance hours.';
    END
END;
GO

---------------------------------------------------
-- Return to Database
---------------------------------------------------

USE OnlineRetailStore;
GO

---------------------------------------------------
-- Exercise 4: Modify Trigger
---------------------------------------------------

ALTER TRIGGER trg_AfterSalaryUpdate
ON Employees
AFTER UPDATE
AS
BEGIN
    INSERT INTO EmployeeChanges (EmployeeID, OldSalary, NewSalary)
    SELECT 
        d.EmployeeID,
        d.Salary,
        i.Salary
    FROM deleted d
    INNER JOIN inserted i
    ON d.EmployeeID = i.EmployeeID
    WHERE d.Salary <> i.Salary;

    PRINT 'Salary updated successfully.';
END;
GO

---------------------------------------------------
-- Exercise 5: Delete Trigger
---------------------------------------------------

DROP TRIGGER trg_PreventDelete;
GO

---------------------------------------------------
-- Exercise 6: Computed Column Update Trigger
---------------------------------------------------

ALTER TABLE Employees
ADD AnnualSalary DECIMAL(10,2);
GO

CREATE TRIGGER trg_UpdateAnnualSalary
ON Employees
AFTER UPDATE
AS
BEGIN
    UPDATE Employees
    SET AnnualSalary = Salary * 12
    WHERE EmployeeID IN (SELECT EmployeeID FROM inserted);
END;
GO

-- Test Trigger
UPDATE Employees
SET Salary = 8000
WHERE EmployeeID = 3;
GO

SELECT * FROM Employees;
GO