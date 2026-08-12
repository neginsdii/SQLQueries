-- SQL PRACTICE — ANSWERED QUERIES
-- =================================

-- BASIC SELECT / FILTERING
-- ------------------------

-- 1.Select all customers
SELECT *
FROM Customers;


-- 2.Select first and last names
SELECT FirstName, LastName
FROM Customers;


-- 3.Customers from Canada
SELECT *
FROM Customers
WHERE Country = 'Canada';


-- 4.Customers from Toronto
SELECT *
FROM Customers
WHERE City = 'Toronto';


-- 5.First name starts with S
SELECT *
FROM Customers
WHERE FirstName LIKE 'S%';


-- 6.Last name ends with n
SELECT *
FROM Customers
WHERE LastName LIKE '%n';


-- 7.Customers not from Canada
SELECT *
FROM Customers
WHERE Country <> 'Canada';


-- 8.Orders greater than 300
SELECT *
FROM Orders
WHERE Amount > 300;


-- 9.Orders between 200 and 500
SELECT *
FROM Orders
WHERE Amount BETWEEN 200 AND 500;


-- 10.Three most expensive orders
SELECT TOP 3 *
FROM Orders
ORDER BY Amount DESC;


-- AGGREGATE FUNCTIONS
-- -------------------

-- 11.Total amount of all orders
SELECT SUM(Amount) AS TotalAmount
FROM Orders;


-- 12.Average order amount
SELECT AVG(Amount) AS Average_Amount
FROM Orders;


-- 13.Largest order
SELECT MAX(Amount) AS Max_Amount
FROM Orders;


-- 14.Smallest order
SELECT MIN(Amount) AS Min_Amount
FROM Orders;


-- 15.Count all orders
SELECT COUNT(*) AS Total_Orders
FROM Orders;


-- 16.Count distinct customers who placed orders
SELECT COUNT(DISTINCT CustomerID) AS CustomerCount
FROM Orders;


-- GROUP BY / HAVING
-- -----------------

-- 17.Total spending for each customer
SELECT CustomerID, SUM(Amount) AS TotalSpent
FROM Orders
GROUP BY CustomerID;


-- 18.Customers whose total spending is over 500
SELECT CustomerID, SUM(Amount) AS TotalSpent
FROM Orders
GROUP BY CustomerID
HAVING SUM(Amount) > 500;


-- JOINS
-- -----

-- 19.Customer names with their orders
SELECT c.FirstName, c.LastName, o.OrderDate, o.Amount
FROM Orders AS o
JOIN Customers AS c
    ON c.CustomerID = o.CustomerID;


-- 20.Canadian customers with their orders
SELECT c.FirstName, c.LastName, o.OrderDate, o.Amount
FROM Orders AS o
JOIN Customers AS c
    ON c.CustomerID = o.CustomerID
WHERE c.Country = 'Canada';


-- 21.All customers including customers with no orders
SELECT c.FirstName, c.LastName, o.OrderID, o.Amount
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;


-- 22.Total spending for every customer
SELECT c.FirstName, c.LastName, SUM(o.Amount) AS TotalSpent
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;


-- 24.Customers who placed more than one order
SELECT c.FirstName, c.LastName
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
HAVING COUNT(o.CustomerID) > 1;


-- 25.Customers whose total spending is greater than 600
SELECT c.FirstName, c.LastName, SUM(o.Amount) AS Total_Amount
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
HAVING SUM(o.Amount) > 600;


-- 26.Customer who spent the most money in total
SELECT TOP 1
    c.FirstName,
    c.LastName,
    SUM(o.Amount) AS TotalSpent
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
ORDER BY TotalSpent DESC;


-- 27.Average order amount for each customer
SELECT c.FirstName, c.LastName, AVG(o.Amount) AS AverageAmount
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;


-- 28.Total amount spent by customers from each country
SELECT c.Country, SUM(o.Amount) AS TotalSpent
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.Country;


-- 29.Customers who have never placed an order
SELECT c.FirstName, c.LastName
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;


-- SELF JOIN
-- ---------

-- 30.Each employee and their manager
SELECT e.Name AS EmployeeName, m.Name AS ManagerName
FROM Employees AS e
JOIN Employees AS m
    ON e.ManagerID = m.EmployeeID;


-- 31.Each employee and manager, including employees without a manager
SELECT e.Name AS EmployeeName, m.Name AS ManagerName
FROM Employees AS e
LEFT JOIN Employees AS m
    ON e.ManagerID = m.EmployeeID;


-- JOIN + AGGREGATION
-- ------------------

-- 32.Number of orders for each customer, including zero orders
SELECT c.FirstName, COUNT(o.OrderID) AS NumberOfOrders
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName;


