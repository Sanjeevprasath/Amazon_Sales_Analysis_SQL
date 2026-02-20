-- EXPLORATORY DATA ANALYSIS ---

SELECT * FROM amazon;
-- 1.TOTAL REVENUE 
SELECT 
	ROUND(SUM(total_sales_INR)) as Total_revenue,
    Delivery_status 
    FROM amazon 
    WHERE Delivery_Status = 'Delivered';
    
-- 2.REVENUE BY CATEGORY
SELECT 
	ROUND(SUM(total_sales_INR)) as Total_revenue,
    Product_Category 
    FROM amazon 
    GROUP BY Product_Category 
    ORDER BY Total_revenue DESC;
    
-- 3.TOP 5 CUSTOMERS BY SPENDING
SELECT 
	ROUND(SUM(total_sales_INR)) as Total_Spending,
    Customer_ID 
    FROM amazon
    GROUP BY Customer_ID 
    ORDER BY Total_Spending DESC
    LIMIT 5;

-- 4.AVG SALES PER ORDER 
SELECT 
   ROUND(AVG(total_sales_INR),2) as avg_sales_per_order
   FROM amazon;
   
-- 5.NUMBER OF UNIQUE CUSTOMERS
SELECT
	COUNT(DISTINCT Customer_id) as total_customers
    FROM amazon;
    