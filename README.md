🛒 Amazon Sales Analysis – Advanced SQL Business Case Study



📌 Project Overview

Project Title: Amazon Sales Analysis – SQL Business Intelligence Project
Database: MySQL
Dataset: Amazon Sales Transaction Data
Level: Intermediate to Advanced

This project simulates a real-world e-commerce business case where sales transaction data is analyzed using SQL to extract actionable business insights.

The project covers:

Database setup

Data cleaning & validation

Exploratory Data Analysis (EDA)

Advanced SQL analysis

Business insights generation

The objective is to demonstrate strong SQL proficiency required for Data Analyst roles.

🏗 Database Setup

1️⃣ Create Database
```SQL
CREATE DATABASE amazon_sales_db;
USE amazon_sales_db;
```

2️⃣ Create Table
```SQL
CREATE TABLE amazon_sales (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id VARCHAR(20),
    product_id VARCHAR(20),
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2),
    quantity INT,
    discount_percent DECIMAL(5,2),
    total_amount DECIMAL(12,2),
    city VARCHAR(50),
    payment_mode VARCHAR(20),
    order_status VARCHAR(20),
    delivery_days INT
);
```

🧹 Data Cleaning & Validation

The dataset was validated for consistency and accuracy before analysis.

✔ Steps Performed

Verified total records

Checked duplicate order IDs

Identified NULL values

Standardized text fields

Ensured correct data types

1️⃣ Duplicate Check
```SQL
SELECT
    order_id,
    COUNT(*)
FROM amazon
GROUP BY order_id
HAVING COUNT(*) > 1;
```

2️⃣ NULL Value Check
```SQL
SELECT *
FROM amazon
WHERE order_date IS NULL
   OR customer_id IS NULL
   OR total_amount IS NULL;
```

📊 Exploratory Data Analysis (EDA)

1️⃣ Total Revenue (Delivered Orders Only)
```SQL
SELECT
     ROUND(SUM(total_sales_INR)) AS Total_revenue
FROM amazon
WHERE Delivery_Status = 'Delivered';
```

2️⃣ Revenue by Category
```SQL
SELECT 
    Product_Category,
    ROUND(SUM(total_sales_INR)) AS Total_revenue
FROM amazon
GROUP BY Product_Category
ORDER BY Total_revenue DESC;
```

3️⃣ Top 5 Customers by Spending
```SQL
SELECT 
    Customer_ID,
    ROUND(SUM(total_sales_INR)) AS Total_Spending
FROM amazon
GROUP BY Customer_ID
ORDER BY Total_Spending DESC
LIMIT 5;
```

4️⃣ Average Sales Per Order
```SQL
SELECT 
    ROUND(AVG(Total_Sales_INR),2) AS avg_sales_per_order
FROM amazon;
```

5️⃣ Unique Customers Count
```SQL
SELECT 
    COUNT(DISTINCT Customer_ID) AS total_customers
FROM amazon;
```

🧠 Advanced SQL Analysis

1️⃣ Rank Products by Revenue
```SQL
SELECT
    product_name,
    SUM(Total_Sales_INR) AS total_revenue,
    RANK() OVER (ORDER BY SUM(Total_Sales_INR) DESC) AS revenue_rank
FROM amazon
GROUP BY product_name;
```

2️⃣ Running Total Revenue (Time-Based)
```SQL
SELECT
    `DATE`,
    SUM(Total_Sales_INR) OVER (ORDER BY `DATE`) AS running_revenue
FROM amazon;
```

3️⃣ Month-over-Month Revenue Growth
```SQL
WITH monthly_sales AS (
    SELECT
        MONTH(`DATE`) AS month,
        SUM(Total_Sales_INR) AS revenue
    FROM amazon
    GROUP BY MONTH(`DATE`)
)
SELECT
    month,
    revenue,
    revenue - LAG(revenue) OVER (ORDER BY month) AS mom_growth
FROM monthly_sales
ORDER BY month;
```

4️⃣ Top Products per Category
```SQL
WITH Total_rev AS (
    SELECT 
        product_category,
        product_name,
        SUM(Total_Sales_INR) AS S
    FROM amazon
    GROUP BY 1,2
),
Top_2_by_cat AS (
    SELECT *,
           RANK() OVER(PARTITION BY product_category ORDER BY S DESC) AS Ranking
    FROM Total_rev
)
SELECT *
FROM Top_2_by_cat
WHERE Ranking <= 2;
```

