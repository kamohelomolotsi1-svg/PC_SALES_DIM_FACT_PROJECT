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
  [location_id] INT IDENTITY(1, 1) PRIMARY KEY,
	[continent] [nvarchar](50) NOT NULL,
	[country_or_state] [nvarchar](50) NOT NULL,
	[province_or_city] [nvarchar](50) NOT NULL
    );

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[dim_locations]
    ([continent], [country_or_state], [province_or_city])
    SELECT DISTINCT
         [continent], [country_or_state], [province_or_city]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [continent] IS NOT NULL
    AND [country_or_state] IS NOT NULL
    AND [province_or_city] IS NOT NULL
   ;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[dim_locations];
END;


EXEC [dbo].[sp_load_dim_locations]