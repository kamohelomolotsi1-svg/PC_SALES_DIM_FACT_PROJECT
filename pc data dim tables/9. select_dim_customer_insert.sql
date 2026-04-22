DROP TABLE [dimtables].[dbo].[dim_customer_details]
CREATE TABLE [dimtables].[dbo].[dim_customer_details](
        [Customer_ID] INT IDENTITY(1,1) PRIMARY KEY,
        [Customer_Name] NVARCHAR(50) NOT NULL,
        [Customer_Surname] NVARCHAR(50) NOT NULL,
        [Customer_Contact_Number] NVARCHAR(50) NOT NULL,
        [Customer_Email_Address] NVARCHAR(50) NOT NULL)

INSERT INTO [dimtables].[dbo].[dim_customer_details]
([Customer_Name], [Customer_Surname], [Customer_Contact_Number], [Customer_Email_Address])
SELECT DISTINCT [Customer_Name], [Customer_Surname], [Customer_Contact_Number], [Customer_Email_Address]
FROM [dimtables].[dbo].[raw_pc_data]

--SELECT * FROM [dimtables].[dbo].[dim_customer_details]

       --DROP TABLE [dimtables].[dbo].[pc_sales_fact]