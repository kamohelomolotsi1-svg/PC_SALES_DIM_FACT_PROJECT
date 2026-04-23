DROP TABLE [dimtables].[dbo].[dim_date]
CREATE TABLE [dimtables].[dbo].[dim_date](
    [date_id] INT IDENTITY(1, 1) PRIMARY KEY,
	[purchase_date] [datetime2](7) NOT NULL,
	[ship_date] [nvarchar](50) NOT NULL
)

SELECT * FROM [dimtables].[dbo].[dim_date]

INSERT INTO [dimtables].[dbo].[dim_date]
([purchase_date], [ship_date])
SELECT [purchase_date]
      ,[ship_date]
--INTO [dimtables].[dbo].[dim_date]
FROM [dimtables].[dbo].[raw_pc_data]