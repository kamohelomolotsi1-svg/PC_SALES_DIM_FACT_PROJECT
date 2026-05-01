ALTER TABLE [dimtables].[dbo].[pc_sales_fact]
ADD CONSTRAINT fk_Customer_ID
FOREIGN KEY (Customer_ID)
REFERENCES [dimtables].[dbo].[dim_customer_details](Customer_ID);

ALTER TABLE [dimtables].[dbo].[pc_sales_fact]
ADD CONSTRAINT fk_Location_ID
FOREIGN KEY (Location_ID)
REFERENCES [dimtables].[dbo].[dim_locations](Location_ID);

ALTER TABLE [dimtables].[dbo].[pc_sales_fact]
ADD CONSTRAINT fk_PC_Product_ID
FOREIGN KEY (PC_Product_ID)
REFERENCES [dimtables].[dbo].[dim_pc_product](PC_Product_ID);

ALTER TABLE [dimtables].[dbo].[pc_sales_fact]
ADD CONSTRAINT fk_Channel_ID
FOREIGN KEY (Channel_ID)
REFERENCES [dimtables].[dbo].[dim_channel](Channel_ID);

ALTER TABLE [dimtables].[dbo].[pc_sales_fact]
ADD CONSTRAINT fk_Payment_ID
FOREIGN KEY (Payment_ID)
REFERENCES [dimtables].[dbo].[dim_payment_id](Payment_ID);

ALTER TABLE [dimtables].[dbo].[pc_sales_fact]
ADD CONSTRAINT fk_Sales_Person_ID
FOREIGN KEY (Sales_Person_ID)
REFERENCES [dimtables].[dbo].[dim_sales_person](Sales_Person_ID);

ALTER TABLE [dimtables].[dbo].[pc_sales_fact]
DROP CONSTRAINT fk_Date_ID;

ALTER TABLE [dimtables].[dbo].[pc_sales_fact]
ADD CONSTRAINT fk_Date_ID
FOREIGN KEY (Date_ID)
REFERENCES [dimtables].[dbo].[dim_date2](Date_ID);
----

SET IDENTITY_INSERT [dimtables].[dbo].[dim_date] ON;

INSERT INTO [dimtables].[dbo].[dim_date] (Date_ID, purchase_date)
VALUES (-1, 'Unknown');

SET IDENTITY_INSERT [dimtables].[dbo].[dim_date] OFF;

SELECT * FROM [dimtables].[dbo].[dim_date]
----

ALTER TABLE [dimtables].[dbo].[pc_sales_fact]
ADD CONSTRAINT fk_Shop_ID
FOREIGN KEY (Shop_ID)
REFERENCES [dimtables].[dbo].[dim_shop](Shop_ID);

ALTER TABLE [dimtables].[dbo].[pc_sales_fact]
ADD CONSTRAINT fk_Priority_ID
FOREIGN KEY (Priority_ID)
REFERENCES [dimtables].[dbo].[dim_priority](Priority_ID);


SELECT * FROM [dimtables].[dbo].[pc_sales_fact]

TRUNCATE 

