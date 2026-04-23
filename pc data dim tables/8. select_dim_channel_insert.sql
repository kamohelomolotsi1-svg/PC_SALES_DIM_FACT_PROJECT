DROP TABLE [dimtables].[dbo].[dim_channel]
CREATE TABLE [dimtables].[dbo].[dim_channel](
    [channel_id] INT IDENTITY(1, 1) PRIMARY KEY,
	[channel] [nvarchar](50) NOT NULL
)


SELECT * FROM [dimtables].[dbo].[dim_channel]

INSERT INTO [dimtables].[dbo].[dim_channel]
([channel])
SELECT DISTINCT [channel]
--INTO [dimtables].[dbo].[dim_channel]
FROM [dimtables].[dbo].[raw_pc_data]