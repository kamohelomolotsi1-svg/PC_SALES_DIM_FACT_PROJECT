DROP PROCEDURE [dbo].[sp_load_dim_customer_details]
CREATE PROCEDURE [dbo].[sp_load_dim_customer_details]
AS
BEGIN
    SET NOCOUNT ON;

    -- Drop table if exists (full reload)
    IF OBJECT_ID('[dimtables].[dbo].[dim_customer_details]', 'U') IS NOT NULL
        DROP TABLE [dimtables].[dbo].[dim_customer_details];

    -- Recreate table
    CREATE TABLE [dimtables].[dbo].[dim_customer_details](
        [customer_id] INT IDENTITY(1,1) PRIMARY KEY,
        [customer_name] NVARCHAR(50) NOT NULL,
        [customer_surname] NVARCHAR(50) NOT NULL,
        [customer_contact_number] NVARCHAR(50) NOT NULL,
        [customer_email_address] NVARCHAR(50) NOT NULL,
    );

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[dim_customer_details]
    ([customer_name], [customer_surname], [customer_contact_number], [customer_email_address])
    SELECT DISTINCT
         [customer_name], [customer_surname], [customer_contact_number], [customer_email_address]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [customer_name] IS NOT NULL
    AND [customer_surname] IS NOT NULL
    AND [customer_contact_number] IS NOT NULL
    AND [customer_email_address] IS NOT NULL;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[dim_customer_details];
END;

EXEC [dbo].[sp_load_dim_customer_details]