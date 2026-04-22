DROP PROCEDURE [dbo].[sp_load_dim_locations]
--

CREATE PROCEDURE [dbo].[sp_load_dim_locations]
AS
BEGIN
    SET NOCOUNT ON;

    -- Drop table if exists (full reload)
    IF OBJECT_ID('[dimtables].[dbo].[dim_locations]', 'U') IS NOT NULL
        DROP TABLE [dimtables].[dbo].[dim_locations];

    -- Recreate table
    CREATE TABLE [dimtables].[dbo].[dim_locations](
  [Location_ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[Continent] [nvarchar](50) NOT NULL,
	[Country_or_State] [nvarchar](50) NOT NULL,
	[Province_or_City] [nvarchar](50) NOT NULL
    );

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[dim_locations]
    ([Continent], [Country_or_State], [Province_or_City])
    SELECT DISTINCT
         [Continent], [Country_or_State], [Province_or_City]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [Continent] IS NOT NULL
    AND [Country_or_State] IS NOT NULL
    AND [Province_or_City] IS NOT NULL
   ;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[dim_locations];
END;


EXEC [dbo].[sp_load_dim_locations]