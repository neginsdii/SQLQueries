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

-- CASE

-- 71.Show OrderID, Amount, and OrderCategory
SELECT OrderID, Amount,
    CASE
        WHEN Amount > 500 THEN 'High'
        WHEN Amount BETWEEN 200 AND 500 THEN 'Medium'
        WHEN Amount < 200 THEN 'Low'
    END AS OrderCategory
FROM Orders;

-- 72.Show FirstName, Country, and CustomerType
SELECT FirstName, Country,
    CASE
        WHEN Country = 'Canada' THEN 'Domestic'
        ELSE 'International'
    END AS CustomerType
FROM Customers;

-- 73.Show OrderID, Amount, and Discount
SELECT OrderID, Amount,
    CASE
        WHEN Amount > 500 THEN 20
        WHEN Amount BETWEEN 300 AND 500 THEN 10
        ELSE 0
    END AS Discount
FROM Orders;

-- 74.Show OrderID, Amount, and PriceLevel
SELECT OrderID, Amount,
    CASE
        WHEN Amount >= 500 THEN 'Expensive'
        ELSE 'Affordable'
    END AS PriceLevel
FROM Orders;

-- 75.Count orders greater than 300 for each customer
SELECT CustomerID,
    COUNT(CASE WHEN Amount > 300 THEN 1 END) AS TotalOrders
FROM Orders
GROUP BY CustomerID;

-- 76.Count expensive orders and other orders for each customer
SELECT CustomerID,
    COUNT(CASE WHEN Amount >= 500 THEN 1 END) AS ExpensiveOrders,
    COUNT(CASE WHEN Amount < 500 THEN 1 END) AS OtherOrders
FROM Orders
GROUP BY CustomerID;

-- 77.Total amount spent only on orders greater than 300
SELECT CustomerID,
    SUM(CASE WHEN Amount > 300 THEN Amount END) AS HighValueTotal
FROM Orders
GROUP BY CustomerID;

-- 78.Total orders above 300 and orders 300 or less separately
SELECT CustomerID,
    SUM(CASE WHEN Amount > 300 THEN Amount END) AS HighValueTotal,
    SUM(CASE WHEN Amount <= 300 THEN Amount END) AS LowValueTotal
FROM Orders
GROUP BY CustomerID;

-- 79.Categorize each customer's total spending
SELECT CustomerID,
    SUM(Amount) AS TotalSpending,
    CASE
        WHEN SUM(Amount) > 700 THEN 'High'
        WHEN SUM(Amount) BETWEEN 400 AND 700 THEN 'Medium'
        ELSE 'Low'
    END AS SpendingLevel
FROM Orders
GROUP BY CustomerID;

-- 80.Categorize each customer's average order amount
SELECT CustomerID,
    AVG(Amount) AS AVGSpending,
    CASE
        WHEN AVG(Amount) > 400 THEN 'High'
        WHEN AVG(Amount) BETWEEN 250 AND 400 THEN 'Medium'
        ELSE 'Low'
    END AS AverageLevel
FROM Orders
GROUP BY CustomerID;

-- 81.Categorize customers by number of orders
SELECT CustomerID,
    CASE
        WHEN COUNT(OrderID) > 2 THEN 'Frequent'
        WHEN COUNT(OrderID) = 2 THEN 'Regular'
        WHEN COUNT(OrderID) = 1 THEN 'Occasional'
    END AS OrderActivity
FROM Orders
GROUP BY CustomerID;

-- 82.Show number of orders and ActivityLevel
SELECT CustomerID,
    COUNT(OrderID) AS NumOfOrders,
    CASE
        WHEN COUNT(OrderID) >= 3 THEN 'High'
        WHEN COUNT(OrderID) = 2 THEN 'Medium'
        ELSE 'Low'
    END AS ActivityLevel
FROM Orders
GROUP BY CustomerID;

-- 83.Count orders greater than 250 for each customer
SELECT CustomerID,
    COUNT(CASE WHEN Amount > 250 THEN 1 END) AS OrdersAbove250
FROM Orders
GROUP BY CustomerID;

-- 84.Total amount of orders 300 or greater for each customer
SELECT CustomerID,
    SUM(CASE WHEN Amount >= 300 THEN Amount END) AS TotalAbove300
