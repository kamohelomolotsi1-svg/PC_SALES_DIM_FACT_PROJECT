DROP PROCEDURE [dbo].[sp_load_dim_pc_product]

CREATE PROCEDURE [dbo].[sp_load_dim_pc_product]
AS
BEGIN
    SET NOCOUNT ON;

    -- Drop table if exists (full reload)
    IF OBJECT_ID('[dimtables].[dbo].[dim_pc_product]', 'U') IS NOT NULL
        DROP TABLE [dimtables].[dbo].[dim_pc_product];

    -- Recreate table
    CREATE TABLE [dimtables].[dbo].[dim_pc_product](
  [pc_product_id] INT IDENTITY(1, 1) PRIMARY KEY,
	[pc_make] [nvarchar](50) NOT NULL,
	[pc_model] [nvarchar](50) NOT NULL,
	[storage_type] [nvarchar](50) NOT NULL,
	[ram] [nvarchar](50) NOT NULL,
	[storage_capacity] [nvarchar](50) NOT NULL
    );

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[dim_pc_product]
    ([pc_make], [pc_model], [storage_type], [ram], [storage_capacity])
    SELECT DISTINCT
         [pc_make], [pc_model], [storage_type], [ram], [storage_capacity]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [Customer_Name] IS NOT NULL
    AND [Customer_Surname] IS NOT NULL
    AND [Customer_Contact_Number] IS NOT NULL
    AND [Customer_Email_Address] IS NOT NULL;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[dim_pc_product];
END;

EXEC [dbo].[sp_load_dim_pc_product]