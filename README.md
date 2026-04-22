# 🖥️ PC Sales Data Warehouse (SQL Server)

## 📌 Project Overview

This project demonstrates the end-to-end development of a data warehouse using SQL Server, transforming raw CSV data into a structured **star schema** for analytics.

The goal was to clean, standardize, and model PC sales data into dimension tables and a centralized fact table, following real-world data engineering practices.

---

## 🛠️ Tools & Technologies

- SQL Server (T-SQL)
- CSV Dataset
- GitHub (Version Control)
- draw.io (Data Modeling / Star Schema Design)

---

## 📂 Project Structure

/pc-sales-data-warehouse
│── sql/
│ ├── create_raw_table.sql
│ ├── dim_customer.sql
│ ├── dim_locations.sql
│ ├── dim_sales_person.sql
│ ├── dim_product.sql
│ ├── dim_priority.sql
│ ├── dim_date.sql
│ ├── dim_shop.sql
│ ├── dim_payment_id.sql
│ ├── dim_channel.sql
│ ├── fact_sales.sql
│ ├── stored_procedures/
│ ├── sp_load_dim_customer.sql
│ ├── sp_load_dim_locations.sql
│ ├── sp_load_dim_sales_person.sql
│ ├── sp_load_dim_product.sql
│ ├── sp_load_dim_priority.sql
│ ├── sp_load_dim_date.sql
│ ├── sp_load_dim_shop.sql
│ ├── sp_load_dim_payment_id.sql
│ ├── sp_load_dim_channel.sql
│ ├── sp_load_pc_sales_fact.sql
│
│── schema/
│ └── star_schema.png
│
│── README.md

---

## ⭐ Star Schema Design

A star schema was designed before implementation to define relationships between fact and dimension tables.

![Star Schema](schema/star_schema.png)

### 🔹 Fact Table
- `pc_sales_fact`
- Stores transactional sales data
- Contains foreign keys linking to all dimension tables

### 🔹 Dimension Tables
- dim_customer  
- dim_locations  
- dim_product  
- dim_sales_person  
- dim_channel  
- dim_payment_id  
- dim_date  
- dim_priority  
- dim_shop  

Each dimension stores descriptive attributes, while the fact table captures measurable events.

---

## ⚙️ ETL Process

### 1. Raw Data Creation

A staging table was created to store the raw CSV dataset:

