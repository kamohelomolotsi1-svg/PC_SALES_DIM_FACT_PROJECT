DROP PROCEDURE [dbo].[sp_load_pc_sales_fact]
--

CREATE PROCEDURE [dbo].[sp_load_pc_sales_fact]
AS
BEGIN
    SET NOCOUNT ON;

    -- Drop table if exists (full reload)
    IF OBJECT_ID('[dimtables].[dbo].[pc_sales_fact]', 'U') IS NOT NULL
        DROP TABLE [dimtables].[dbo].[pc_sales_fact];

    -- Recreate table
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
[PC_Market_Price] [int] NOT NULL
);

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[pc_sales_fact]
    ([Cost_Price], [Sale_Price], [Discount_Amount], [Finance_Amount], [Credit_Score], [Total_Sales_per_Employee], [PC_Market_Price])
    SELECT DISTINCT
         [Cost_Price],
	[Sale_Price],
	[Discount_Amount],
	[Finance_Amount],
	[Credit_Score],
	[Total_Sales_per_Employee],
	[PC_Market_Price]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [Cost_Price] IS NOT NULL
    AND [Sale_Price] IS NOT NULL
    AND [Discount_Amount] IS NOT NULL
    AND [Finance_Amount] IS NOT NULL
    AND [Credit_Score] IS NOT NULL
    AND [Total_Sales_per_Employee] IS NOT NULL
    AND [PC_Market_Price] IS NOT NULL
   ;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[pc_sales_fact];
END;