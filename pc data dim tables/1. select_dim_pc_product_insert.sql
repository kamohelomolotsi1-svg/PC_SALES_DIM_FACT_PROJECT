DROP TABLE [dimtables].[dbo].[dim_pc_product]
CREATE TABLE [dimtables].[dbo].[dim_pc_product](
    [pc_product_id] INT IDENTITY(1, 1) PRIMARY KEY,
	[pc_make] [nvarchar](50) NOT NULL,
	[pc_model] [nvarchar](50) NOT NULL,
	[storage_type] [nvarchar](50) NOT NULL,
	[ram] [nvarchar](50) NOT NULL,
	[storage_capacity] [nvarchar](50) NOT NULL
)

 

INSERT INTO [dimtables].[dbo].[dim_pc_product] 
([pc_make], [pc_model], [storage_type], [ram], [storage_capacity])
SELECT [pc_make]
      ,[pc_model]
      ,[storage_type]
      ,[ram]
      ,[storage_capacity]
FROM [dimtables].[dbo].[raw_pc_data]

--

SELECT * FROM [dimtables].[dbo].[dim_pc_product]




