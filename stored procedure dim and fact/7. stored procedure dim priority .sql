CREATE PROCEDURE sp_load_dim_priority
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dimtables].[dbo].[dim_priority]
    ([priority])
    SELECT DISTINCT r.[priority]
    FROM [dimtables].[dbo].[raw_pc_data] r
    WHERE NOT EXISTS (
        SELECT 1
        FROM [dimtables].[dbo].[dim_priority] d
        WHERE d.priority = r.priority
    );
END;


EXEC sp_load_dim_priority;