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
[pc_market_price] [int] NOT NULL
);

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[pc_sales_fact]
    ([cost_price], [sale_price], [discount_amount], [finance_amount], [credit_score], [total_sales_per_employee], [pc_market_price])
    SELECT DISTINCT
         [cost_price],
	[sale_price],
	[discount_amount],
	[finance_amount],
	[credit_score],
	[total_sales_per_employee],
	[pc_market_price]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [cost_price] IS NOT NULL
    AND [sale_price] IS NOT NULL
    AND [discount_amount] IS NOT NULL
    AND [finance_amount] IS NOT NULL
    AND [credit_score] IS NOT NULL
    AND [total_sales_per_employee] IS NOT NULL
    AND [pc_market_price] IS NOT NULL
   ;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[pc_sales_fact];
END;