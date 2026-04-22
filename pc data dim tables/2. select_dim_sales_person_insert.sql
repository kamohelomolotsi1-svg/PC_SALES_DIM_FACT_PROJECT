DROP TABLE [dimtables].[dbo].[dim_sales_person]
CREATE TABLE [dimtables].[dbo].[dim_sales_person](
    [Sales_Person_ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[Sales_Person_Name] [nvarchar](50) NOT NULL,
	[Sales_Person_Department] [nvarchar](50) NOT NULL
)

INSERT INTO [dimtables].[dbo].[dim_sales_person]
([Sales_Person_Name], [Sales_Person_Department])
SELECT  [Sales_Person_Name]
,[Sales_Person_Department]
FROM [dimtables].[dbo].[raw_pc_data]



SELECT DISTINCT * FROM [dimtables].[dbo].[dim_sales_person]

