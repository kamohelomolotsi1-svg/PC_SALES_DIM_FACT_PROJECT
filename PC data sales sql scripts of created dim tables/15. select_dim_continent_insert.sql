DROP TABLE [dimtables].[dbo].[dim_continent]
CREATE TABLE [dimtables].[dbo].[dim_continent](
    [Continent_ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[Continent] [nvarchar](50) NOT NULL
)


INSERT INTO [dimtables].[dbo].[dim_continent]
([Continent])
SELECT DISTINCT
    [Continent]
	FROM [dimtables].[dbo].[raw_pc_data]
WHERE [Continent] IN ('North America', 'Africa');

SELECT * FROM [dimtables].[dbo].[dim_continent]