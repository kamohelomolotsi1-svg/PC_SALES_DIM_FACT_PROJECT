CREATE PROCEDURE sp_load_dim_shop
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dimtables].[dbo].[dim_shop]
    ([shop_name], [shop_age])
    SELECT DISTINCT
        r.[shop_name],
        r.[shop_age]
    FROM [dimtables].[dbo].[raw_pc_data] r
    WHERE NOT EXISTS (
        SELECT 1
        FROM [dimtables].[dbo].[dim_shop] d
        WHERE d.shop_name = r.shop_name
          AND d.shop_age = r.shop_age
    );
END;

EXEC sp_load_dim_shop;