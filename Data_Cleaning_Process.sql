-- 1. Handling Missing Values
UPDATE Sales_Raw
SET Customer_Name = 'Unknown'
WHERE Customer_Name IS NULL;

-- 2. Removing Duplicates
WITH CTE AS (
    SELECT *, ROW_NUMBER() OVER (
        PARTITION BY Transaction_ID, Order_Date 
        ORDER BY Transaction_ID) AS RowNum
    FROM Sales_Raw
)
DELETE FROM CTE WHERE RowNum > 1;

-- 3. Standardizing Formats
UPDATE Sales_Raw
SET City = UPPER(TRIM(City));