-- 33.Number of orders by country, including countries with zero orders
SELECT c.Country, COUNT(o.OrderID) AS NumberOfOrders
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.Country;


-- 34.Customers whose total spending is at least 500
SELECT c.FirstName, SUM(o.Amount) AS TotalSpent
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName
HAVING SUM(o.Amount) >= 500;


-- 35.Largest order amount for each customer
SELECT c.FirstName, MAX(o.Amount) AS LargestOrder
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName;


-- 36.Customers whose average order amount is greater than 300
SELECT c.FirstName, AVG(o.Amount) AS Avg_Amount
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName
HAVING AVG(o.Amount) > 300;


-- 37.Number of orders for each customer including zero
SELECT c.FirstName, COUNT(o.OrderID) AS NumberOfOrders
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName;


-- 38.Canadian customers with orders greater than 300
SELECT c.FirstName, o.Amount
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.Amount > 300
  AND c.Country = 'Canada';


-- 39.Countries with at least 2 orders and total spending greater than 1000
SELECT c.Country, SUM(o.Amount) AS Total_Spent
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.Country
HAVING COUNT(o.OrderID) >= 2
   AND SUM(o.Amount) > 1000;


-- SUBQUERIES
-- ----------

-- 40.Orders greater than the average order amount
SELECT *
FROM Orders
WHERE Amount > (
    SELECT AVG(Amount)
    FROM Orders
);


-- 41.Customers who have placed at least one order
SELECT FirstName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
);


-- 42.Customers who have never placed an order using a subquery
SELECT FirstName
FROM Customers
WHERE CustomerID NOT IN (
    SELECT CustomerID
    FROM Orders
);


-- 43.Orders greater than the largest order of customer 4
SELECT *
FROM Orders
WHERE Amount > (
    SELECT MAX(Amount)
    FROM Orders
    WHERE CustomerID = 4
);


-- 44.Customers who placed an order greater than 400
SELECT FirstName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE Amount > 400
);


-- 45.Customers with an order amount between 200 and 300
SELECT FirstName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE Amount BETWEEN 200 AND 300
);


-- 46.Orders greater than customer 1's average order
SELECT *
FROM Orders
WHERE Amount > (
    SELECT AVG(Amount)
    FROM Orders
    WHERE CustomerID = 1
);


-- 47.Customer who placed an order equal to the largest order
SELECT FirstName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE Amount = (
        SELECT MAX(Amount)
        FROM Orders
    )
);


-- 48.Customers who placed an order greater than the average of all orders
SELECT DISTINCT c.FirstName
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.Amount > (
    SELECT AVG(Amount)
    FROM Orders
);


-- 49.Orders less than the largest order
SELECT *
FROM Orders
WHERE Amount < (
    SELECT MAX(Amount)
    FROM Orders
);


-- 50.Customers whose total spending is greater than average order amount
SELECT c.FirstName
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName
HAVING SUM(o.Amount) > (
    SELECT AVG(Amount)
    FROM Orders
);


-- 51.Customer(s) who spent the most money in total
SELECT c.FirstName, SUM(o.Amount) AS TotalSpent
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName
HAVING SUM(o.Amount) = (
    SELECT MAX(TotalSpent)
    FROM (
        SELECT CustomerID, SUM(Amount) AS TotalSpent
        FROM Orders
        GROUP BY CustomerID
    ) AS CustomerTotals
);


-- 52.Customers whose total spending is greater than average customer total
SELECT c.FirstName, SUM(o.Amount) AS Total_Spent
FROM Customers AS c
JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName
HAVING SUM(o.Amount) > (
    SELECT AVG(CustomerTotalSpent)
    FROM (
        SELECT CustomerID, SUM(Amount) AS CustomerTotalSpent
        FROM Orders
        GROUP BY CustomerID
    ) AS CustomerTotals
);

-- 53.Customers whose total spending is less than the highest customer total spending
SELECT c.FirstName, SUM(o.Amount) AS TotalSpent
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName
HAVING SUM(o.Amount) < (
    SELECT MAX(CustomerTotal)
    FROM (
        SELECT SUM(oo.Amount) AS CustomerTotal
        FROM Orders AS oo
        GROUP BY oo.CustomerID
    ) AS CustomerTotals
);

-- 54.Customers with the second-highest total spending
SELECT c.FirstName, SUM(o.Amount) AS TotalSpent
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName
HAVING SUM(o.Amount) = (
    SELECT TOP 1 TotalAmount
    FROM (
        SELECT CustomerID, SUM(Amount) AS TotalAmount
        FROM Orders
        GROUP BY CustomerID
    ) AS CustomerTotals
    WHERE TotalAmount < (
        SELECT MAX(TotalAmount)
        FROM (
            SELECT CustomerID, SUM(Amount) AS TotalAmount
            FROM Orders
            GROUP BY CustomerID
        ) AS AllTotals
    )
    ORDER BY TotalAmount DESC
);

