-- ADVANCE SQL ANALYSIS --(BUSINESS INSIGHTS)

SELECT * FROM amazon;

-- 1.RANK PRODUCTS BY REVENUE
SELECT 
	product_name,
    SUM(Total_Sales_INR) as Total_revenue,
    RANK() OVER(ORDER BY SUM(Total_Sales_INR) DESC) as revenue_rank
FROM amazon
GROUP BY product_name
LIMIT 10; 


-- 2.RUNNING TOTAL REVENUE
SELECT
	`DATE`,
    Total_Sales_INR,
    SUM(Total_Sales_INR) OVER (ORDER BY `DATE`) AS running_revenue
FROM amazon;

-- 3.MONTH OVER MONTH REVENUE GROWTH
WITH monthly_sales AS (
    SELECT
        MONTH(`DATE`) AS month,
        SUM(Total_Sales_INR) AS revenue
    FROM amazon
    GROUP BY  MONTH(`DATE`)
)

SELECT
    month,
    revenue,
    revenue - LAG(revenue) OVER (ORDER BY month) AS mom_growth
FROM monthly_sales
ORDER BY month;

-- 4.TOP 2 PRODUCTS PER CATEGORY
WITH Total_rev AS(
SELECT 
	product_category,
	product_name,
    SUM(Total_Sales_INR) AS S
FROM amazon
GROUP BY 1,2),
Top_2_by_cat AS(
SELECT 
	*,
    RANK() OVER(PARTITION BY product_category ORDER BY S desc) AS Ranking
FROM Total_rev)
SELECT 
  * 
FROM Top_2_by_cat
WHERE Ranking <=2;

-- 5.OVERALL REVENUE BY EACH CUSTOMER
SELECT 
	customer_id,
    COUNT(order_id) AS Total_Orders,
    SUM(Total_Sales_INR) AS Total_Revenue
FROM amazon
GROUP BY 1
ORDER BY 3 DESC;

-- 6.REVENUE CONTRIBUTION % BY CATEGORY
SELECT
	product_category,
    SUM(Total_Sales_INR) AS Total_revenue,
    ROUND((SUM(Total_Sales_INR)/SUM(SUM(Total_Sales_INR)) OVER()*100),2) AS Contribution_percent
FROM amazon
GROUP BY 1;

-- 7.AVERAGE ORDER VALUE BY STATE
SELECT 
	STATE,
    ROUND(SUM(Total_Sales_INR) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM amazon
GROUP BY STATE
ORDER BY avg_order_value DESC ;

-- 8.CUSTOMER SEGMANTATION (HIGH/MEDIUM/LOW VALUE CUSTOMERS)
with total_sale AS(
SELECT 
	customer_id,
    SUM(Total_Sales_INR) AS Total_revenue
FROM amazon
GROUP BY 1)
SELECT 
	COUNT(*) AS total_customers,
CASE
	WHEN Total_revenue > 500000 THEN 'HIGH VALUE CUSTOMERS'
    WHEN Total_revenue BETWEEN 300000 AND 500000 THEN 'MEDIUM VALUE CUSTOMERS'
    ELSE 'LOW VALUE CUSTOMERS'
END AS Customer_segmentation
FROM total_sale
GROUP BY 2

-- 9.DELEIVERY STATUS IMPACT ON CUSTOMER RATING --
SELECT
	delivery_status,
	COUNT(Order_id) AS Total_orders,
    SUM(Total_Sales_INR) AS Total_value,
    ROUND(AVG(Review_rating),2) AS Avg_rating
FROM Amazon
GROUP BY 1
ORDER BY 4 DESC;

-- 10.HIGH REVENUE BUT LOW RATING PRODUCTS
SELECT
    Product_name,
    SUM(Total_Sales_INR) AS Total_value,
    ROUND(AVG(Review_rating),2) AS Avg_rating
FROM amazon
GROUP BY 1
HAVING AVG(Review_rating) < 3
ORDER BY 2 DESC;

-- 11.NEGATIVE REVIEW DETECTION(BASED ON COMMENTS)
SELECT 
    COUNT(*) AS negative_reviews_orders
FROM amazon
WHERE review_text LIKE '%WASTE%'
   OR review_text LIKE '%POOR%'
   OR review_text LIKE '%TERRIBLE%'
   OR review_text LIKE '%NEVER%'
   OR review_text LIKE '%BAD%'
   OR review_text LIKE '%DISS%'
   OR review_text LIKE '%DEFECT%'
   OR review_text LIKE '%NOT%';

-- 12.CUSTOMERS PREFERED PAYMENT METHOD
SELECT 
    payment_method,
    COUNT(order_id) AS Total_orders,
    SUM(Total_Sales_INR) AS Total_revenue
FROM amazon
GROUP BY 1
ORDER BY 2 DESC;

-- 13.WHICH DAY OF A WEEK CUSTOMER ORDER MORE AND TOTAL VALUE
SELECT
	DAYNAME(`date`) AS DAY_,
	COUNT(order_id) AS Total_orders,
    SUM(Total_Sales_INR) AS Total_sales
FROM amazon
GROUP BY 1
ORDER BY 2 DESC;

-- 14.TOP 10 PRODUCT ORDERED HIGH BY CUSTOMER
SELECT 
    product_name,
    SUM(quantity) AS total_quantity
FROM amazon
GROUP BY product_name
ORDER BY total_quantity DESC
LIMIT 10;

-- 15.TOP 5 STATE BY TOTAL REVENUE CONTRIBUTED
SELECT
	state,
	SUM(Total_Sales_INR) AS Total_revenue
FROM amazon
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
    


    