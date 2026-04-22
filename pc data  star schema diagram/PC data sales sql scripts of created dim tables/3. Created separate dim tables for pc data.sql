SELECT DISTINCT [Continent]
      ,[Country_or_State]
      ,[Province_or_City]
FROM [dimtables].[dbo].[raw_pc_data]

----------

SELECT DISTINCT [Continent]
      ,[Country_or_State]
      ,[Province_or_City]
--INTO [dimtables].[dbo].[dim_location]
FROM [dimtables].[dbo].[raw_pc_data]

----------

SELECT [Customer_Name]
      ,[Customer_Surname]
      ,[Customer_Contact_Number]
      ,[Customer_Email_Address]
--INTO [dimtables].[dbo].[dim_customer_details]
FROM [dimtables].[dbo].[raw_pc_data]

----------

SELECT [Cost_Price]
      ,[Sale_Price]
      ,[Discount_Amount]
      ,[Finance_Amount]
      ,[Credit_Score]
      ,[Total_Sales_per_Employee]
      ,[PC_Market_Price]
--INTO [dimtables].[dbo].[pc_sales_fact]
FROM [dimtables].[dbo].[raw_pc_data]

--------
SELECT [Shop_Name]
      ,[Shop_Age]
--INTO [dimtables].[dbo].[dim_shop]
FROM [dimtables].[dbo].[raw_pc_data]

-------

SELECT [PC_Make]
      ,[PC_Model]
      ,[Storage_Type]
      ,[RAM]
      ,[Storage_Capacity]
--INTO [dimtables].[dbo].[dim_pc_product]
FROM [dimtables].[dbo].[raw_pc_data]

-------

SELECT  [Sales_Person_Name]
,[Sales_Person_Department]
--INTO [dimtables].[dbo].[dim_sales_person]
FROM [dimtables].[dbo].[raw_pc_data]

-------
SELECT [Purchase_Date]
      ,[Ship_Date]
--INTO [dimtables].[dbo].[dim_date]
FROM [dimtables].[dbo].[raw_pc_data]

-------

SELECT DISTINCT [Payment_Method]
--INTO [dimtables].[dbo].[dim_payment_id]
FROM [dimtables].[dbo].[raw_pc_data]

-------

SELECT DISTINCT [Channel]
--INTO [dimtables].[dbo].[dim_channel]
FROM [dimtables].[dbo].[raw_pc_data]

-------

SELECT DISTINCT [Priority]
--INTO [dimtables].[dbo].[dim_priority]
FROM [dimtables].[dbo].[raw_pc_data]