-- 55.Customers above average total spending but below highest total spending
SELECT c.FirstName, SUM(o.Amount) AS TotalSpent
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName
HAVING SUM(o.Amount) > (
    SELECT AVG(CustomerTotal)
    FROM (
        SELECT SUM(Amount) AS CustomerTotal
        FROM Orders
        GROUP BY CustomerID
    ) AS CustomerTotals
)
AND SUM(o.Amount) < (
    SELECT MAX(CustomerTotal)
    FROM (
        SELECT SUM(Amount) AS CustomerTotal
        FROM Orders
        GROUP BY CustomerID
    ) AS CustomerTotals
);

-- 56.Customers who spent more in total than customer 2
SELECT c.FirstName, SUM(o.Amount) AS TotalSpending
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName
HAVING SUM(o.Amount) > (
    SELECT SUM(Amount)
    FROM Orders
    WHERE CustomerID = 2
);

-- 57.Customers with more orders than customer 2
SELECT c.FirstName, COUNT(o.OrderID) AS NumberOfOrders
FROM Customers AS c
JOIN Orders AS o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName
HAVING COUNT(o.OrderID) > (
    SELECT COUNT(oo.OrderID)
    FROM Orders AS oo
    WHERE oo.CustomerID = 2
);

-- 58.Customers who have at least one order using EXISTS
SELECT c.FirstName
FROM Customers AS c
WHERE EXISTS (
    SELECT 1 FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
);

-- 59.Customers who never placed an order using NOT EXISTS
SELECT c.FirstName
FROM Customers AS c
WHERE NOT EXISTS (
    SELECT 1 FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
);

-- 60.Customers with at least one order greater than 400
SELECT c.FirstName
FROM Customers AS c
WHERE EXISTS (
    SELECT 1 FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
      AND o.Amount > 400
);

-- 61.Customers who do not have any order greater than 400
SELECT c.FirstName
FROM Customers AS c
WHERE NOT EXISTS (
    SELECT 1 FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
      AND o.Amount > 400
);

-- 62.Customers with at least one order between 200 and 500
SELECT c.FirstName
FROM Customers AS c
WHERE EXISTS (
    SELECT 1 FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
      AND o.Amount BETWEEN 200 AND 500
);

-- 63.Customers with an order greater than the average of all orders
SELECT c.FirstName
FROM Customers AS c
WHERE EXISTS (
    SELECT 1 FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
      AND o.Amount > (
          SELECT AVG(oo.Amount) FROM Orders AS oo
      )
);

-- 64.Customers with no orders OR at least one order greater than 600
SELECT c.FirstName
FROM Customers AS c
WHERE EXISTS (
    SELECT 1 FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
      AND o.Amount > 600
)
OR NOT EXISTS (
    SELECT 1 FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
);

-- 65.Customers with at least one order over 200 and no order over 500
SELECT c.FirstName
FROM Customers AS c
WHERE EXISTS (
    SELECT 1 FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
      AND o.Amount > 200
)
AND NOT EXISTS (
    SELECT 1 FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
      AND o.Amount > 500
);

-- 66.Customers with at least one order below 300 and one above 400
SELECT c.FirstName
FROM Customers AS c
WHERE EXISTS (
    SELECT 1 FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
      AND o.Amount < 300
)
AND EXISTS (
    SELECT 1 FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
      AND o.Amount > 400
);

-- 67.Customers with at least one order but no orders below 200
SELECT c.FirstName
FROM Customers AS c
WHERE EXISTS (
    SELECT 1 FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
)
AND NOT EXISTS (
    SELECT 1 FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
      AND o.Amount < 200
);

-- 68.Customers with at least two orders
SELECT c.FirstName
FROM Customers AS c
WHERE EXISTS (
    SELECT 1
    FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
    GROUP BY o.CustomerID
    HAVING COUNT(o.OrderID) >= 2
);

-- 69.Customers with exactly one order
SELECT c.FirstName
FROM Customers AS c
WHERE EXISTS (
    SELECT 1
    FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
    GROUP BY o.CustomerID
    HAVING COUNT(o.OrderID) = 1
);

-- 70.Customers with more than one order and largest order greater than 400
SELECT c.FirstName
FROM Customers AS c
WHERE EXISTS (
    SELECT 1
    FROM Orders AS o
    WHERE c.CustomerID = o.CustomerID
    GROUP BY o.CustomerID
    HAVING COUNT(o.OrderID) > 1
       AND MAX(o.Amount) > 400
);