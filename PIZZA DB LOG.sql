USE PIZZADB_LOG
USE PIZZADB_LOG;

CREATE TABLE PizzaSales (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    OrderDate DATE,
    PizzaName VARCHAR(50),
    PizzaCategory VARCHAR(30),
    PizzaSize VARCHAR(10),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    TotalPrice DECIMAL(10,2),
    CustomerCity VARCHAR(50)
);

ALTER TABLE PizzaSales DROP COLUMN OrderID;

ALTER TABLE PizzaSales
ADD OrderID INT IDENTITY(1,1) PRIMARY KEY;



SELECT * FROM PizzaSales;

--Total Sales pizza
select sum(TotalPrice) as Total_Sale from PizzaSales;

--top 5 pizza by saling
select top 5 PizzaName,
sum(TotalPrice) as Revenue,
count(orderid) as total_pizza
from PizzaSales
group by PizzaName
order by Revenue desc;

--Total Quantity Sold
select sum(Quantity) as Totol_PizzaQuantity from PizzaSales;

--Sales % by Category
SELECT 
    PizzaCategory,
    SUM(Quantity * UnitPrice) AS CategorySales,
    ROUND(
        SUM(Quantity * UnitPrice) * 100.0 /
        (SELECT SUM(Quantity * UnitPrice) FROM PizzaSales), 2
    ) AS SalesPercentage
FROM PizzaSales
GROUP BY PizzaCategory;
--using CAST
SELECT 
    PizzaCategory, 
    SUM(TotalPrice) AS CategorySales,
    CONCAT(CAST(ROUND(SUM(TotalPrice) * 100.0 / SUM(SUM(TotalPrice)) OVER(), 2) AS DECIMAL(10,2)), '%') AS SalesPercentage
FROM PizzaSales
GROUP BY PizzaCategory;
	
	--Top 5 Best Sellers by Revenue, Quantity, Orders
	SELECT TOP 5
		PIZZANAME,
		SUM(TOTALPRICE) AS TOTALPRICE,
		SUM(QUANTITY) AS TOTALQUANTIY,
		COUNT(DISTINCT ORDERID) AS TOTALORDERS
	FROM PizzaSales
	GROUP BY PizzaName
	ORDER BY TOTALPRICE DESC;

--monthly revenue trend
select
	year(orderdate) as year,
	month(orderdate) as month,
	sum(totalprice) as monthlyrevenue
from PizzaSales
group by year(orderdate), month(orderdate)
order by year, month;

--Revenue by Pizza Size
select PizzaSize,
	sum(totalPrice) as revenue
from PizzaSales
group by PizzaSize;