FROM Orders
GROUP BY CustomerID;

-- 85.Count orders below 300 and total amount of orders 300 or greater
SELECT CustomerID,
    COUNT(CASE WHEN Amount < 300 THEN 1 END) AS SmallOrders,
    SUM(CASE WHEN Amount >= 300 THEN Amount END) AS LargeOrderTotal
FROM Orders
GROUP BY CustomerID;

-- 86.Show total spending and categorize customer level
SELECT CustomerID,
    SUM(Amount) AS TotalSpending,
    CASE
        WHEN SUM(Amount) > 700 THEN 'VIP'
        WHEN SUM(Amount) BETWEEN 400 AND 700 THEN 'Regular'
        WHEN SUM(Amount) < 400 THEN 'Basic'
    END AS CustomerLevel
FROM Orders
GROUP BY CustomerID;

-- 87.Count orders above 400, orders 400 or less, and show total spending
SELECT CustomerID,
    COUNT(CASE WHEN Amount > 400 THEN 1 END) AS HighOrders,
    COUNT(CASE WHEN Amount <= 400 THEN 1 END) AS NormalOrders,
    SUM(Amount) AS TotalSpending
FROM Orders
GROUP BY CustomerID;

-- 88.Count and total orders between 200 and 500
SELECT CustomerID,
    COUNT(CASE WHEN Amount BETWEEN 200 AND 500 THEN 1 END) AS MediumOrders,
    SUM(CASE WHEN Amount BETWEEN 200 AND 500 THEN Amount END) AS MediumOrderTotal
FROM Orders
GROUP BY CustomerID;

-- 89.Count Low, Medium, and High orders
SELECT CustomerID,
    COUNT(CASE WHEN Amount < 200 THEN 1 END) AS LowOrders,
    COUNT(CASE WHEN Amount BETWEEN 200 AND 500 THEN 1 END) AS MediumOrders,
    COUNT(CASE WHEN Amount > 500 THEN 1 END) AS HighOrders
FROM Orders
GROUP BY CustomerID;

-- 90.Show total spending, number of orders, and customer status
SELECT CustomerID,
    SUM(Amount) AS TotalSpending,
    COUNT(OrderID) AS NumberOfOrders,
    CASE
        WHEN SUM(Amount) > 700 AND COUNT(OrderID) >= 3 THEN 'VIP'
        ELSE 'Regular'
    END AS CustomerStatus
FROM Orders
GROUP BY CustomerID;

-- 91.Show average order amount, number of orders, and customer type
SELECT CustomerID,
    AVG(Amount) AS AverageAmount,
    COUNT(OrderID) AS NumberOfOrders,
    CASE
        WHEN AVG(Amount) > 300 AND COUNT(OrderID) > 1 THEN 'Premium'
        ELSE 'Standard'
    END AS CustomerType
FROM Orders
GROUP BY CustomerID;

-- 92.Show total spending and spending category; only customers spending over 500
SELECT CustomerID,
    SUM(Amount) AS TotalSpending,
    CASE
        WHEN SUM(Amount) > 700 THEN 'High'
        WHEN SUM(Amount) BETWEEN 400 AND 700 THEN 'Medium'
        ELSE 'Low'
    END AS SpendingCategory
FROM Orders
GROUP BY CustomerID
HAVING SUM(Amount) > 500;

-- 93.Show total spending, number of orders, and customer status; only customers with at least 2 orders
SELECT CustomerID, SUM(Amount) AS TotalSpending, COUNT(OrderID) AS NumberOfOrders,
CASE WHEN SUM(Amount) > 600 AND COUNT(OrderID) >= 2 THEN 'Active' ELSE 'Normal' END AS CustomerStatus
FROM Orders GROUP BY CustomerID HAVING COUNT(OrderID) >= 2;

-- 94.Show total spending, high orders, and customer category
SELECT CustomerID, SUM(Amount) AS TotalSpending,
COUNT(CASE WHEN Amount > 300 THEN 1 END) AS HighOrders,
CASE WHEN SUM(Amount) > 600 AND COUNT(CASE WHEN Amount > 300 THEN 1 END) >= 2 THEN 'Priority' ELSE 'Standard' END AS CustomerCategory
FROM Orders GROUP BY CustomerID;

