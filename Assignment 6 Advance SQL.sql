
/*
#1
A Common Table Expression (CTE) is a temporary named result set defined within a query using the WITH clause, used only for that single statement. It improves SQL query readability by breaking complex logic into smaller, named parts, making queries easier to write, understand, and maintain.​
A CTE is written as:
WITH cte_name AS (subquery)
 SELECT ... FROM cte_name; 
 
 It improves clarity by avoiding deeply nested subqueries and allowing reuse of the same derived result multiple times in the main query.​
 
 #2
 Some views are updatable because they map directly to a single base table without complex operations, so the database can translate INSERT/UPDATE/DELETE on the view to the underlying table. Views become read-only when they contain joins, aggregate functions, DISTINCT, GROUP BY, or calculated columns, because changes cannot be safely or uniquely mapped back to base rows
 Example updatable view: 
		View selecting a subset of columns from one table is usually updatable.​
 
 CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2)
);

INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
(1, 'Laptop',      'Electronics', 60000.00),
(2, 'Mouse',       'Electronics',  800.00),
(3, 'Dining Table','Furniture',  15000.00);

Below view is updatable because it is based on a single table, has no aggregates, no GROUP BY, and includes a key.
CREATE VIEW vw_ElectronicProducts AS
SELECT ProductID, ProductName, Price
FROM Products
WHERE Category = 'Electronics';

UPDATE vw_ElectronicProducts
SET Price = 65000.00
WHERE ProductID = 1;

Example read-only view:
		a view that joins Products and Orders and groups by ProductID to show total sales per product is not updatable.
        
CREATE VIEW vw_CategoryPriceSummary AS
SELECT Category,
       AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;

UPDATE vw_CategoryPriceSummary
SET AveragePrice = 70000.00
WHERE Category = 'Electronics';

Error for the above statement. This view becomes read-only because it uses aggregation (AVG) and GROUP BY, so a row in the view does not correspond to exactly one row in the base table.

#3
Stored procedures are precompiled SQL programs stored in the database that can be executed by name with parameters. They offer several advantages over repeating raw SQL in application code.​
Better performance due to precompilation and cached execution plans.​

#4
Triggers are special stored programs that automatically run in response to events such as INSERT, UPDATE, or DELETE on a table. Their main purpose is to enforce business rules, maintain audit logs, or keep related tables in sync without requiring explicit calls from application code.​
Example essential use case:
 an AFTER DELETE trigger on Orders that writes deleted rows into an audit table to keep a history of removed orders.​
 
 CREATE TABLE Orders (
    OrderID     INT PRIMARY KEY,
    CustomerID  INT,
    OrderDate   DATE,
    Amount      DECIMAL(10,2)
);

CREATE TABLE OrderAudit (
    AuditID     INT IDENTITY(1,1) PRIMARY KEY,   -- or AUTO_INCREMENT
    OrderID     INT,
    CustomerID  INT,
    OrderDate   DATE,
    Amount      DECIMAL(10,2),
    ActionType  VARCHAR(20),
    ActionTime  DATETIME
);
AFTER DELETE trigger example
Trigger purpose: automatically log deleted orders into the OrderAudit table (essential for auditing and history).

CREATE TRIGGER trg_Orders_AfterDelete
ON Orders
AFTER DELETE
AS
BEGIN
    INSERT INTO OrderAudit (OrderID, CustomerID, OrderDate, Amount, ActionType, ActionTime)
    SELECT  d.OrderID,
            d.CustomerID,
            d.OrderDate,
            d.Amount,
            'DELETE',
            GETDATE()          -- use NOW() in MySQL, CURRENT_TIMESTAMP in standard SQL
    FROM deleted d;
END;

This trigger ensures every deleted order is stored with time and action type, without requiring any change in application code, showing an essential auditing use case.

#5
Data modelling and normalization ensure that a database is structured to avoid redundancy, maintain consistency, and support efficient querying. Normalization organizes data into related tables using keys and relationships so that each fact is stored in exactly one logical place.​
This reduces anomalies during INSERT, UPDATE, and DELETE operations and makes the design easier to extend when requirements change.​
A well-modelled, normalized schema also improves data integrity and often query performance by removing unnecessary duplication
*/

#6
CREATE DATABASE product_db;
use product_db;

CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2)
);

INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
(1, 'Keyboard', 'Electronics', 1200.00),
(2, 'Mouse', 'Electronics',   800.00),
(3, 'Chair','Furniture',   2500.00),
(4, 'Table','Furniture',   4000.00);

CREATE TABLE Sales(
 SaleID INT PRIMARY KEY,
 ProductID INT,
 Quantity INT,
 SaleDate DATE,
 FOREIGN KEY(ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Sales VALUES
(1,1,4,'2024-01-05'),
(2,2,10,'2024-01-06'),
(3,3,2,'2024-01-01'),
(4,4,1,'2024-01-11');

#6
WITH ProductRevenue AS (
    SELECT
        p.ProductID,
        p.ProductName,
        p.Price,
        s.Quantity,
        (p.Price * s.Quantity) AS Revenue
    FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
)
SELECT
    ProductID,
    ProductName,
    Revenue
FROM ProductRevenue
WHERE Revenue > 3000;

#7
CREATE VIEW vw_CategorySummary AS
SELECT
    Category,
    COUNT(*)   AS TotalProducts,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;

SELECT * FROM vw_CategorySummary;
#8
CREATE VIEW vw_ProductBasic AS
SELECT
    ProductID,
    ProductName,
    Price
FROM Products;

UPDATE vw_ProductBasic
SET Price = 1500.00
WHERE ProductID = 1;

#9
DELIMITER $$

CREATE PROCEDURE GetProductsByCategory (IN p_Category VARCHAR(50))
BEGIN
    SELECT
        ProductID,
        ProductName,
        Category,
        Price
    FROM Products
    WHERE Category = p_Category;
END $$

DELIMITER ;
CALL GetProductsByCategory('Electronics');

#10
CREATE TABLE ProductArchive (
    ArchiveID    INT AUTO_INCREMENT PRIMARY KEY,   -- optional
    ProductID    INT,
    ProductName  VARCHAR(100),
    Category     VARCHAR(50),
    Price        DECIMAL(10,2),
    DeletedAt    DATETIME
);

DELIMITER $$

CREATE TRIGGER trg_Products_AfterDelete
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO ProductArchive
        (ProductID, ProductName, Category, Price, DeletedAt)
    VALUES
        (OLD.ProductID, OLD.ProductName, OLD.Category, OLD.Price, NOW());
END $$

DELIMITER ;


 
 