/*OrderID                int
FirstName                varchar(255)
LastName                 nvarchar(255)
Gender                   nvarchar(255)
PhoneNumber              nvarchar(255)
Address                  nvarchar(255)
Age                      smallint
LunchOrder               nvarchar(255)
ItemsOrdered             int
[MealRating0-5]          float
MealCostEstimated        money */


/* exploring the data */
SELECT *
FROM [SQL Tutorial].[dbo].[Dirty Data]
ORDER BY OrderID;
/* find any duplicates */
SELECT OrderID,
	COUNT(OrderID) AS count
FROM [Dirty Data]
GROUP BY OrderID
HAVING COUNT(OrderID) > 1;

/* see if data is matching or different*/
SELECT *
FROM [Dirty Data]
WHERE OrderID = 568;

/* give a unique order number */
UPDATE [Dirty Data]
SET OrderID = 567
WHERE OrderID = 568 AND FirstName = 'Carl' AND LastName = 'Jones' AND PhoneNumber = '345-678-98-76';

/* check for duplicate names where someone has filled in the survey twice */
SELECT FirstName, 
	LastName, 
	COUNT(*) AS count
FROM [Dirty Data]
GROUP BY FirstName, LastName
HAVING COUNT(*) > 1;

/* checking if all infomation is the same on both surveys */
SELECT *
FROM [Dirty Data]
WHERE FirstName = 'Juan' AND LastName = 'Fernandez' OR FirstName = 'Kate' AND LastName = 'Mariana'
ORDER BY FirstName;

/* Delete one entry from both names */
DELETE FROM [Dirty Data]
WHERE OrderID IN (765, 188);

/*Cleaning the data */
SELECT OrderID, 
	CASE 
		WHEN FirstName = 'NAME' THEN 'Unknown'
		WHEN FirstName IS NULL THEN 'Unknown'
		ELSE UPPER(LEFT(FirstName, 1)) + LOWER(SUBSTRING(FirstName, 2,LEN(FirstName)))
		END AS FirstName,
	CASE
		WHEN LastName = 'NAME' THEN 'Unknown'
		WHEN LastName IS NULL THEN 'Unknown'
		ELSE UPPER(LEFT(LastName, 1)) + LOWER(SUBSTRING(LastName, 2, LEN(LastName)))
		END AS LastName,
	CASE
		WHEN Gender LIKE '%f%' THEN 'Female'
		WHEN Gender LIKE '%m%' THEN 'Male'
		ELSE 'Unknown'
		END AS Gender,
	CASE
		WHEN PhoneNumber in ('n/a', '1111111111') THEN 'Unknown'
		WHEN PhoneNumber IS NULL THEN 'Unknown'
		ELSE replace(replace(replace(replace(phonenumber, '-', ''), '(', ''), ')', ''), ' ', '')
		END AS PhoneNumber,
	CASE 
		WHEN Address IS NULL THEN 'Unknown' 
		ELSE Address
		END AS Address,
	CASE
		WHEN Age > 125 THEN 'Unknown'
		WHEN Age IS NULL THEN 'Unknown'
		ELSE CAST(Age AS NVARCHAR)
		END AS Age,
	CASE 
		WHEN LunchOrder LIKE '%salad%'
		THEN 1
		ELSE 0
		END AS Salad,
	CASE
		WHEN LunchOrder LIKE '%soda%'
		THEN 1
		ELSE 0
		END AS Soda,
	CASE	
		WHEN LunchOrder LIKE '%pizza%'
		THEN 1
		ELSE 0
		END AS Pizza,
	CASE 
		WHEN LunchOrder like '%pasta%'
		THEN 1
		WHEN LunchOrder LIKE '%pas%ta%'
		THEN 1
		ELSE 0
		END AS Pasta,
	CASE 
		WHEN LunchOrder LIKE '%des%ert%'
		THEN 1
		WHEN LunchOrder LIKE '%dess%'
		THEN 1
		ELSE 0
		END AS Dessert,
	CASE 
		WHEN LunchOrder LIKE '%water%'
		THEN 1
		ELSE 0
		END AS Water,
	LunchOrder,
	ItemsOrdered, 
	CASE
		WHEN [MealRating0-5] IS NULL THEN 'Unknown'
		WHEN [MealRating0-5] > 5 THEN CAST(5 AS NVARCHAR)
		ELSE CAST([MealRating0-5] AS NVARCHAR)
		END AS Meal_Rating,
	CASE 
		WHEN MealCostEstimated IS NULL THEN CAST('Unknown' AS NVARCHAR)
		WHEN MealCostEstimated = 1000.00 AND ItemsOrdered = 4 THEN CAST('Unknown' AS NVARCHAR)
		ELSE CAST(MealCostEstimated AS NVARCHAR)
		END AS Meal_Cost_Estimated
FROM [Dirty Data]
ORDER BY OrderID ASC;