-- 95.Show total spending, high-value total, and spending type; only customers spending at least 500
SELECT CustomerID, SUM(Amount) AS TotalSpending,
SUM(CASE WHEN Amount > 300 THEN Amount END) AS HighValueTotal,
CASE WHEN SUM(CASE WHEN Amount > 300 THEN Amount END) > 500 THEN 'High Value' ELSE 'Normal' END AS SpendingType
FROM Orders GROUP BY CustomerID HAVING SUM(Amount) >= 500;

-- 96.Show number of orders, high orders, and order profile; only customers with at least 2 orders
SELECT CustomerID, COUNT(OrderID) AS NumberOfOrders,
COUNT(CASE WHEN Amount > 300 THEN 1 END) AS HighOrders,
CASE WHEN COUNT(CASE WHEN Amount > 300 THEN 1 END) >= 2 THEN 'High Activity' ELSE 'Normal' END AS OrderProfile
FROM Orders GROUP BY CustomerID HAVING COUNT(OrderID) >= 2;

-- 97.Show total spending, number of orders, high orders, and customer rank
SELECT CustomerID, SUM(Amount) AS TotalSpending, COUNT(OrderID) AS NumberOfOrders,
COUNT(CASE WHEN Amount > 300 THEN 1 END) AS HighOrders,
CASE WHEN SUM(Amount) > 700 AND COUNT(OrderID) >= 2 THEN 'Gold'
WHEN SUM(Amount) >= 500 OR COUNT(CASE WHEN Amount > 300 THEN 1 END) >= 1 THEN 'Silver'
ELSE 'Bronze' END AS CustomerRank
FROM Orders GROUP BY CustomerID HAVING SUM(Amount) >= 300;

-- 98.Return all customer and supplier names with duplicates removed
SELECT FirstName FROM Customers
UNION
SELECT SupplierName FROM Suppliers;

-- 99.Return all customer and supplier names and keep duplicates
SELECT FirstName FROM Customers
UNION ALL
SELECT SupplierName FROM Suppliers;

-- 100.Return name and country for all customers and suppliers; keep duplicates
SELECT FirstName, Country FROM Customers
UNION ALL
SELECT SupplierName, Country FROM Suppliers;

-- 101.Return Canadian customers and suppliers; remove duplicate rows
SELECT FirstName AS Name, Country FROM Customers WHERE Country = 'Canada'
UNION
SELECT SupplierName, Country FROM Suppliers WHERE Country = 'Canada';

-- 102.Return all customers and suppliers with Name, Country, and Type
SELECT FirstName AS Name, Country, 'Customer' AS Type FROM Customers
UNION ALL
SELECT SupplierName, Country, 'Supplier' FROM Suppliers;

-- 103.Return Canadian customers and USA/Germany suppliers with Name, Country, and Type
SELECT FirstName AS Name, Country, 'Customer' AS Type FROM Customers WHERE Country = 'Canada'
UNION ALL
SELECT SupplierName, Country, 'Supplier' FROM Suppliers WHERE Country = 'USA' OR Country = 'Germany';

-- CTEs (Common Table Expressions)

-- 104.Create CustomerTotals CTE and return customers whose total spending is greater than 600
WITH CustomerTotals AS
(
    SELECT
        CustomerID,
        SUM(Amount) AS TotalSpending
    FROM Orders
    GROUP BY CustomerID
)
SELECT *
FROM CustomerTotals
WHERE TotalSpending > 600;

-- 105.Create CustomerOrders CTE and return customers with at least 2 orders
WITH CustomerOrders AS
(
    SELECT
        CustomerID,
        COUNT(OrderID) AS NumberOfOrders
    FROM Orders
    GROUP BY CustomerID
)
SELECT *
FROM CustomerOrders
WHERE NumberOfOrders >= 2;

-- 106.Create CustomerStats CTE and return customers whose total spending is greater than 600
-- and who have at least 2 orders
WITH CustomerStats AS
(
    SELECT
        CustomerID,
        SUM(Amount) AS TotalSpending,
        AVG(Amount) AS AverageAmount,
        COUNT(OrderID) AS NumberOfOrders
    FROM Orders
    GROUP BY CustomerID
)
SELECT *
FROM CustomerStats
WHERE TotalSpending > 600
  AND NumberOfOrders >= 2;

