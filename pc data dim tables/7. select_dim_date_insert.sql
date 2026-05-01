TRUNCATE TABLE [dimtables].[dbo].[dim_date]
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

----


CREATE TABLE [dimtables].[dbo].[dim_date2](
[date_id] INT IDENTITY(1, 1) PRIMARY KEY,
[full_date] DATE,
[month] INT,
[year] INT

)

INSERT INTO [dimtables].[dbo].[dim_date2]
([full_date], [month], [year])
SELECT DISTINCT
    CONVERT(INT, FORMAT(Full_Date, 'yyyyMMdd')),
    Full_Date,
    MONTH(Full_Date),
    YEAR(Full_Date)
FROM (
SELECT DISTINCT TRY_CONVERT(DATE, purchase_date, 103) AS Full_Date FROM [dimtables].[dbo].[raw_pc_data]
UNION
SELECT DISTINCT TRY_CONVERT(DATE, ship_date, 103) FROM [dimtables].[dbo].[raw_pc_data]
) AS dates
WHERE Full_Date IS NOT NULL