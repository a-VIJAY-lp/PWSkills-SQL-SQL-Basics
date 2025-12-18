#0
CREATE DATABASE customer_db;
USE customer_db;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    ManagerID INT NULL
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    Amount INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Payments (
    PaymentID VARCHAR(10) PRIMARY KEY,
    CustomerID INT,
    PaymentDate DATETIME,
    Amount INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
INSERT INTO Customers (CustomerID, CustomerName, City) VALUES
(1, 'John Smith',   'New York'),
(2, 'Mary Johnson', 'Chicago'),
(3, 'Peter Adams',  'Los Angeles'),
(4, 'Robert White', 'Houston'),
(5, 'Nancy Miller', 'Miami');

INSERT INTO Employees (EmployeeID, EmployeeName, ManagerID) VALUES
(1, 'Alex Green',  NULL),
(2, 'Brian Lee',   1),
(3, 'Carol Ray',   1),
(4, 'Eva Smith',   2),
(5, 'David Kim',   2);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount) VALUES
(101, 1, '2024-10-01', 250),
(102, 2, '2024-10-05', 300),
(103, 1, '2024-10-07', 150),
(104, 3, '2024-10-10', 450),
(105, 5, '2024-10-12', 400);  -- customer 6  and changed to 5

INSERT INTO Payments (PaymentID, CustomerID, PaymentDate, Amount) VALUES
('P001', 1, '2024-10-02', 250),
('P002', 2, '2024-10-06', 300),
('P003', 3, '2024-10-11', 450),
('P004', 4, '2024-10-15', 200);

#1) 
SELECT DISTINCT c.* FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID; 
#2) 
SELECT c.*, o.* FROM Customers c 
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID; 
#3) 
SELECT o.*, c.* FROM Orders o 
LEFT JOIN Customers c ON o.CustomerID = c.CustomerID; 
#4) 
SELECT c.*, o.* FROM Customers c 
LEFT JOIN Orders o   ON c.CustomerID = o.CustomerID 
UNION 
SELECT c.*, o.* FROM Customers c 
RIGHT JOIN Orders o   ON c.CustomerID = o.CustomerID; 
#5) 
SELECT DISTINCT p_c.* FROM Payments p 
JOIN Customers p_c  ON p.CustomerID = p_c.CustomerID 
LEFT JOIN Orders o  ON p.CustomerID = o.CustomerID 
WHERE o.OrderID IS NULL; 
#6) 
SELECT DISTINCT p_c.* FROM Payments p 
JOIN Customers p_c   ON p.CustomerID = p_c.CustomerID 
LEFT JOIN Orders o  ON p.CustomerID = o.CustomerID 
WHERE o.OrderID IS NULL; 
#7) 
SELECT c.*, o.* FROM Customers c 
CROSS JOIN Orders o; 
#8) 
SELECT c.CustomerID,  c.CustomerName, c.City, o.OrderID, o.OrderDate,  
o.Amount AS OrderAmount, p.PaymentID, p.PaymentDate, 
p.Amount AS PaymentAmount FROM Customers c 
LEFT JOIN Orders o  ON c.CustomerID = o.CustomerID 
LEFT JOIN Payments p  ON c.CustomerID = p.CustomerID; 
#9) 
SELECT DISTINCT c.* FROM Customers c 
JOIN Orders o   ON c.CustomerID = o.CustomerID 
JOIN Payments p  ON c.CustomerID = p.CustomerID; 
 
