SET IDENTITY_INSERT [dimtables].[dbo].[dim_date2] ON

INSERT INTO [dimtables].[dbo].[dim_date2]
/*Note the column list is REQUIRED here, not optional*/
            ([date_id],
             [full_date],
             [month],
             [year])
VALUES      (20,
             'Hierachy Update',
             1)

SET IDENTITY_INSERT [dimtables].[dbo].[dim_date2] OFF 



CREATE TABLE [dimtables].[dbo].[dim_date2](
[date_id] INT IDENTITY(1, 1) PRIMARY KEY,
[full_date] DATE,
[month] INT,
[year] INT

)

INSERT INTO [dimtables].[dbo].[dim_date2]
([full_date], [month], [year])
SELECT DISTINCT
    Full_Date,
    MONTH(Full_Date),
    YEAR(Full_Date)
FROM (
SELECT DISTINCT TRY_CONVERT(DATE, purchase_date, 103) AS Full_Date FROM [dimtables].[dbo].[raw_pc_data]
UNION
SELECT DISTINCT TRY_CONVERT(DATE, ship_date, 103) AS Full_Date FROM [dimtables].[dbo].[raw_pc_data]
) AS dates
WHERE Full_Date IS NOT NULL

----


SELECT * FROM [dimtables].[dbo].[dim_date2]



----


UPDATE A
SET A.date_id = H.date_id
FROM [dimtables].[dbo].[raw_pc_data] A
JOIN [dimtables].[dbo].[dim_date2] H
ON TRY_CONVERT(DATE, A.purchase_date, 103) = H.full_date;


SELECT * FROM [dimtables].[dbo].[raw_pc_data]


ALTER TABLE [dimtables].[dbo].[raw_pc_data]
ADD date_id INT;

UPDATE A
SET A.date_id = H.date_id
FROM [dimtables].[dbo].[raw_pc_data] A
JOIN [dimtables].[dbo].[dim_date2] H
ON TRY_CONVERT(DATE, A.purchase_date, 103) = H.full_date;