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
(3,'Bob','Johnson',3,5500.00,'2021-07-30');
GO

---------------------------------------------------
-- Exercise 1: Basic Cursor
---------------------------------------------------

DECLARE @EmployeeID INT,
        @FirstName VARCHAR(50),
        @LastName VARCHAR(50),
        @DepartmentID INT,
        @Salary DECIMAL(10,2),
        @JoinDate DATE;

DECLARE EmployeeCursor CURSOR
FOR
SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate
FROM Employees;

OPEN EmployeeCursor;

FETCH NEXT FROM EmployeeCursor
INTO @EmployeeID,@FirstName,@LastName,@DepartmentID,@Salary,@JoinDate;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'EmployeeID: ' + CAST(@EmployeeID AS VARCHAR)
        + ', Name: ' + @FirstName + ' ' + @LastName
        + ', DepartmentID: ' + CAST(@DepartmentID AS VARCHAR)
        + ', Salary: ' + CAST(@Salary AS VARCHAR)
        + ', JoinDate: ' + CAST(@JoinDate AS VARCHAR);

    FETCH NEXT FROM EmployeeCursor
    INTO @EmployeeID,@FirstName,@LastName,@DepartmentID,@Salary,@JoinDate;
END

CLOSE EmployeeCursor;
DEALLOCATE EmployeeCursor;
GO

---------------------------------------------------
-- STATIC CURSOR
---------------------------------------------------

DECLARE @EmployeeID1 INT,
        @FirstName1 VARCHAR(50),
        @LastName1 VARCHAR(50),
        @DepartmentID1 INT,
        @Salary1 DECIMAL(10,2),
        @JoinDate1 DATE;

DECLARE StaticCursor CURSOR STATIC
FOR
SELECT * FROM Employees;

OPEN StaticCursor;

FETCH NEXT FROM StaticCursor
INTO @EmployeeID1,@FirstName1,@LastName1,@DepartmentID1,@Salary1,@JoinDate1;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'STATIC CURSOR: ' + @FirstName1;

    FETCH NEXT FROM StaticCursor
    INTO @EmployeeID1,@FirstName1,@LastName1,@DepartmentID1,@Salary1,@JoinDate1;
END

CLOSE StaticCursor;
DEALLOCATE StaticCursor;
GO

---------------------------------------------------
-- DYNAMIC CURSOR
---------------------------------------------------

DECLARE @EmployeeID2 INT,
        @FirstName2 VARCHAR(50),
        @LastName2 VARCHAR(50),
        @DepartmentID2 INT,
        @Salary2 DECIMAL(10,2),
        @JoinDate2 DATE;

DECLARE DynamicCursor CURSOR DYNAMIC
FOR
SELECT * FROM Employees;

OPEN DynamicCursor;

FETCH NEXT FROM DynamicCursor
INTO @EmployeeID2,@FirstName2,@LastName2,@DepartmentID2,@Salary2,@JoinDate2;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'DYNAMIC CURSOR: ' + @FirstName2;

    FETCH NEXT FROM DynamicCursor
    INTO @EmployeeID2,@FirstName2,@LastName2,@DepartmentID2,@Salary2,@JoinDate2;
END

CLOSE DynamicCursor;
DEALLOCATE DynamicCursor;
GO

---------------------------------------------------
-- FORWARD_ONLY CURSOR
---------------------------------------------------

DECLARE @EmployeeID3 INT,
        @FirstName3 VARCHAR(50),
        @LastName3 VARCHAR(50),
        @DepartmentID3 INT,
        @Salary3 DECIMAL(10,2),
        @JoinDate3 DATE;

DECLARE ForwardCursor CURSOR FORWARD_ONLY
FOR
SELECT * FROM Employees;

OPEN ForwardCursor;

FETCH NEXT FROM ForwardCursor
INTO @EmployeeID3,@FirstName3,@LastName3,@DepartmentID3,@Salary3,@JoinDate3;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'FORWARD_ONLY CURSOR: ' + @FirstName3;

    FETCH NEXT FROM ForwardCursor
    INTO @EmployeeID3,@FirstName3,@LastName3,@DepartmentID3,@Salary3,@JoinDate3;
END

CLOSE ForwardCursor;
DEALLOCATE ForwardCursor;
GO

---------------------------------------------------
-- KEYSET CURSOR
---------------------------------------------------

DECLARE @EmployeeID4 INT,
        @FirstName4 VARCHAR(50),
        @LastName4 VARCHAR(50),
        @DepartmentID4 INT,
        @Salary4 DECIMAL(10,2),
        @JoinDate4 DATE;

DECLARE KeysetCursor CURSOR KEYSET
FOR
SELECT * FROM Employees;

OPEN KeysetCursor;

FETCH NEXT FROM KeysetCursor
INTO @EmployeeID4,@FirstName4,@LastName4,@DepartmentID4,@Salary4,@JoinDate4;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'KEYSET CURSOR: ' + @FirstName4;

    FETCH NEXT FROM KeysetCursor
    INTO @EmployeeID4,@FirstName4,@LastName4,@DepartmentID4,@Salary4,@JoinDate4;
END

CLOSE KeysetCursor;
DEALLOCATE KeysetCursor;
GO