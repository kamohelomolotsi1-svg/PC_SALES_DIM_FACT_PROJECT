DROP TABLE [dimtables].[dbo].[dim_customer_details]
CREATE TABLE [dimtables].[dbo].[dim_customer_details](
        [customer_id] INT IDENTITY(1,1) PRIMARY KEY,
        [customer_name] NVARCHAR(50) NOT NULL,
        [customer_surname] NVARCHAR(50) NOT NULL,
        [customer_contact_number] NVARCHAR(50) NOT NULL,
        [customer_email_address] NVARCHAR(50) NOT NULL)

INSERT INTO [dimtables].[dbo].[dim_customer_details]
([customer_name], [customer_surname], [customer_contact_number], [customer_email_address])
SELECT DISTINCT [customer_name], [customer_surname], [customer_contact_number], [customer_email_address]
FROM [dimtables].[dbo].[raw_pc_data]

SELECT * FROM [dimtables].[dbo].[dim_customer_details]

       --DROP TABLE [dimtables].[dbo].[pc_sales_fact]