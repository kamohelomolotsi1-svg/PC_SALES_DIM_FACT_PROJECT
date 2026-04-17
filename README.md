🖥️ PC Sales Data Warehouse (SQL Server)
📌 Project Overview

This project showcases the full process of building a data warehouse using SQL Server, starting from raw CSV data to a fully structured star schema.

The goal was to transform unstructured PC sales data into a clean, analytical model by creating dimension tables and a central fact table.

🛠️ Tools & Technologies
SQL Server (T-SQL)
CSV Dataset
GitHub (Version Control)
draw.io (Star Schema Design)

📂 Project Structure
/pc-sales-data-warehouse
│── sql/
│   ├── create_raw_table.sql
│   ├── dim_customer.sql
│   ├── dim_locations.sql
│   ├── dim_sales_person.sql
│   ├── dim_product.sql
│   ├── dim_priority.sql
│   ├── dim_date.sql
│   ├── dim_shop.sql
│   ├── dim_payment_id.sql
│   ├── dim_channel.sql
│   ├── fact_sales.sql
│── schema/
│   └── star_schema.drawio
│── README.md

⭐ Star Schema Design

Before writing any SQL, I designed a star schema diagram to define how the data would be structured.

Fact Table:
pc_sales_fact
Stores transactional sales data
Contains foreign keys linking to all dimension tables
Dimension Tables:
dim_locations
dim_payment_id
dim_customer
dim_product
dim_sales_person
dim_channel
dim_date
dim_priority

Each dimension table stores descriptive attributes, while the fact table stores measurable events.

ETL Process
1. Raw Data Creation

A raw staging table was created to hold the original dataset imported from a CSV file.

CREATE TABLE [dimtables].[dbo].[raw_pc_data](
    [Customer_ID] INT,
    [Continent] NVARCHAR(50),
    [Country_or_State] NVARCHAR(50),
    [Province_or_City] NVARCHAR(50),
    [Payment_Method] NVARCHAR(50),
    ...
);
2. Data Staging & Cleaning
Used SELECT DISTINCT to remove duplicates
Applied LTRIM() and RTRIM() to clean inconsistent values
Ensured standardized data before loading into dimension tables

2. Data Staging & Cleaning
Used SELECT DISTINCT to remove duplicates
Applied LTRIM() and RTRIM() to clean inconsistent values
Ensured standardized data before loading into dimension tables

Example:

SELECT DISTINCT
    LTRIM(RTRIM([Continent])) AS Continent
FROM [dimtables].[dbo].[raw_pc_data];
FROM [dimtables].[dbo].[raw_pc_data];


3. Dimension Tables
📍 Location Dimension
INSERT INTO [dimtables].[dbo].[dim_locations]
    ([Continent], [Country_or_State], [Province_or_City])
SELECT DISTINCT
    [Continent],
    [Country_or_State],
    [Province_or_City]
FROM [dimtables].[dbo].[raw_pc_data];
💳 Payment Dimension
INSERT INTO [dimtables].[dbo].[dim_payment_id]
    ([Payment_Method])
SELECT DISTINCT
    [Payment_Method]
FROM [dimtables].[dbo].[raw_pc_data];

Each dimension table:

Uses an IDENTITY column as a surrogate key
Stores unique values only
Eliminates redundancy from the raw dataset
4. Fact Table Creation

The fact table links all dimension tables together.

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
Each column represents a foreign key to a dimension table
Captures each sales transaction as a single row


Key Concepts Applied
Dimensional Modeling
Star Schema Design
ETL (Extract, Transform, Load)
Data Cleaning & Deduplication
Primary & Foreign Key Relationships
📈 Key Learnings
How to structure raw data into a data warehouse
Importance of removing duplicates before building dimensions
How fact tables connect multiple dimensions
Designing scalable data models for analytics

🚀 Future Improvements
Add constraints (FOREIGN KEYS) for referential integrity
Integrate with BI tools like Power BI or Looker Studio
Automate ETL process using pipelines
Add more advanced metrics (revenue, profit, etc.)

▶️ How to Run
Create the raw table
Load CSV data into raw_pc_data
Run dimension table scripts
Create and populate the fact table
