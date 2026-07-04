-- Clean old tables
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;
GO

USE OnlineRetailStore;
GO

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Region VARCHAR(50)
);
GO

-- Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);
GO

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Insert Customers
INSERT INTO Customers VALUES
(1,'Alice','North'),
(2,'Bob','South'),
(3,'Charlie','East'),
(4,'David','West');
GO

-- Insert Products
INSERT INTO Products VALUES
(1,'Laptop','Electronics',1200.00),
(2,'Smartphone','Electronics',800.00),
(3,'Tablet','Electronics',600.00),
(4,'Headphones','Accessories',150.00);
GO

-- Insert Orders
INSERT INTO Orders VALUES
(1,1,'2023-01-15'),
(2,2,'2023-02-20'),
(3,3,'2023-03-25'),
(4,4,'2023-04-30');
GO

-- Insert OrderDetails
INSERT INTO OrderDetails VALUES
(1,1,1,1),
(2,2,2,2),
(3,3,3,1),
(4,4,4,3);
GO

---------------------------------------------------
-- Exercise 1: Non-Clustered Index
---------------------------------------------------

SELECT * 
FROM Products
WHERE ProductName = 'Laptop';
GO

CREATE NONCLUSTERED INDEX IX_ProductName
ON Products(ProductName);
GO

SELECT * 
FROM Products
WHERE ProductName = 'Laptop';
GO

EXEC sp_helpindex 'Products';
GO

---------------------------------------------------
-- Exercise 2: Clustered Index
---------------------------------------------------
-- PRIMARY KEY(OrderID) already creates a clustered index

EXEC sp_helpindex 'Orders';
GO

SELECT * 
FROM Orders
WHERE OrderDate = '2023-01-15';
GO

---------------------------------------------------
-- Exercise 3: Composite Index
---------------------------------------------------

CREATE NONCLUSTERED INDEX IX_Customer_OrderDate
ON Orders(CustomerID, OrderDate);
GO

SELECT *
FROM Orders
WHERE CustomerID = 1
AND OrderDate = '2023-01-15';
GO

---------------------------------------------------
-- View all indexes on Orders
---------------------------------------------------

SELECT 
    name AS IndexName,
    type_desc AS IndexType
FROM sys.indexes
WHERE object_id = OBJECT_ID('Orders');
GO