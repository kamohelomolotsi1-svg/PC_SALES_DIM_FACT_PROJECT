DROP PROCEDURE [dbo].[sp_load_dim_priority]
--

CREATE PROCEDURE [dbo].[sp_load_dim_priority]
AS
BEGIN
    SET NOCOUNT ON;

    -- Drop table if exists (full reload)
    IF OBJECT_ID('[dimtables].[dbo].[dim_priority]', 'U') IS NOT NULL
        DROP TABLE [dimtables].[dbo].[dim_priority];

    -- Recreate table
    CREATE TABLE [dimtables].[dbo].[dim_priority](
   [priority_id] INT IDENTITY (1, 1) PRIMARY KEY,
	[priority] [nvarchar](50) NOT NULL
    );

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[dim_priority]
    ([priority])
    SELECT DISTINCT
         [priority]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [priority] IS NOT NULL
   ;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[dim_priority];
END;


EXEC [dbo].[sp_load_dim_priority]