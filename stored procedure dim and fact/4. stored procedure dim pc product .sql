DROP PROCEDURE [dbo].[sp_load_[dim_pc_product]

CREATE PROCEDURE [dbo].[sp_load_dim_pc_product]
AS
BEGIN
    SET NOCOUNT ON;

    -- Drop table if exists (full reload)
    IF OBJECT_ID('[dimtables].[dbo].[dim_pc_product]', 'U') IS NOT NULL
        DROP TABLE [dimtables].[dbo].[dim_pc_product];

    -- Recreate table
    CREATE TABLE [dimtables].[dbo].[dim_pc_product](
  [PC_Product_ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[PC_Make] [nvarchar](50) NOT NULL,
	[PC_Model] [nvarchar](50) NOT NULL,
	[Storage_Type] [nvarchar](50) NOT NULL,
	[RAM] [nvarchar](50) NOT NULL,
	[Storage_Capacity] [nvarchar](50) NOT NULL
    );

    -- Insert distinct values
    INSERT INTO [dimtables].[dbo].[dim_pc_product]
    ([PC_Make], [PC_Model], [Storage_Type], [RAM], [Storage_Capacity])
    SELECT DISTINCT
         [PC_Make], [PC_Model], [Storage_Type], [RAM], [Storage_Capacity]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [Customer_Name] IS NOT NULL
    AND [Customer_Surname] IS NOT NULL
    AND [Customer_Contact_Number] IS NOT NULL
    AND [Customer_Email_Address] IS NOT NULL;
      

    -- View results
    SELECT * FROM [dimtables].[dbo].[dim_pc_product];
END;

EXEC [dbo].[sp_load_dim_pc_product]