-- Question 107 is intentionally not included because it has not been answered yet.

-- 107. Customer totals CTE joined with Customers; return spending over 600
WITH CustomerTotal AS
(
    SELECT CustomerID, SUM(Amount) AS TotalSpending
    FROM Orders
    GROUP BY CustomerID
)
SELECT c.FirstName, c.Country, ct.TotalSpending
FROM Customers AS c
JOIN CustomerTotal AS ct ON c.CustomerID = ct.CustomerID
WHERE ct.TotalSpending > 600;

-- 108. Customer stats CTE joined with Customers; average amount over 300
WITH CustomerStats AS
(
    SELECT CustomerID, COUNT(OrderID) AS NumberOfOrders, AVG(Amount) AS AverageAmount
    FROM Orders
    GROUP BY CustomerID
)
SELECT c.FirstName, c.Country, ct.NumberOfOrders, ct.AverageAmount
FROM Customers AS c
JOIN CustomerStats AS ct ON c.CustomerID = ct.CustomerID
WHERE ct.AverageAmount > 300;

-- 109. Customer total spending and number of orders
WITH CustomerTotalSpending AS
(
    SELECT CustomerID, SUM(Amount) AS TotalSpending, COUNT(OrderID) AS NumberOfOrders
    FROM Orders
    GROUP BY CustomerID
)
SELECT c.FirstName, ct.TotalSpending, ct.NumberOfOrders
FROM Customers AS c
JOIN CustomerTotalSpending AS ct ON c.CustomerID = ct.CustomerID
WHERE ct.TotalSpending > 500 AND ct.NumberOfOrders >= 2;

-- 110. High-value orders CTE
WITH HighValueOrders AS
(
    SELECT CustomerID, OrderID, Amount
    FROM Orders
    WHERE Amount > 300
)
SELECT c.FirstName, hv.OrderID, hv.Amount
FROM Customers AS c
JOIN HighValueOrders AS hv ON c.CustomerID = hv.CustomerID;

-- 111. Canadian customers CTE joined to Orders
WITH CanadianCustomers AS
(
    SELECT CustomerID, FirstName
    FROM Customers
    WHERE Country = 'Canada'
)
SELECT cc.FirstName, o.OrderID, o.Amount
FROM CanadianCustomers AS cc
JOIN Orders AS o ON cc.CustomerID = o.CustomerID;

-- 112. Customer totals CTE with CASE classification
WITH CustomerTotals AS
(
    SELECT CustomerID, SUM(Amount) AS TotalSpending, COUNT(OrderID) AS NumberOfOrders
    FROM Orders
    GROUP BY CustomerID
)
SELECT c.FirstName, c.Country, ct.TotalSpending, ct.NumberOfOrders,
    CASE
        WHEN ct.TotalSpending > 700 AND ct.NumberOfOrders >= 3 THEN 'VIP'
        ELSE 'Regular'
    END AS CustomerLevel
FROM Customers AS c
JOIN CustomerTotals AS ct ON c.CustomerID = ct.CustomerID
WHERE ct.TotalSpending >= 500;


-- MULTIPLE CTEs

-- 113. Two independent CTEs: customer totals and order counts
WITH CustomerTotals AS
(
    SELECT CustomerID, SUM(Amount) AS TotalSpending
    FROM Orders
    GROUP BY CustomerID
),
CustomerOrderCounts AS
(
    SELECT CustomerID, COUNT(OrderID) AS NumberOfOrders
    FROM Orders
    GROUP BY CustomerID
)
SELECT ct.CustomerID, ct.TotalSpending, cc.NumberOfOrders
FROM CustomerTotals AS ct
JOIN CustomerOrderCounts AS cc
    ON ct.CustomerID = cc.CustomerID
WHERE ct.TotalSpending > 500;

-- 114. Second CTE uses the first CTE
WITH CustomerTotals AS
(
    SELECT CustomerID, SUM(Amount) AS TotalSpending
    FROM Orders
    GROUP BY CustomerID
),
HighSpenders AS
(
    SELECT CustomerID, TotalSpending
    FROM CustomerTotals
    WHERE TotalSpending > 600
)
SELECT *
FROM HighSpenders;

