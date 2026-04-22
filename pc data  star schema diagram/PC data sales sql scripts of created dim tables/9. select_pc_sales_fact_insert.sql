DROP TABLE [dimtables].[dbo].[pc_sales_fact]
CREATE TABLE [dimtables].[dbo].[pc_sales_fact](
[Sale_ID] INT IDENTITY(1, 1) PRIMARY KEY,
[Customer_ID] INT,
[Location_ID] INT,
[PC_Product_ID] INT,
[Channel_ID] INT,
[Payment_ID] INT,
[Sales_Person_ID] INT,
[Date_ID] INT,
[Shop_ID] INT,
[Priority_ID] INT,
[Cost_Price] [int] NOT NULL,
[Sale_Price] [int] NOT NULL,
[Discount_Amount] [int] NOT NULL,
[Finance_Amount] [nvarchar](50) NOT NULL,
[Credit_Score] [int] NOT NULL,
[Total_Sales_per_Employee] [int] NOT NULL,
[PC_Market_Price] [int] NOT NULL,
	CONSTRAINT fk_Customer_ID
	           FOREIGN KEY (Customer_ID)
	           REFERENCES [dimtables].[dbo].[dim_customer_details] (Customer_ID),
    CONSTRAINT fk_Location_ID
	           FOREIGN KEY (Location_ID)
	           REFERENCES [dimtables].[dbo].[dim_locations] (Location_ID),
    CONSTRAINT fk_PC_Product_ID
	           FOREIGN KEY (PC_Product_ID)
	           REFERENCES [dimtables].[dbo].[dim_pc_product] (PC_Product_ID),
	CONSTRAINT fk_Channel_ID
	           FOREIGN KEY (Channel_ID)
	           REFERENCES [dimtables].[dbo].[dim_channel] (Channel_ID),
    CONSTRAINT fk_Payment_ID
	           FOREIGN KEY (Payment_ID)
	           REFERENCES [dimtables].[dbo].[dim_payment_id] (Payment_ID),
	CONSTRAINT fk_Sales_Person_ID
	           FOREIGN KEY (Sales_Person_ID)
	           REFERENCES [dimtables].[dbo].[dim_sales_person] (Sales_Person_ID),
	CONSTRAINT fk_Date_ID
	           FOREIGN KEY (Date_ID)
	           REFERENCES [dimtables].[dbo].[dim_date] (Date_ID),
	CONSTRAINT fk_Shop_ID
	           FOREIGN KEY (Shop_ID)
	           REFERENCES [dimtables].[dbo].[dim_shop] (Shop_ID),
	CONSTRAINT fk_Priority_ID
	           FOREIGN KEY (Priority_ID)
	           REFERENCES [dimtables].[dbo].[dim_priority] (Priority_ID)
)





INSERT INTO [dimtables].[dbo].[pc_sales_fact]
([Cost_Price]
,[Sale_Price]
,[Discount_Amount]
,[Finance_Amount]
,[Credit_Score]
,[Total_Sales_per_Employee]
,[PC_Market_Price])
SELECT DISTINCT [Cost_Price],
	[Sale_Price],
	[Discount_Amount],
	[Finance_Amount],
	[Credit_Score],
	[Total_Sales_per_Employee],
	[PC_Market_Price]
FROM [dimtables].[dbo].[raw_pc_data]



SELECT * FROM [dimtables].[dbo].[pc_sales_fact]