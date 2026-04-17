DROP TABLE [dimtables].[dbo].[dim_shop]
CREATE TABLE [dimtables].[dbo].[dim_shop](
    [Shop_ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[Shop_Name] [nvarchar](50) NOT NULL,
	[Shop_Age] [nvarchar](50) NOT NULL
)

SELECT * FROM [dimtables].[dbo].[dim_shop]

INSERT INTO [dimtables].[dbo].[dim_shop]
([Shop_Name], [Shop_Age])
SELECT [Shop_Name]
      ,[Shop_Age]
--INTO [dimtables].[dbo].[dim_shop]
FROM [dimtables].[dbo].[raw_pc_data]