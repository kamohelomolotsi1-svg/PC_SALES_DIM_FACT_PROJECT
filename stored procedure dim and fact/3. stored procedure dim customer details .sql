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
        [Customer_ID] INT IDENTITY(1,1) PRIMARY KEY,
        [Customer_Name] NVARCHAR(50) NOT NULL,
        [Customer_Surname] NVARCHAR(50) NOT NULL,
        [Customer_Contact_Number] NVARCHAR(50) NOT NULL,
        [Customer_Email_Address] NVARCHAR(50) NOT NULL,
    );

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[dim_customer_details]
    ([Customer_Name], [Customer_Surname], [Customer_Contact_Number], [Customer_Email_Address])
    SELECT DISTINCT
         [Customer_Name], [Customer_Surname], [Customer_Contact_Number], [Customer_Email_Address]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [Customer_Name] IS NOT NULL
    AND [Customer_Surname] IS NOT NULL
    AND [Customer_Contact_Number] IS NOT NULL
    AND [Customer_Email_Address] IS NOT NULL;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[dim_customer_details];
END;

EXEC [dbo].[sp_load_dim_customer_details]