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
[shop_id] INT IDENTITY(1, 1) PRIMARY KEY,
	[shop_name] [nvarchar](50) NOT NULL,
	[shop_age] [nvarchar](50) NOT NULL
    );

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[dim_shop]
    ([shop_name], [shop_age])
    SELECT DISTINCT
         [shop_name], [shop_age]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [shop_name] IS NOT NULL
    AND [shop_age] IS NOT NULL
   ;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[dim_shop];
END;


EXEC [dbo].[sp_load_dim_shop]