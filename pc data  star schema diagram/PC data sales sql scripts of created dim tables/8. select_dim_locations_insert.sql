DROP TABLE [dimtables].[dbo].[dim_locations]
CREATE TABLE [dbo].[dim_locations](
[Location_ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[Continent] [nvarchar](50) NOT NULL,
	[Country_or_State] [nvarchar](50) NOT NULL,
	[Province_or_City] [nvarchar](100) NOT NULL
)


SELECT DISTINCT * FROM [dimtables].[dbo].[dim_locations]

INSERT INTO [dimtables].[dbo].[dim_locations]
([Continent], [Country_or_State], [Province_or_City])
SELECT DISTINCT [Continent]
       ,[Country_or_State]
	   ,[Province_or_City]
FROM [dimtables].[dbo].[raw_pc_data]

----

INSERT INTO [dimtables].[dbo].[dim_locations]
([Continent], [Country_or_State], [Province_or_City])
SELECT DISTINCT LTRIM(RTRIM(B.[Continent]))
       ,LTRIM(RTRIM(B.[Country_or_State]))
	   ,LTRIM(RTRIM(B.[Province_or_City]))
FROM [dimtables].[dbo].[raw_pc_data] B
WHERE NOT EXISTS (
SELECT 1 
FROM [dimtables].[dbo].[dim_locations] A
WHERE LTRIM(RTRIM(A.[Continent])) = LTRIM(RTRIM(B.[Continent]))
AND LTRIM(RTRIM(A.[Country_or_State])) = LTRIM(RTRIM(B.[Country_or_State]))
AND LTRIM(RTRIM(A.[Province_or_City])) = LTRIM(RTRIM(B.[Province_or_City])));
       