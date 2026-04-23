DROP TABLE [dimtables].[dbo].[dim_priority]
CREATE TABLE [dbo].[dim_priority](
    [priority_id] INT IDENTITY (1, 1) PRIMARY KEY,
	[priority] [nvarchar](50) NOT NULL
)

SELECT * FROM [dimtables].[dbo].[dim_priority]

INSERT INTO [dimtables].[dbo].[dim_priority]
([priority])
SELECT DISTINCT [priority]
--INTO [dimtables].[dbo].[dim_priority]
FROM [dimtables].[dbo].[raw_pc_data]