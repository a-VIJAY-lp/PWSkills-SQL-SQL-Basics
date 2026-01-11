CREATE DATABASE etl_data_quality;
USE etl_data_quality;
-- Master table
CREATE TABLE Customers_Master (
    CustomerID   VARCHAR(10) ,
    CustomerName VARCHAR(100),
    City         VARCHAR(50)
);

-- Transactions table
CREATE TABLE Sales_Transactions (
    Txn_ID        INT PRIMARY KEY,
    Customer_ID   VARCHAR(10),
    Customer_Name VARCHAR(100),
    Product_ID    VARCHAR(10),
    Quantity      INT,
    Txn_Amount    DECIMAL(10,2),
    Txn_Date      DATE,
    City          VARCHAR(50)
);

INSERT INTO Customers_Master (CustomerID, CustomerName, City) VALUES
('C101', 'Rahul Mehta',  'Mumbai'),
('C102', 'Anjali Rao',   'Bengaluru'),
('C103', 'Suresh Iyer',  'Chennai'),
('C104', 'Neha Singh',   'Delhi');

INSERT INTO Sales_Transactions
(Txn_ID, Customer_ID, Customer_Name, Product_ID, Quantity, Txn_Amount, Txn_Date, City)
VALUES
(201, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-01-12', 'Mumbai'),
(202, 'C102', 'Anjali Rao',  'P12', 1, 1500,  '2025-01-12', 'Bengaluru'),
(203, 'C101', 'Rahul Mehta', 'P11', 2, 4000,  '2025-01-12', 'Mumbai'),
(204, 'C103', 'Suresh Iyer', 'P13', 3, 6000,  '2025-02-12', 'Chennai'),
(205, 'C104', 'Neha Singh',  'P14', NULL, 2500,  '2025-02-12', 'Delhi') ,
(206, 'C105', 'N/A',         'P15', 1, NULL,   '2025-03-12', 'Pune'),
(207, 'C106', 'Amit Verma',  'P16', 1, 1800,  NULL,              'Pune'),
(208, 'C101', 'Rahul Mehta', 'P11', 2, 4000,  '2025-01-12', 'Mumbai');

-- 7

SELECT
    Customer_ID,
    Product_ID,
    Txn_Date,
    Txn_Amount,
    COUNT(*) AS duplicate_count
FROM Sales_Transactions
GROUP BY
    Customer_ID,
    Product_ID,
    Txn_Date,
    Txn_Amount
HAVING COUNT(*) > 1; 

-- 8 
SELECT DISTINCT
    s.Customer_ID
FROM Sales_Transactions s
LEFT JOIN Customers_Master c
    ON s.Customer_ID = c.CustomerID
WHERE c.CustomerID IS NULL;