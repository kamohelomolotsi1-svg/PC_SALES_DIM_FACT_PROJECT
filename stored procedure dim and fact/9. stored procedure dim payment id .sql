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
      [Payment_ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[Payment_Method] [nvarchar](50) NOT NULL
    );

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[dim_payment_id]
    ([Payment_Method])
    SELECT DISTINCT
         [Payment_Method]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [Payment_Method] IS NOT NULL
   ;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[dim_payment_id];
END;




EXEC [dbo].[sp_load_dim_payment_id]