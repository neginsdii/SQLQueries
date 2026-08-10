-- 1. Select all customers
SELECT *
FROM Customers;


-- 2. Select first and last names
SELECT FirstName, LastName
FROM Customers;


-- 3. Customers from Canada
SELECT *
FROM Customers
WHERE Country = 'Canada';


-- 4. Customers from Toronto
SELECT *
FROM Customers
WHERE City = 'Toronto';


-- 5. First name starts with S
SELECT *
FROM Customers
WHERE FirstName LIKE 'S%';


-- 6. Last name ends with n
SELECT *
FROM Customers
WHERE LastName LIKE '%n';


-- 7. Customers not from Canada
SELECT *
FROM Customers
WHERE Country <> 'Canada';


-- 8. Orders greater than 300
SELECT *
FROM Orders
WHERE Amount > 300;


-- 9. Orders between 200 and 500
SELECT *
FROM Orders
WHERE Amount BETWEEN 200 AND 500;


-- 10. Three most expensive orders
SELECT TOP 3 *
FROM Orders
ORDER BY Amount DESC;


-- 11. Total amount of all orders
SELECT SUM(Amount) AS TotalAmount
FROM Orders;


-- 12. Average order amount
SELECT AVG(Amount) AS Average_Amount
FROM Orders;


-- 13. Largest order amount
SELECT MAX(Amount) AS Max_Amount
FROM Orders;


-- 14. Smallest order amount
SELECT MIN(Amount) AS Min_Amount
FROM Orders;


-- 15. Count all orders
SELECT COUNT(*) AS Total_Orders
FROM Orders;


-- 16. Count different customers who placed orders
SELECT COUNT(DISTINCT CustomerID) AS CustomerCount
FROM Orders;


-- 17. Total spending for each customer ID
SELECT
    CustomerID,
    SUM(Amount) AS TotalSpent
FROM Orders
GROUP BY CustomerID;


-- 18. Customers whose total spending is greater than 500
SELECT
    CustomerID,
    SUM(Amount) AS TotalSpent
FROM Orders
GROUP BY CustomerID
HAVING SUM(Amount) > 500;


-- 19. Customer names with their orders
SELECT
    c.FirstName,
    c.LastName,
    o.OrderDate,
    o.Amount
FROM Orders AS o
JOIN Customers AS c
    ON c.CustomerID = o.CustomerID;


-- 20. Canadian customers with their orders
SELECT
    c.FirstName,
    c.LastName,
    o.OrderDate,
    o.Amount
FROM Orders AS o
JOIN Customers AS c
    ON c.CustomerID = o.CustomerID
WHERE c.Country = 'Canada';


-- 21. All customers, including customers with no orders
SELECT
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.Amount
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;


-- 22. Total spending for every customer
SELECT
    c.FirstName,
    c.LastName,
    SUM(o.Amount) AS TotalSpent
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.FirstName,
    c.LastName;