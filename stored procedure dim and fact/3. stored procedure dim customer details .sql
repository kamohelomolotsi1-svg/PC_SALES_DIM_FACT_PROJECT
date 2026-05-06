CREATE PROCEDURE sp_load_dim_customer
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dimtables].[dbo].[dim_customer_details]
    ([customer_name], [customer_surname], [customer_contact_number], [customer_email_address])
    SELECT DISTINCT
        r.[customer_name],
        r.[customer_surname],
        r.[customer_contact_number],
        r.[customer_email_address]
    FROM [dimtables].[dbo].[raw_pc_data] r
    WHERE NOT EXISTS (
        SELECT 1
        FROM [dimtables].[dbo].[dim_customer_details] d
        WHERE d.customer_name = r.customer_name
          AND d.customer_surname = r.customer_surname
          AND d.customer_contact_number = r.customer_contact_number
          AND d.customer_email_address = r.customer_email_address
    );
END;



EXEC sp_load_dim_customer;