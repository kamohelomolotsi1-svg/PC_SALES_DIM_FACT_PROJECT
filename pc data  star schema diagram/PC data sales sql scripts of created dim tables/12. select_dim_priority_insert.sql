DROP TABLE [dimtables].[dbo].[dim_priority]
CREATE TABLE [dbo].[dim_priority](
    [Priority_ID] INT IDENTITY (1, 1) PRIMARY KEY,
	[Priority] [nvarchar](50) NOT NULL
)

SELECT * FROM [dimtables].[dbo].[dim_priority]

INSERT INTO [dimtables].[dbo].[dim_priority]
([Priority])
SELECT DISTINCT [Priority]
--INTO [dimtables].[dbo].[dim_priority]
FROM [dimtables].[dbo].[raw_pc_data]