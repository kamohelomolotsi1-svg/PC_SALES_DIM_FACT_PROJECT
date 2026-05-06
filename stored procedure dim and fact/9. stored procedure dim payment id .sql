DROP PROCEDURE sp_load_dim_payment

CREATE PROCEDURE sp_load_dim_payment
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dimtables].[dbo].[dim_payment_id]
    ([payment_method])
    SELECT DISTINCT r.[payment_method]
    FROM [dimtables].[dbo].[raw_pc_data] r
    WHERE NOT EXISTS (
        SELECT 1
        FROM [dimtables].[dbo].[dim_payment_id] d
        WHERE d.payment_method = r.payment_method
    );
END;


EXEC sp_load_dim_payment;