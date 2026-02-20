-- DATA CLEANING AND VALIDATION --

SELECT * FROM amazon;

-- CHECK TOTAL RECORD COUNT --
SELECT COUNT(Order_ID) FROM amazon;

-- CHECK DUPLICATE VALUES --

SELECT order_id, COUNT(*)
FROM amazon
GROUP BY order_id
HAVING COUNT(*) > 1;


-- CHECK FOR NULL VALUES ---

SELECT * FROM amazon
WHERE
Order_ID IS NULL
OR
`Date` IS NULL
OR
Customer_id IS NULL
OR
Product_Category IS NULL
OR
Product_Name IS NULL
OR
Quantity IS NULL
OR
Unit_Price_INR IS NULL
OR
Total_Sales_INR IS NULL
OR
Payment_Method IS NULL 
OR
Delivery_Status IS NULL
OR
Review_rating IS NULL
OR
Review_Text IS NULL 
OR
State IS NULL
OR
COUNTRY IS NULL;

