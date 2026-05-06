---- Create Master Procedure
DROP PROCEDURE dbo.sp_run_pc_sales_pipeline

CREATE PROCEDURE dbo.sp_run_pc_sales_pipeline
AS
BEGIN
    SET NOCOUNT ON;

    PRINT 'Starting PC Sales ETL Pipeline...';

    -- DIMENSIONS FIRST
    EXEC sp_load_dim_channel;
    EXEC sp_load_dim_customer;
    EXEC sp_load_dim_pc_product;
    EXEC sp_load_dim_sales_person;
    EXEC sp_load_dim_locations;
    EXEC sp_load_dim_payment;
    EXEC sp_load_dim_shop;
    EXEC sp_load_dim_priority;
    EXEC sp_load_dim_date;

    PRINT 'All dimension tables loaded successfully';

    -- FACT TABLE LAST
    EXEC dbo.sp_load_pc_sales_fact;

    PRINT 'Fact table loaded successfully';

    PRINT 'Pipeline completed';
END;


---- PC SALES PIPELINE FACT STORED PROCEDURE
EXEC dbo.sp_run_pc_sales_pipeline;







