DROP TABLE [dimtables].[dbo].[dim_customer_details]
CREATE TABLE [dimtables].[dbo].[dim_customer_details](
[Customer_ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[Customer_Name] [nvarchar](50) NOT NULL,
	[Customer_Surname] [nvarchar](50) NOT NULL,
	[Customer_Contact_Number] [nvarchar](50) NOT NULL,
	[Customer_Email_Address] [nvarchar](50) NOT NULL
) ON [PRIMARY]

SELECT DISTINCT * FROM [dimtables].[dbo].[dim_customer_details]
SELECT [Customer_Name]
      ,[Customer_Surname]
      ,[Customer_Contact_Number]
      ,[Customer_Email_Address]
--INTO [dimtables].[dbo].[dim_customer_details]
FROM [dimtables].[dbo].[raw_pc_data]

INSERT INTO [dimtables].[dbo].[dim_customer_details]
([Customer_Name], [Customer_Surname], [Customer_Contact_Number], [Customer_Email_Address])
SELECT [Customer_Name], [Customer_Surname], [Customer_Contact_Number], [Customer_Email_Address]
FROM [dimtables].[dbo].[raw_pc_data]


