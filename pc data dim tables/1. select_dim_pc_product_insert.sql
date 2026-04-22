DROP TABLE [dimtables].[dbo].[dim_pc_product]
CREATE TABLE [dimtables].[dbo].[dim_pc_product](
    [PC_Product_ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[PC_Make] [nvarchar](50) NOT NULL,
	[PC_Model] [nvarchar](50) NOT NULL,
	[Storage_Type] [nvarchar](50) NOT NULL,
	[RAM] [nvarchar](50) NOT NULL,
	[Storage_Capacity] [nvarchar](50) NOT NULL
)


SELECT * FROM [dimtables].[dbo].[dim_pc_product]

INSERT INTO [dimtables].[dbo].[dim_pc_product] 
([PC_Make], [PC_Model], [Storage_Type], [RAM], [Storage_Capacity])
SELECT [PC_Make]
      ,[PC_Model]
      ,[Storage_Type]
      ,[RAM]
      ,[Storage_Capacity]
FROM [dimtables].[dbo].[raw_pc_data]