-- 115. Chained CTEs followed by a join to Customers
WITH CustomerStats AS
(
    SELECT
        CustomerID,
        SUM(Amount) AS TotalSpending,
        COUNT(OrderID) AS NumberOfOrders
    FROM Orders
    GROUP BY CustomerID
),
ActiveCustomers AS
(
    SELECT CustomerID, TotalSpending, NumberOfOrders
    FROM CustomerStats
    WHERE TotalSpending >= 500
      AND NumberOfOrders >= 2
)
SELECT
    c.FirstName,
    c.Country,
    ac.TotalSpending,
    ac.NumberOfOrders
FROM Customers AS c
JOIN ActiveCustomers AS ac
    ON c.CustomerID = ac.CustomerID;

-- 116. Two independent filtered CTEs
WITH CanadianCustomers AS
(
    SELECT CustomerID, FirstName
    FROM Customers
    WHERE Country = 'Canada'
),
HighValueOrders AS
(
    SELECT CustomerID, OrderID, Amount
    FROM Orders
    WHERE Amount > 300
)
SELECT cc.FirstName, hv.OrderID, hv.Amount
FROM CanadianCustomers AS cc
JOIN HighValueOrders AS hv
    ON cc.CustomerID = hv.CustomerID;

-- 117. Customer totals and averages in separate CTEs
WITH CustomerTotals AS
(
    SELECT CustomerID, SUM(Amount) AS TotalSpending
    FROM Orders
    GROUP BY CustomerID
),
CustomerAverages AS
(
    SELECT CustomerID, AVG(Amount) AS AverageAmount
    FROM Orders
    GROUP BY CustomerID
)
SELECT
    ct.CustomerID,
    ct.TotalSpending,
    ca.AverageAmount
FROM CustomerTotals AS ct
JOIN CustomerAverages AS ca
    ON ct.CustomerID = ca.CustomerID
WHERE ct.TotalSpending > 600
  AND ca.AverageAmount > 300;

-- 118. Three CTEs: totals, counts, and qualified customers
WITH CustomerTotals AS
(
    SELECT CustomerID, SUM(Amount) AS TotalSpending
    FROM Orders
    GROUP BY CustomerID
),
CustomerOrderCounts AS
(
    SELECT CustomerID, COUNT(OrderID) AS NumberOfOrders
    FROM Orders
    GROUP BY CustomerID
),
QualifiedCustomers AS
(
    SELECT
        ct.CustomerID,
        ct.TotalSpending,
        cc.NumberOfOrders
    FROM CustomerTotals AS ct
    JOIN CustomerOrderCounts AS cc
        ON ct.CustomerID = cc.CustomerID
    WHERE ct.TotalSpending >= 500
      AND cc.NumberOfOrders >= 2
)
SELECT
    c.FirstName,
    c.Country,
    q.TotalSpending,
    q.NumberOfOrders
FROM Customers AS c
JOIN QualifiedCustomers AS q
    ON c.CustomerID = q.CustomerID;


-- ============================================
-- RECURSIVE CTEs
-- Questions 119–135
-- ============================================

-- 119. Generate numbers 1 through 6
WITH Numbers AS
(
    SELECT 1 AS Number
    UNION ALL
    SELECT Number + 1
    FROM Numbers
    WHERE Number < 6
)
SELECT * FROM Numbers;

-- 120. Generate even numbers 2 through 10
WITH EvenNumbers AS
(
    SELECT 2 AS Number
    UNION ALL
    SELECT Number + 2
    FROM EvenNumbers
    WHERE Number < 10
)
SELECT * FROM EvenNumbers;

-- 121. Countdown from 5 to 1
WITH Countdown AS
(
    SELECT 5 AS Number
    UNION ALL
    SELECT Number - 1
    FROM Countdown
    WHERE Number > 1
)
SELECT * FROM Countdown;

-- 122. Multiples of five from 5 through 30
WITH MultiplesOfFive AS
(
    SELECT 5 AS Number
    UNION ALL
    SELECT Number + 5
    FROM MultiplesOfFive
    WHERE Number < 30
)
SELECT * FROM MultiplesOfFive;

-- 123. Odd numbers from 1 through 11
WITH OddNumbers AS
(
    SELECT 1 AS Number
    UNION ALL
    SELECT Number + 2
    FROM OddNumbers
    WHERE Number < 11
)
SELECT * FROM OddNumbers;

