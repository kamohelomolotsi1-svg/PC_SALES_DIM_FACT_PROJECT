DROP TABLE [dimtables].[dbo].[dim_shop]
CREATE TABLE [dimtables].[dbo].[dim_shop](
    [shop_id] INT IDENTITY(1, 1) PRIMARY KEY,
	[shop_name] [nvarchar](50) NOT NULL,
	[shop_age] [nvarchar](50) NOT NULL
)



INSERT INTO [dimtables].[dbo].[dim_shop]
([shop_name], [shop_age])
SELECT [shop_name]
      ,[shop_age]
--INTO [dimtables].[dbo].[dim_shop]
FROM [dimtables].[dbo].[raw_pc_data]

--

SELECT * FROM [dimtables].[dbo].[dim_shop]