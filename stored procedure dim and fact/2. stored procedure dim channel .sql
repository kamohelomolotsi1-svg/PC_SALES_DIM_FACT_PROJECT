DROP PROCEDURE sp_load_dim_channel

CREATE PROCEDURE sp_load_dim_channel
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dimtables].[dbo].[dim_channel]
    ([channel])
    SELECT DISTINCT r.[channel]
    FROM [dimtables].[dbo].[raw_pc_data] r
    WHERE NOT EXISTS (
        SELECT 1
        FROM [dimtables].[dbo].[dim_channel] d
        WHERE d.channel = r.channel
    );
END;


EXEC sp_load_dim_channel;