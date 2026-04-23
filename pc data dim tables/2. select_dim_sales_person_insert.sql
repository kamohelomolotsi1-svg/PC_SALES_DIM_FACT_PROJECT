DROP TABLE [dimtables].[dbo].[dim_sales_person]
CREATE TABLE [dimtables].[dbo].[dim_sales_person](
    [sales_person_id] INT IDENTITY(1, 1) PRIMARY KEY,
	[sales_person_name] [nvarchar](50) NOT NULL,
	[sales_person_department] [nvarchar](50) NOT NULL
)

INSERT INTO [dimtables].[dbo].[dim_sales_person]
([sales_person_name], [sales_person_department])
SELECT  [sales_person_name]
,[sales_person_Department]
FROM [dimtables].[dbo].[raw_pc_data]



SELECT DISTINCT * FROM [dimtables].[dbo].[dim_sales_person]

