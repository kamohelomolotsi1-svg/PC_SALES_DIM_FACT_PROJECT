DROP TABLE [dimtables].[dbo].[dim_locations]
CREATE TABLE [dbo].[dim_locations](
[location_id] INT IDENTITY(1, 1) PRIMARY KEY,
	[continent] [nvarchar](50) NOT NULL,
	[country_or_state] [nvarchar](50) NOT NULL,
	[province_or_city] [nvarchar](100) NOT NULL
)



INSERT INTO [dimtables].[dbo].[dim_locations]
([continent], [country_or_state], [province_or_city])
SELECT DISTINCT [continent]
       ,[country_or_state]
	   ,[province_or_city]
FROM [dimtables].[dbo].[raw_pc_data]

----

SELECT DISTINCT * FROM [dimtables].[dbo].[dim_locations]

--INSERT INTO [dimtables].[dbo].[dim_locations]
--([Continent], [Country_or_State], [Province_or_City])
--SELECT DISTINCT LTRIM(RTRIM(B.[Continent]))
       --,LTRIM(RTRIM(B.[Country_or_State]))
	  -- ,LTRIM(RTRIM(B.[Province_or_City]))
--FROM [dimtables].[dbo].[raw_pc_data] B
--WHERE NOT EXISTS (
--SELECT 1 
--FROM [dimtables].[dbo].[dim_locations] A
--WHERE LTRIM(RTRIM(A.[Continent])) = LTRIM(RTRIM(B.[Continent]))
--AND LTRIM(RTRIM(A.[Country_or_State])) = LTRIM(RTRIM(B.[Country_or_State]))
--AND LTRIM(RTRIM(A.[Province_or_City])) = LTRIM(RTRIM(B.[Province_or_City])));
       