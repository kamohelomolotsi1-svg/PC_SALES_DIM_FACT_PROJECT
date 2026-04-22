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
   [Priority_ID] INT IDENTITY (1, 1) PRIMARY KEY,
	[Priority] [nvarchar](50) NOT NULL
    );

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[dim_priority]
    ([Priority])
    SELECT DISTINCT
         [Priority]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [Priority] IS NOT NULL
   ;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[dim_priority];
END;


EXEC [dbo].[sp_load_dim_priority]