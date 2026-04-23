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
,[pc_market_price])
SELECT DISTINCT [cost_price],
	[sale_price],
	[discount_amount],
	[finance_amount],
	[credit_score],
	[total_sales_per_employee],
	[pc_market_price]
FROM [dimtables].[dbo].[raw_pc_data]



SELECT * FROM [dimtables].[dbo].[pc_sales_fact]


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





