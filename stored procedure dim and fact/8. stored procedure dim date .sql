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
  [date_id] INT IDENTITY(1, 1) PRIMARY KEY,
	[purchase_date] [datetime2](7) NOT NULL,
	[ship_date] [nvarchar](50) NOT NULL
    );

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[dim_date]
    ([purchase_date], [ship_date])
    SELECT DISTINCT
         [purchase_date], [ship_date]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [purchase_date] IS NOT NULL
    AND [ship_date] IS NOT NULL
   ;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[dim_date];
END;


EXEC [dbo].[sp_load_dim_date]