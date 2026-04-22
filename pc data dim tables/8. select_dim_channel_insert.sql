DROP TABLE [dimtables].[dbo].[dim_channel]
CREATE TABLE [dimtables].[dbo].[dim_channel](
    [Channel_ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[Channel] [nvarchar](50) NOT NULL
)


SELECT * FROM [dimtables].[dbo].[dim_channel]

INSERT INTO [dimtables].[dbo].[dim_channel]
([Channel])
SELECT DISTINCT [Channel]
--INTO [dimtables].[dbo].[dim_channel]
FROM [dimtables].[dbo].[raw_pc_data]