5️⃣ Customer Revenue Analysis
```SQL
SELECT 
    customer_id,
    COUNT(order_id) AS Total_Orders,
    SUM(Total_Sales_INR) AS Total_Revenue
FROM amazon
GROUP BY 1
ORDER BY 3 DESC;
```

6️⃣ Revenue Contribution % by Category
```SQL
SELECT
    product_category,
    SUM(Total_Sales_INR) AS Total_revenue,
    ROUND((SUM(Total_Sales_INR) /
    SUM(SUM(Total_Sales_INR)) OVER() * 100),2) AS Contribution_percent
FROM amazon
GROUP BY 1;
```

7️⃣ Average Order Value by State
```SQL
SELECT 
    STATE,
    ROUND(SUM(Total_Sales_INR) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM amazon
GROUP BY STATE
ORDER BY avg_order_value DESC;
```

8️⃣ Customer Segmentation
```SQL
WITH total_sale AS (
    SELECT 
        customer_id,
        SUM(Total_Sales_INR) AS Total_revenue
    FROM amazon
    GROUP BY 1
)
SELECT 
    COUNT(*) AS total_customers,
    CASE
        WHEN Total_revenue > 500000 THEN 'HIGH VALUE CUSTOMERS'
        WHEN Total_revenue BETWEEN 300000 AND 500000 THEN 'MEDIUM VALUE CUSTOMERS'
        ELSE 'LOW VALUE CUSTOMERS'
    END AS Customer_segmentation
FROM total_sale
GROUP BY 2;
```

9️⃣ Delivery Status Impact on Rating
```SQL
SELECT
    delivery_status,
    COUNT(Order_id) AS Total_orders,
    SUM(Total_Sales_INR) AS Total_value,
    ROUND(AVG(Review_rating),2) AS Avg_rating
FROM Amazon
GROUP BY 1
ORDER BY 4 DESC;
```

🔟 High Revenue but Low Rating Products
```SQL
SELECT
    Product_name,
    SUM(Total_Sales_INR) AS Total_value,
    ROUND(AVG(Review_rating),2) AS Avg_rating
FROM amazon
GROUP BY 1
HAVING AVG(Review_rating) < 3
ORDER BY 2 DESC;
```

11️⃣ Negative Review Detection
```SQL
SELECT 
    COUNT(*) AS negative_reviews_orders
FROM amazon
WHERE review_text LIKE '%WASTE%'
   OR review_text LIKE '%POOR%'
   OR review_text LIKE '%TERRIBLE%'
   OR review_text LIKE '%BAD%'
   OR review_text LIKE '%DEFECT%';
```

12️⃣ Preferred Payment Method
```SQL
SELECT 
    payment_method,
    COUNT(order_id) AS Total_orders,
    SUM(Total_Sales_INR) AS Total_revenue
FROM amazon
GROUP BY 1
ORDER BY 2 DESC;
```

13️⃣ Weekly Order Pattern
```SQL
SELECT
	DAYNAME(`date`) AS DAY_,
	COUNT(order_id) AS Total_orders,
    SUM(Total_Sales_INR) AS Total_sales
FROM amazon
GROUP BY 1
ORDER BY 2 DESC;
```

14️⃣ Top 10 Products by Quantity
```SQL
SELECT 
    Product_name,
    SUM(quantity) AS Total_qty
FROM amazon
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
```

15️⃣ Top 5 States by Revenue
```SQL
SELECT
    state,
    SUM(Total_Sales_INR) AS Total_revenue
FROM amazon
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

📈 Key Business Insights

Electronics & top-performing categories drive majority revenue.

A small segment of customers contributes disproportionately high revenue.

Certain high-revenue products have low ratings → potential quality risk.

Delivery performance directly impacts customer satisfaction.

Weekend sales show higher order volume.

Payment method usage shows digital preference trend.

Geographic concentration of revenue exists in top-performing states.

Negative sentiment reviews highlight operational/service issues.

💼 Skills Demonstrated

Database Design

Data Cleaning & Validation

Window Functions

CTE (Common Table Expressions)

Ranking & Running Totals

Time-Series Analysis

Customer Segmentation

Business KPI Development

Sentiment Detection using SQL

🚀 Conclusion

This project demonstrates advanced SQL capabilities applied to a real-world e-commerce business scenario. It highlights the ability to transform raw transactional data into actionable insights that support strategic business decisions.

The analysis covers revenue growth, customer behavior, operational efficiency, product performance, and satisfaction trends — reflecting practical data analyst responsibilities.

👤 Author

Sanjeev
Aspiring Data Analyst | SQL | Power BI | Business Analytics
