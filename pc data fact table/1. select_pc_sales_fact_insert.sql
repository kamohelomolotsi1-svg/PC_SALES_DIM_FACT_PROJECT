DROP TABLE [dimtables].[dbo].[pc_sales_fact]
CREATE TABLE [dimtables].[dbo].[pc_sales_fact](
[sale_id] INT IDENTITY(1, 1) PRIMARY KEY,
[customer_id] INT,
[location_id] INT,
[pc_product_id] INT,
[channel_id] INT,
[payment_id] INT,
[sales_person_id] INT,
[date_id] INT,
[shop_id] INT,
[priority_id] INT,
[cost_price] [int] NOT NULL,
[sale_price] [int] NOT NULL,
[discount_amount] [int] NOT NULL,
[finance_amount] [nvarchar](50) NOT NULL,
[credit_score] [int] NOT NULL,
[total_sales_per_employee] [int] NOT NULL,
[pc_market_price] [int] NOT NULL)


INSERT INTO [dimtables].[dbo].[pc_sales_fact]
([cost_price]
,[sale_price]
,[discount_amount]
,[finance_amount]
,[credit_score]
,[total_sales_per_employee]
,[pc_market_price]
,[pc_product_id]
,[sales_person_id]
,[location_id]
,[payment_id]
,[shop_id]
,[priority_id]
,[date_id]
,[channel_id]
,[customer_id]

)

SELECT  
A.[cost_price],
A.[sale_price],
A.[discount_amount],
A.[finance_amount],
A.[credit_score],
A.[total_sales_per_employee],
A.[pc_market_price],
B.[pc_product_id],
C.[sales_person_id],
D.[location_id],
E.[payment_id],
F.[shop_id],
G.[priority_id],
H.[date_id],
I.[channel_id],
J.[customer_id]
FROM [dimtables].[dbo].[raw_pc_data] A

INNER JOIN [dimtables].[dbo].[dim_pc_product] B
ON A.pc_make = B.pc_make

INNER JOIN [dimtables].[dbo].[dim_sales_person] C
ON A.sales_person_department = C.sales_person_department

INNER JOIN [dimtables].[dbo].[dim_locations] D
ON A.continent = D.continent

INNER JOIN [dimtables].[dbo].[dim_payment_id] E
ON A.payment_method = E.payment_method

INNER JOIN [dimtables].[dbo].[dim_shop] F
ON A.shop_name = F.shop_name

INNER JOIN [dimtables].[dbo].[dim_priority] G
ON A.priority = G.priority

INNER JOIN [dimtables].[dbo].[dim_date] H
ON A.purchase_date = H.purchase_date

INNER JOIN [dimtables].[dbo].[dim_channel] I
ON A.channel = I.channel

INNER JOIN [dimtables].[dbo].[dim_customer_details] J
ON A.customer_name = J.customer_name



----
SELECT * FROM [dimtables].[dbo].[pc_sales_fact]

----

TRUNCATE TABLE [dimtables].[dbo].[pc_sales_fact]







	--CONSTRAINT fk_Customer_ID
	           --FOREIGN KEY (Customer_ID)
	          -- REFERENCES [dimtables].[dbo].[dim_customer_details] (Customer_ID),
    --CONSTRAINT fk_Location_ID
	           --FOREIGN KEY (Location_ID)
	           --REFERENCES [dimtables].[dbo].[dim_locations] (Location_ID),
    --CONSTRAINT fk_PC_Product_ID
	           --FOREIGN KEY (PC_Product_ID)
	           --REFERENCES [dimtables].[dbo].[dim_pc_product] (PC_Product_ID),
	--CONSTRAINT fk_Channel_ID
	           --FOREIGN KEY (Channel_ID)
	           --REFERENCES [dimtables].[dbo].[dim_channel] (Channel_ID),
    --CONSTRAINT fk_Payment_ID
	           --FOREIGN KEY (Payment_ID)
	           --REFERENCES [dimtables].[dbo].[dim_payment_id] (Payment_ID),
	--CONSTRAINT fk_Sales_Person_ID
	           --FOREIGN KEY (Sales_Person_ID)
	           --REFERENCES [dimtables].[dbo].[dim_sales_person] (Sales_Person_ID),
	--CONSTRAINT fk_Date_ID
	           --FOREIGN KEY (Date_ID)
	           --REFERENCES [dimtables].[dbo].[dim_date] (Date_ID),
	--CONSTRAINT fk_Shop_ID
	           --FOREIGN KEY (Shop_ID)
	           --REFERENCES [dimtables].[dbo].[dim_shop] (Shop_ID),
	--CONSTRAINT fk_Priority_ID
	           --FOREIGN KEY (Priority_ID)
	           --REFERENCES [dimtables].[dbo].[dim_priority] (Priority_ID)


SELECT customer_name, COUNT(*)
FROM [dimtables].[dbo].[dim_customer_details]
GROUP BY customer_name
HAVING COUNT(*) > 1;









