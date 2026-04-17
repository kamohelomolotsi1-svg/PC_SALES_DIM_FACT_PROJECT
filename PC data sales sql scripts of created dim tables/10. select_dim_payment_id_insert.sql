DROP TABLE [dimtables].[dbo].[dim_payment_id]
CREATE TABLE [dbo].[dim_payment_id](
    [Payment_ID] INT IDENTITY(1, 1) PRIMARY KEY,
	[Payment_Method] [nvarchar](50) NOT NULL
)



SELECT DISTINCT [Payment_ID], [Payment_Method]
  FROM [dimtables].[dbo].[dim_payment_id]

  INSERT INTO [dimtables].[dbo].[dim_payment_id]
  ([Payment_Method])
  SELECT [Payment_Method]
  FROM [dimtables].[dbo].[raw_pc_data]