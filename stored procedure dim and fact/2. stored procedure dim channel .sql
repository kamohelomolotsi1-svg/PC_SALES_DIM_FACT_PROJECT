DROP PROCEDURE [dbo].[sp_load_dim_channel]
CREATE PROCEDURE [dbo].[sp_load_dim_channel]
AS
BEGIN
    SET NOCOUNT ON;

    -- Drop table if exists (full reload)
    IF OBJECT_ID('[dimtables].[dbo].[dim_channel]', 'U') IS NOT NULL
        DROP TABLE [dimtables].[dbo].[dim_channel];

    -- Recreate table
    CREATE TABLE [dimtables].[dbo].[dim_channel](
        [Channel_ID] INT IDENTITY(1,1) PRIMARY KEY,
        [Channel] NVARCHAR(50) NOT NULL,
    );

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[dim_channel] ([Channel])
    SELECT DISTINCT
        [Channel]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [Channel] IS NOT NULL
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[dim_channel];
END;

EXEC [dbo].[sp_load_dim_channel]