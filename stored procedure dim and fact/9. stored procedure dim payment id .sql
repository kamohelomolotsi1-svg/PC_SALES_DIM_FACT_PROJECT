DROP PROCEDURE [dbo].[sp_load_dim_payment_id]
--

CREATE PROCEDURE [dbo].[sp_load_dim_payment_id]
AS
BEGIN
    SET NOCOUNT ON;

    -- Drop table if exists (full reload)
    IF OBJECT_ID('[dimtables].[dbo].[dim_payment_id]', 'U') IS NOT NULL
        DROP TABLE [dimtables].[dbo].[dim_payment_id];

    -- Recreate table
    CREATE TABLE [dimtables].[dbo].[dim_payment_id](
      [payment_id] INT IDENTITY(1, 1) PRIMARY KEY,
	[payment_method] [nvarchar](50) NOT NULL
    );

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[dim_payment_id]
    ([payment_method])
    SELECT DISTINCT
         [payment_method]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [payment_method] IS NOT NULL
   ;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[dim_payment_id];
END;




EXEC [dbo].[sp_load_dim_payment_id]