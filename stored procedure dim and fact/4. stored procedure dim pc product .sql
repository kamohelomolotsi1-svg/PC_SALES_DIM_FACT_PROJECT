DROP PROCEDURE sp_load_dim_pc_product

CREATE PROCEDURE sp_load_dim_pc_product
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dimtables].[dbo].[dim_pc_product] 
    (
        [pc_make], 
        [pc_model], 
        [storage_type], 
        [ram], 
        [storage_capacity]
    )
    SELECT DISTINCT
        r.[pc_make],
        r.[pc_model],
        r.[storage_type],
        r.[ram],
        r.[storage_capacity]
    FROM [dimtables].[dbo].[raw_pc_data] r
    WHERE NOT EXISTS (
        SELECT 1 
        FROM [dimtables].[dbo].[dim_pc_product] d
        WHERE d.pc_make = r.pc_make
          AND d.pc_model = r.pc_model
          AND d.storage_type = r.storage_type
          AND d.ram = r.ram
          AND d.storage_capacity = r.storage_capacity
    );
END;

EXEC sp_load_dim_pc_product;