-- 124. Countdown by three
WITH CountdownByThree AS
(
    SELECT 15 AS Number
    UNION ALL
    SELECT Number - 3
    FROM CountdownByThree
    WHERE Number >= 6
)
SELECT * FROM CountdownByThree;

-- 125. Generate 10, 20, 30 ... 70
WITH Sequence AS
(
    SELECT 10 AS Number
    UNION ALL
    SELECT Number + 10
    FROM Sequence
    WHERE Number <= 60
)
SELECT * FROM Sequence;

-- 126. Generate 20, 16, 12, 8, 4
WITH DescendingNumbers AS
(
    SELECT 20 AS Number
    UNION ALL
    SELECT Number - 4
    FROM DescendingNumbers
    WHERE Number >= 8
)
SELECT * FROM DescendingNumbers;

-- 127. Generate 3, 6, 12, 24, 48
WITH Sequence AS
(
    SELECT 3 AS Number
    UNION ALL
    SELECT Number * 2
    FROM Sequence
    WHERE Number <= 24
)
SELECT * FROM Sequence;

-- 128. Generate 100, 50, 25, 12, 6, 3, 1
WITH Sequence AS
(
    SELECT 100 AS Number
    UNION ALL
    SELECT Number / 2
    FROM Sequence
    WHERE Number >= 3
)
SELECT * FROM Sequence;

-- 129. Sophia and everyone underneath Sophia
WITH EmployeeHierarchy AS
(
    SELECT EmployeeID, Name, ManagerID
    FROM Employees
    WHERE EmployeeID = 3

    UNION ALL

    SELECT e.EmployeeID, e.Name, e.ManagerID
    FROM Employees AS e
    JOIN EmployeeHierarchy AS eh
        ON e.ManagerID = eh.EmployeeID
)
SELECT * FROM EmployeeHierarchy;

-- 130. Liam and everyone underneath Liam
WITH EmployeeHierarchy AS
(
    SELECT EmployeeID, Name, ManagerID
    FROM Employees
    WHERE EmployeeID = 2

    UNION ALL

    SELECT e.EmployeeID, e.Name, e.ManagerID
    FROM Employees AS e
    JOIN EmployeeHierarchy AS eh
        ON e.ManagerID = eh.EmployeeID
)
SELECT * FROM EmployeeHierarchy;

-- 131. Noah and everyone underneath Noah
WITH EmployeeHierarchy AS
(
    SELECT EmployeeID, Name, ManagerID
    FROM Employees
    WHERE EmployeeID = 4

    UNION ALL

    SELECT e.EmployeeID, e.Name, e.ManagerID
    FROM Employees AS e
    JOIN EmployeeHierarchy AS eh
        ON e.ManagerID = eh.EmployeeID
)
SELECT * FROM EmployeeHierarchy;

-- 132. Emma and everyone underneath Emma
WITH EmployeeHierarchy AS
(
    SELECT EmployeeID, Name, ManagerID
    FROM Employees
    WHERE EmployeeID = 1

    UNION ALL

    SELECT e.EmployeeID, e.Name, e.ManagerID
    FROM Employees AS e
    JOIN EmployeeHierarchy AS eh
        ON e.ManagerID = eh.EmployeeID
)
SELECT * FROM EmployeeHierarchy;

-- 133. Start with Leo and move upward through his managers
WITH ManagementChain AS
(
    SELECT EmployeeID, Name, ManagerID
    FROM Employees
    WHERE EmployeeID = 8

    UNION ALL

    SELECT e.EmployeeID, e.Name, e.ManagerID
    FROM Employees AS e
    JOIN ManagementChain AS mc
        ON e.EmployeeID = mc.ManagerID
)
SELECT * FROM ManagementChain;

-- 134. Category hierarchy starting from Computers
WITH CategoryHierarchy AS
(
    SELECT CategoryID, CategoryName, ParentCategoryID
    FROM Categories
    WHERE CategoryID = 2

    UNION ALL

    SELECT c.CategoryID, c.CategoryName, c.ParentCategoryID
    FROM Categories AS c
    JOIN CategoryHierarchy AS ch
        ON c.ParentCategoryID = ch.CategoryID
)
SELECT * FROM CategoryHierarchy;

