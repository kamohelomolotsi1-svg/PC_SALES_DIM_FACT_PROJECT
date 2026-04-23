DROP TABLE [dimtables].[dbo].[dim_payment_id]
CREATE TABLE [dbo].[dim_payment_id](
    [payment_id] INT IDENTITY(1, 1) PRIMARY KEY,
	[payment_method] [nvarchar](50) NOT NULL
)


  INSERT INTO [dimtables].[dbo].[dim_payment_id]
  ([payment_method])
  SELECT [payment_method]
  FROM [dimtables].[dbo].[raw_pc_data]

  --

  SELECT DISTINCT [payment_id], [payment_method]
  FROM [dimtables].[dbo].[dim_payment_id]