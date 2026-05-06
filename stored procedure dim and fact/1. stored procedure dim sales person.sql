CREATE PROCEDURE sp_load_dim_sales_person
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dimtables].[dbo].[dim_sales_person]
    ([sales_person_name], [sales_person_department])
    SELECT DISTINCT
        r.[sales_person_name],
        r.[sales_person_Department]
    FROM [dimtables].[dbo].[raw_pc_data] r
    WHERE NOT EXISTS (
        SELECT 1
        FROM [dimtables].[dbo].[dim_sales_person] d
        WHERE d.sales_person_name = r.sales_person_name
          AND d.sales_person_department = r.sales_person_Department
    );
END;

EXEC sp_load_dim_sales_person;