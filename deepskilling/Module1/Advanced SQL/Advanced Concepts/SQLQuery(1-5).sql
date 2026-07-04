CREATE DATABASE OnlineRetailStore;
GO

USE OnlineRetailStore;
GO
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Region VARCHAR(50)
);
GO
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);
GO
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO
CREATE TABLE StagingProducts (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);
GO
INSERT INTO Customers VALUES
(1,'Rahul','South'),
(2,'Priya','North'),
(3,'Kiran','East'),
(4,'Anjali','West');
GO
INSERT INTO Products VALUES
(101,'Laptop','Electronics',50000),
(102,'Mobile','Electronics',30000),
(103,'Tablet','Electronics',30000),
(104,'Chair','Furniture',5000),
(105,'Table','Furniture',7000),
(106,'Sofa','Furniture',20000);
GO
INSERT INTO Orders VALUES
(1,1,'2025-01-05'),
(2,2,'2025-02-10'),
(3,1,'2025-03-15'),
(4,3,'2025-04-20'),
(5,4,'2025-05-25');
GO
INSERT INTO OrderDetails VALUES
(1,1,101,2),
(2,1,104,4),
(3,2,102,1),
(4,3,103,3),
(5,4,105,2),
(6,5,106,1);
GO
INSERT INTO StagingProducts VALUES
(102,'Mobile','Electronics',32000),
(107,'Bed','Furniture',25000);
GO
SELECT *
FROM
(
    SELECT
        ProductName,
        Category,
        Price,
        ROW_NUMBER() OVER(PARTITION BY Category ORDER BY Price DESC) AS RowNum,
        RANK() OVER(PARTITION BY Category ORDER BY Price DESC) AS RankNum,
        DENSE_RANK() OVER(PARTITION BY Category ORDER BY Price DESC) AS DenseRankNum
    FROM Products
) AS RankedProducts
WHERE RowNum <= 3;
GO
SELECT
    c.Region,
    p.Category,
    SUM(od.Quantity) AS TotalQuantity
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Products p ON od.ProductID = p.ProductID
GROUP BY GROUPING SETS
(
    (c.Region,p.Category),
    (c.Region),
    (p.Category)
);
GO
SELECT
    c.Region,
    p.Category,
    SUM(od.Quantity) AS TotalQuantity
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY ROLLUP(c.Region,p.Category);
GO
SELECT
    c.Region,
    p.Category,
    SUM(od.Quantity) AS TotalQuantity
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY CUBE(c.Region,p.Category);
GO
WITH CalendarCTE AS
(
    SELECT CAST('2025-01-01' AS DATE) AS DateValue

    UNION ALL

    SELECT DATEADD(DAY,1,DateValue)
    FROM CalendarCTE
    WHERE DateValue < '2025-01-31'
)
SELECT * FROM CalendarCTE
OPTION (MAXRECURSION 31);
GO
MERGE Products AS Target
USING StagingProducts AS Source
ON Target.ProductID = Source.ProductID

WHEN MATCHED THEN
    UPDATE SET Target.Price = Source.Price

WHEN NOT MATCHED THEN
    INSERT(ProductID,ProductName,Category,Price)
    VALUES(Source.ProductID,Source.ProductName,Source.Category,Source.Price);
GO
SELECT *
FROM
(
    SELECT
        od.ProductID,
        MONTH(o.OrderDate) AS MonthNo,
        od.Quantity
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
) AS SourceTable
PIVOT
(
    SUM(Quantity)
    FOR MonthNo IN ([1],[2],[3],[4],[5])
) AS PivotTable;
GO
WITH CustomerOrderCounts AS
(
    SELECT
        CustomerID,
        COUNT(OrderID) AS OrderCount
    FROM Orders
    GROUP BY CustomerID
)
SELECT *
FROM CustomerOrderCounts
WHERE OrderCount > 1;
GO