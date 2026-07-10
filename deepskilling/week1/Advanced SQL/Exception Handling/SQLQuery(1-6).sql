---------------------------------------------------
-- CLEAN OLD OBJECTS
---------------------------------------------------

DROP PROCEDURE IF EXISTS AddEmployee;
DROP PROCEDURE IF EXISTS TransferEmployee;
DROP PROCEDURE IF EXISTS BatchInsertEmployees;
GO

DROP TABLE IF EXISTS AuditLog;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
GO

USE OnlineRetailStore;
GO

---------------------------------------------------
-- CREATE TABLES
---------------------------------------------------

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Salary DECIMAL(10,2),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
GO

CREATE TABLE AuditLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    Action VARCHAR(100),
    ErrorMessage VARCHAR(4000),
    ActionDate DATETIME DEFAULT GETDATE()
);
GO

---------------------------------------------------
-- INSERT SAMPLE DATA
---------------------------------------------------

INSERT INTO Departments VALUES
(1,'HR'),
(2,'IT'),
(3,'Finance');
GO

INSERT INTO Employees VALUES
(1,'John','Doe','john@example.com',5000,1),
(2,'Jane','Smith','jane@example.com',6000,2);
GO

---------------------------------------------------
-- QUESTION 1: BASIC TRY...CATCH
---------------------------------------------------

CREATE PROCEDURE AddEmployee
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Employees
        VALUES (
            @EmployeeID,
            @FirstName,
            @LastName,
            @Email,
            @Salary,
            @DepartmentID
        );
    END TRY

    BEGIN CATCH
        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('AddEmployee', ERROR_MESSAGE());
    END CATCH
END;
GO

---------------------------------------------------
-- VALID TEST
---------------------------------------------------

EXEC AddEmployee
3,'Bob','Johnson','bob@example.com',5500,3;
GO

---------------------------------------------------
-- QUESTION 2: THROW (Modify Procedure)
---------------------------------------------------

ALTER PROCEDURE AddEmployee
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Employees
        VALUES (
            @EmployeeID,
            @FirstName,
            @LastName,
            @Email,
            @Salary,
            @DepartmentID
        );
    END TRY

    BEGIN CATCH
        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('AddEmployee', ERROR_MESSAGE());

        THROW;
    END CATCH
END;
GO

---------------------------------------------------
-- QUESTION 3: CUSTOM VALIDATION
---------------------------------------------------

ALTER PROCEDURE AddEmployee
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT
AS
BEGIN
    IF @Salary <= 0
    BEGIN
        PRINT 'Salary must be greater than zero.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Employees
        VALUES (
            @EmployeeID,
            @FirstName,
            @LastName,
            @Email,
            @Salary,
            @DepartmentID
        );
    END TRY

    BEGIN CATCH
        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('AddEmployee', ERROR_MESSAGE());
    END CATCH
END;
GO

---------------------------------------------------
-- VALID TEST
---------------------------------------------------

EXEC AddEmployee
4,'Sam','Wilson','sam@example.com',4500,2;
GO

---------------------------------------------------
-- QUESTION 4: NESTED TRY...CATCH
---------------------------------------------------

CREATE PROCEDURE TransferEmployee
    @EmployeeID INT,
    @NewDepartmentID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRY
            UPDATE Employees
            SET DepartmentID = @NewDepartmentID
            WHERE EmployeeID = @EmployeeID;
        END TRY

        BEGIN CATCH
            INSERT INTO AuditLog (Action, ErrorMessage)
            VALUES ('TransferEmployee', ERROR_MESSAGE());
        END CATCH
    END TRY

    BEGIN CATCH
        PRINT 'Outer Catch Block';
    END CATCH
END;
GO

---------------------------------------------------
-- VALID TEST
---------------------------------------------------

EXEC TransferEmployee 1,2;
GO

---------------------------------------------------
-- QUESTION 5: TRANSACTION + TRY...CATCH
---------------------------------------------------

CREATE PROCEDURE BatchInsertEmployees
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Employees VALUES
        (5,'Alice','Brown','alice@example.com',4500,1);

        INSERT INTO Employees VALUES
        (6,'Tom','Harris','tom@example.com',5000,2);

        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;

        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('BatchInsertEmployees', ERROR_MESSAGE());
    END CATCH
END;
GO

---------------------------------------------------
-- VALID TEST
---------------------------------------------------

EXEC BatchInsertEmployees;
GO

---------------------------------------------------
-- QUESTION 6: WARNING MESSAGE
---------------------------------------------------

PRINT 'Salary validation and exception handling completed successfully.';
GO

---------------------------------------------------
-- FINAL OUTPUT
---------------------------------------------------

SELECT * FROM Employees;
GO

SELECT * FROM AuditLog;
GO