-- 135. Start with Projects and move upward through folders
WITH FolderPath AS
(
    SELECT FolderID, FolderName, ParentFolderID
    FROM Folders
    WHERE FolderID = 6

    UNION ALL

    SELECT f.FolderID, f.FolderName, f.ParentFolderID
    FROM Folders AS f
    JOIN FolderPath AS fh
        ON f.FolderID = fh.ParentFolderID
)
SELECT * FROM FolderPath;

-- ============================================
-- WINDOW FUNCTIONS: Questions 136-143
-- ============================================

-- 136
SELECT OrderID, CustomerID, Amount,
       SUM(Amount) OVER (PARTITION BY CustomerID) AS CustomerTotal
FROM Orders;

-- 137
SELECT OrderID, CustomerID, Amount,
       AVG(Amount) OVER (PARTITION BY CustomerID) AS CustomerAverage
FROM Orders;

-- 138
SELECT OrderID, CustomerID, Amount,
       COUNT(OrderID) OVER (PARTITION BY CustomerID) AS CustomerOrderCount
FROM Orders;

-- 139
SELECT OrderID, CustomerID, Amount,
       MAX(Amount) OVER (PARTITION BY CustomerID) AS CustomerMaxAmount
FROM Orders;

-- 140
SELECT OrderID, CustomerID, Amount,
       MIN(Amount) OVER (PARTITION BY CustomerID) AS CustomerMinAmount
FROM Orders;

-- 141
SELECT OrderID, CustomerID, Amount,
       SUM(Amount) OVER (PARTITION BY CustomerID) AS CustomerTotal,
       AVG(Amount) OVER (PARTITION BY CustomerID) AS CustomerAverage,
       COUNT(OrderID) OVER (PARTITION BY CustomerID) AS CustomerOrderCount
FROM Orders;

-- 142
SELECT OrderID, CustomerID, Amount,
       SUM(Amount) OVER (PARTITION BY CustomerID) AS CustomerTotal,
       MIN(Amount) OVER (PARTITION BY CustomerID) AS CustomerMinAmount,
       MAX(Amount) OVER (PARTITION BY CustomerID) AS CustomerMaxAmount
FROM Orders;

-- 143
SELECT OrderID, CustomerID, Amount,
       SUM(Amount) OVER (PARTITION BY CustomerID) AS CustomerTotal,
       AVG(Amount) OVER (PARTITION BY CustomerID) AS CustomerAverage,
       MIN(Amount) OVER (PARTITION BY CustomerID) AS CustomerMinAmount,
       MAX(Amount) OVER (PARTITION BY CustomerID) AS CustomerMaxAmount,
       COUNT(OrderID) OVER (PARTITION BY CustomerID) AS CustomerOrderCount
FROM Orders;

-- 144.
-- Number orders from highest Amount to lowest Amount.

SELECT
    OrderID,
    CustomerID,
    Amount,
    ROW_NUMBER() OVER (
        ORDER BY Amount DESC
    ) AS RowNum
FROM Orders;


-- 145.
-- Number orders from smallest Amount to largest Amount.

SELECT
    OrderID,
    CustomerID,
    Amount,
    ROW_NUMBER() OVER (
        ORDER BY Amount ASC
    ) AS RowNum
FROM Orders;


-- 146.
-- Number orders by OrderID from smallest to largest.

SELECT
    OrderID,
    CustomerID,
    Amount,
    ROW_NUMBER() OVER (
        ORDER BY OrderID ASC
    ) AS RowNum
FROM Orders;


-- 147.
-- Number by CustomerID from smallest to largest.
-- If CustomerID is the same,
-- order by Amount from highest to lowest.

SELECT
    OrderID,
    CustomerID,
    Amount,
    ROW_NUMBER() OVER (
        ORDER BY CustomerID ASC, Amount DESC
    ) AS RowNum
FROM Orders;


-- 148.
-- Number by Amount from highest to lowest.
-- If Amount is the same,
-- smaller OrderID comes first.

SELECT
    OrderID,
    CustomerID,
    Amount,
    ROW_NUMBER() OVER (
        ORDER BY Amount DESC, OrderID ASC
    ) AS RowNum
FROM Orders;