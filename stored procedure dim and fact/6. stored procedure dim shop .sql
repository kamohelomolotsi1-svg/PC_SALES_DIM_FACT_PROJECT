DROP PROCEDURE [dbo].[sp_load_dim_shop]
--

CREATE PROCEDURE [dbo].[sp_load_dim_shop]
AS
BEGIN
    SET NOCOUNT ON;

    -- Drop table if exists (full reload)
    IF OBJECT_ID('[dimtables].[dbo].[dim_shop]', 'U') IS NOT NULL
        DROP TABLE [dimtables].[dbo].[dim_shop];

    -- Recreate table
    CREATE TABLE [dimtables].[dbo].[dim_shop](
[Shop_ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[Shop_Name] [nvarchar](50) NOT NULL,
	[Shop_Age] [nvarchar](50) NOT NULL
    );

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[dim_shop]
    ([Shop_Name], [Shop_Age])
    SELECT DISTINCT
         [Shop_Name], [Shop_Age]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [Shop_Name] IS NOT NULL
    AND [Shop_Age] IS NOT NULL
   ;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[dim_shop];
END;


EXEC [dbo].[sp_load_dim_shop]