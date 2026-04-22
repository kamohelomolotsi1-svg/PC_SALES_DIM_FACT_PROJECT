DROP PROCEDURE [dbo].[sp_load_dim_date]
--

CREATE PROCEDURE [dbo].[sp_load_dim_date]
AS
BEGIN
    SET NOCOUNT ON;

    -- Drop table if exists (full reload)
    IF OBJECT_ID('[dimtables].[dbo].[dim_date]', 'U') IS NOT NULL
        DROP TABLE [dimtables].[dbo].[dim_date];

    -- Recreate table
    CREATE TABLE [dimtables].[dbo].[dim_date](
  [Date_ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[Purchase_Date] [datetime2](7) NOT NULL,
	[Ship_Date] [nvarchar](50) NOT NULL
    );

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[dim_date]
    ([Purchase_Date], [Ship_Date])
    SELECT DISTINCT
         [Purchase_Date], [Ship_Date]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [Purchase_Date] IS NOT NULL
    AND [Ship_Date] IS NOT NULL
   ;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[dim_date];
END;


EXEC [dbo].[sp_load_dim_date]