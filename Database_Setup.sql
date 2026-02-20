-- CREATE DATABASE AND TABLE ADD COLUMN NAMES WITH PROPER DATA TYTPE AND CONSTRAINTS --

create database Amazon_sales_P1;
use Amazon_sales_P1; 

create table amazon(
		Order_ID VARCHAR(10) NOT NULL PRIMARY KEY, -- UNIQUE VALUES NO NULL VALUES --
		`Date` DATE NOT NULL,
        Customer_ID	VARCHAR(10) ,
        Product_Category VARCHAR(30),	
        Product_Name VARCHAR(30),
        Quantity INT,	
        Unit_Price_INR	DECIMAL(10,2),
        Total_Sales_INR DECIMAL(10,2),
        Payment_Method VARCHAR(30),
        Delivery_Status	VARCHAR(30),
        Review_Rating DECIMAL(5,2),
        Review_Text	VARCHAR(30),
        State VARCHAR(30),
        Country VARCHAR(30)

);

-- INSERT DATA INTO TABLES;
-- HERE DATA IMPORTED USING DATA IMPORT WIZARD INBUILT OPTION --

select * from amazon;







 




