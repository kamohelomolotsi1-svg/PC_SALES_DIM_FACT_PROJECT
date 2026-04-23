DROP PROCEDURE [dbo].[sp_load_dim_sales_person]
CREATE PROCEDURE [dbo].[sp_load_dim_sales_person]
AS
BEGIN
    SET NOCOUNT ON;

    -- Drop and recreate table (only if you truly want a full reload)
    IF OBJECT_ID('[dimtables].[dbo].[dim_sales_person]', 'U') IS NOT NULL
        DROP TABLE [dimtables].[dbo].[dim_sales_person];

    CREATE TABLE [dimtables].[dbo].[dim_sales_person](
        [sales_person_id] INT IDENTITY(1,1) PRIMARY KEY,
        [sales_person_name] NVARCHAR(50) NOT NULL,
        [sales_person_department] NVARCHAR(50) NOT NULL
    );

    -- Insert DISTINCT records to avoid duplicates
    INSERT INTO [dimtables].[dbo].[dim_sales_person]
    ([sales_person_name], [sales_person_department])
    SELECT DISTINCT
        [sales_person_name],
        [sales_person_department]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [sales_person_name] IS NOT NULL
      AND [sales_person_department] IS NOT NULL;

    -- Return results
    SELECT * 
    FROM [dimtables].[dbo].[dim_sales_person];
END;


EXEC [dbo].[sp_load_dim_sales_person];

--CREATE PROCEDURE [dbo].[sp_load_dim_sales_person]
--AS
--BEGIN
    --SET NOCOUNT ON;

    --INSERT INTO [dimtables].[dbo].[dim_sales_person]
    --([Sales_Person_Name], [Sales_Person_Department])
    --SELECT DISTINCT
        --r.[Sales_Person_Name],
        --r.[Sales_Person_Department]
    --FROM [dimtables].[dbo].[raw_pc_data] r
    --WHERE NOT EXISTS (
        --SELECT 1
        --FROM [dimtables].[dbo].[dim_sales_person] d
        --WHERE d.[Sales_Person_Name] = r.[Sales_Person_Name]
          --AND d.[Sales_Person_Department] = r.[Sales_Person_Department]
    --);

    
    
    ---- dim payment
    --SELECT * 
    --FROM [dimtables].[dbo].[dim_sales_person];
--END;


--AS
--BEGIN
    --SET NOCOUNT ON;

    --INSERT INTO dimtables.dbo.dim_payment_id (Payment_Method)
    --SELECT DISTINCT r.Payment_Method
    --FROM dimtables.dbo.raw_pc_data r
    --WHERE NOT EXISTS (
        --SELECT 1
        --FROM dimtables.dbo.dim_payment_id d
        --WHERE d.Payment_Method = r.Payment_Method
    --);
--END;

----dim location 

--CREATE PROCEDURE dbo.sp_load_dim_location
--AS
--BEGIN
    --SET NOCOUNT ON;

    --INSERT INTO dimtables.dbo.dim_locations
    --(Continent, Country_or_State, Province_or_City)
    --SELECT DISTINCT
        --r.Continent,
        --r.Country_or_State,
        --r.Province_or_City
    --FROM dimtables.dbo.raw_pc_data r
    --WHERE NOT EXISTS (
        --SELECT 1
        --FROM dimtables.dbo.dim_locations d
        --WHERE d.Continent = r.Continent
         -- AND d.Country_or_State = r.Country_or_State
          --AND d.Province_or_City = r.Province_or_City
    --);
--END;


----dim product

--CREATE PROCEDURE dbo.sp_load_dim_product
--AS
--BEGIN
    --SET NOCOUNT ON;

    --INSERT INTO dimtables.dbo.dim_product
    --(Product_Name, Product_Category)
    --SELECT DISTINCT
        --r.Product_Name,
        --r.Product_Category
    --FROM dimtables.dbo.raw_pc_data r
    --WHERE NOT EXISTS (
        --SELECT 1
        --FROM dimtables.dbo.dim_product d
        --WHERE d.Product_Name = r.Product_Name
          --AND d.Product_Category = r.Product_Category
    --);
--END;