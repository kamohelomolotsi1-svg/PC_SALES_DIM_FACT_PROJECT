DROP TABLE [dimtables].[dbo].[dim_date]
CREATE TABLE [dimtables].[dbo].[dim_date](
    [Date_ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[Purchase_Date] [datetime2](7) NOT NULL,
	[Ship_Date] [nvarchar](50) NOT NULL
)

SELECT * FROM [dimtables].[dbo].[dim_date]

INSERT INTO [dimtables].[dbo].[dim_date]
([Purchase_Date], [Ship_Date])
SELECT [Purchase_Date]
      ,[Ship_Date]
--INTO [dimtables].[dbo].[dim_date]
FROM [dimtables].[dbo].[raw_pc_data]