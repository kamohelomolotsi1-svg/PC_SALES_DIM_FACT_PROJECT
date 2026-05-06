CREATE PROCEDURE sp_load_dim_date
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dimtables].[dbo].[dim_date2]
    ([full_date], [month], [year])
    SELECT DISTINCT
        d.Full_Date,
        MONTH(d.Full_Date),
        YEAR(d.Full_Date)
    FROM (
        SELECT TRY_CONVERT(DATE, purchase_date, 103) AS Full_Date
        FROM [dimtables].[dbo].[raw_pc_data]

        UNION

        SELECT TRY_CONVERT(DATE, ship_date, 103)
        FROM [dimtables].[dbo].[raw_pc_data]
    ) d
    WHERE d.Full_Date IS NOT NULL
    AND NOT EXISTS (
        SELECT 1
        FROM [dimtables].[dbo].[dim_date2] x
        WHERE x.full_date = d.Full_Date
    );
END;


EXEC sp_load_dim_date;