```sql
CREATE TABLE [dimtables].[dbo].[raw_pc_data](
    [Customer_ID] INT,
    [Continent] NVARCHAR(50),
    [Country_or_State] NVARCHAR(50),
    [Province_or_City] NVARCHAR(50),
    [Payment_Method] NVARCHAR(50),
    ...
);

2. Data Cleaning & Transformation
Removed duplicates using SELECT DISTINCT

3. Dimension Table Loading

Example: Payment Dimension

INSERT INTO [dimtables].[dbo].[dim_payment_id] ([Payment_Method])
SELECT DISTINCT LTRIM(RTRIM([Payment_Method]))
FROM [dimtables].[dbo].[raw_pc_data];

Each dimension table:

Uses an IDENTITY surrogate key
Stores unique values only
Eliminates redundancy

4. Fact Table Creation
CREATE TABLE [dimtables].[dbo].[pc_sales_fact](
    [Sale_ID] INT IDENTITY(1,1) PRIMARY KEY,
    [Customer_ID] INT,
    [Location_ID] INT,
    [PC_Product_ID] INT,
    [Channel_ID] INT,
    [Payment_ID] INT,
    [Sales_Person_ID] INT,
    [Date_ID] INT,
    [Shop_ID] INT,
    [Priority_ID] INT
);
Links all dimension tables
Each row represents a transaction

⚙️ Stored Procedures (ETL Automation)

To make the pipeline reusable and production-ready, all dimension and fact table loads were converted into stored procedures.

🔁 ETL Pattern Used

Each stored procedure:

Drops the table (full reload strategy)
Recreates the structure
Inserts cleaned, deduplicated data
Ensures only valid records are loaded

📦 Example: Dimension Procedure
CREATE PROCEDURE [dbo].[sp_load_dim_payment_id]
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('[dimtables].[dbo].[dim_payment_id]', 'U') IS NOT NULL
        DROP TABLE [dimtables].[dbo].[dim_payment_id];

    CREATE TABLE [dimtables].[dbo].[dim_payment_id](
        [Payment_ID] INT IDENTITY(1,1) PRIMARY KEY,
        [Payment_Method] NVARCHAR(50) NOT NULL
    );

    INSERT INTO [dimtables].[dbo].[dim_payment_id] ([Payment_Method])
    SELECT DISTINCT LTRIM(RTRIM([Payment_Method]))
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [Payment_Method] IS NOT NULL;
END;

🧾 Fact Table Procedure
CREATE PROCEDURE [dbo].[sp_load_pc_sales_fact]
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('[dimtables].[dbo].[pc_sales_fact]', 'U') IS NOT NULL
        DROP TABLE [dimtables].[dbo].[pc_sales_fact];

    CREATE TABLE [dimtables].[dbo].[pc_sales_fact](
        [Sale_ID] INT IDENTITY(1, 1) PRIMARY KEY,
        [Customer_ID] INT,
        [Location_ID] INT,
        [PC_Product_ID] INT,
        [Channel_ID] INT,
        [Payment_ID] INT,
        [Sales_Person_ID] INT,
        [Date_ID] INT,
        [Shop_ID] INT,
        [Priority_ID] INT,
        [Cost_Price] INT NOT NULL,
        [Sale_Price] INT NOT NULL,
        [Discount_Amount] INT NOT NULL,
        [Finance_Amount] NVARCHAR(50) NOT NULL,
        [Credit_Score] INT NOT NULL,
        [Total_Sales_per_Employee] INT NOT NULL,
        [PC_Market_Price] INT NOT NULL
    );

    INSERT INTO [dimtables].[dbo].[pc_sales_fact]
    ([Cost_Price], [Sale_Price], [Discount_Amount], [Finance_Amount],
     [Credit_Score], [Total_Sales_per_Employee], [PC_Market_Price])
    SELECT DISTINCT
        [Cost_Price],
        [Sale_Price],
        [Discount_Amount],
        [Finance_Amount],
        [Credit_Score],
        [Total_Sales_per_Employee],
        [PC_Market_Price]
    FROM [dimtables].[dbo].[raw_pc_data]
    WHERE [Cost_Price] IS NOT NULL
      AND [Sale_Price] IS NOT NULL
      AND [Discount_Amount] IS NOT NULL
      AND [Finance_Amount] IS NOT NULL
      AND [Credit_Score] IS NOT NULL
      AND [Total_Sales_per_Employee] IS NOT NULL
      AND [PC_Market_Price] IS NOT NULL;
END;

📁 Available Procedures
sp_load_dim_customer
sp_load_dim_locations
sp_load_dim_sales_person
sp_load_dim_product
sp_load_dim_priority
sp_load_dim_date
sp_load_dim_shop
sp_load_dim_payment_id
sp_load_dim_channel
sp_load_pc_sales_fact
🧠 Data Engineering Approach

This project follows a layered architecture:

Staging Layer – Raw CSV data
Transformation Layer – Cleaning & deduplication
Presentation Layer – Star schema

Stored procedures ensure the pipeline is:

Repeatable
Maintainable
Scalable


📈 Key Learnings
Designing a star schema from raw data
Building dimension and fact tables
Data cleaning and deduplication techniques
Implementing ETL pipelines using stored procedures
Structuring projects like real-world data warehouses


🚀 Future Improvements
Add FOREIGN KEY constraints for referential integrity
Integrate with Power BI or Looker Studio
Automate ETL using pipelines (e.g., Azure Data Factory)
Add advanced metrics (profit, revenue trends)

