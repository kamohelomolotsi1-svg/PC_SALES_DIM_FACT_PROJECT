DROP PROCEDURE sp_load_dim_locations

CREATE PROCEDURE sp_load_dim_locations
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dimtables].[dbo].[dim_locations]
    ([continent], [country_or_state], [province_or_city])
    SELECT DISTINCT
        r.[continent],
        r.[country_or_state],
        r.[province_or_city]
    FROM [dimtables].[dbo].[raw_pc_data] r
    WHERE NOT EXISTS (
        SELECT 1
        FROM [dimtables].[dbo].[dim_locations] d
        WHERE d.continent = r.continent
          AND d.country_or_state = r.country_or_state
          AND d.province_or_city = r.province_or_city
    );
END;

EXEC sp_load_dim_locations;