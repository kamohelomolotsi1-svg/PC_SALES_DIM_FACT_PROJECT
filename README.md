🖥️ pc_sales_data_warehouse (sql_server)

📌 project_overview

this project demonstrates the end-to-end development of a data warehouse using sql server, transforming raw csv data into a structured star schema for analytics.

the goal was to clean, standardize, and model pc sales data into dimension tables and a centralized fact table, following real-world data engineering practices.

🛠️ tools_and_technologies
sql server (t-sql)
csv dataset
github (version control)
draw.io (data modeling / star schema design)
📂 project_structure
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

│
│   ├── stored_procedures/

│       ├── sp_load_dim_customer.sql

│       ├── sp_load_dim_locations.sql

│       ├── sp_load_dim_sales_person.sql

│       ├── sp_load_dim_product.sql

│       ├── sp_load_dim_priority.sql

│       ├── sp_load_dim_date.sql

│       ├── sp_load_dim_shop.sql

│       ├── sp_load_dim_payment_id.sql

│       ├── sp_load_dim_channel.sql

│       ├── sp_load_pc_sales_fact.sql

│
│── schema/

│   └── star_schema.png

│
│── README.md

⭐ star_schema_design

a star schema was designed before implementation to define relationships between fact and dimension tables.

🔹 fact_table

pc_sales_fact

stores transactional sales data
contains foreign keys linking to all dimension tables
🔹 dimension_tables
dim_customer
dim_locations
dim_product
dim_sales_person
dim_channel
dim_payment_id
dim_date
dim_priority
dim_shop

each dimension stores descriptive attributes, while the fact table captures measurable events.

⚙️ etl_process

1. raw_data_creation

a staging table was created to store the raw csv dataset:

CREATE TABLE dimtables.dbo.raw_pc_data(
    customer_id INT,
    continent NVARCHAR(50),
    country_or_state NVARCHAR(50),
    province_or_city NVARCHAR(50),
    payment_method NVARCHAR(50)
);


2. data_cleaning_and_transformation
removed duplicates using SELECT DISTINCT


3. dimension_table_loading

example: dim_payment_id

INSERT INTO dimtables.dbo.dim_payment_id (payment_method)
SELECT DISTINCT LTRIM(RTRIM(payment_method))
FROM dimtables.dbo.raw_pc_data;

each dimension table:

uses an identity surrogate key
stores unique values only
eliminates redundancy


4. fact_table_creation
CREATE TABLE dimtables.dbo.pc_sales_fact(
    sale_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    location_id INT,
    pc_product_id INT,
    channel_id INT,
    payment_id INT,
    sales_person_id INT,
    date_id INT,
    shop_id INT,
    priority_id INT
);
links all dimension tables
each row represents a transaction

⚙️ stored_procedures (etl_automation)

to make the pipeline reusable and production-ready, all dimension and fact table loads were converted into stored procedures.

🔁 etl_pattern_used

each stored procedure:

drops the table (full reload strategy)
recreates the structure
inserts cleaned, deduplicated data
ensures only valid records are loaded

📦 example_dimension_procedure

CREATE PROCEDURE dbo.sp_load_dim_payment_id
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('dimtables.dbo.dim_payment_id', 'U') IS NOT NULL
        DROP TABLE dimtables.dbo.dim_payment_id;

    CREATE TABLE dimtables.dbo.dim_payment_id(
        payment_id INT IDENTITY(1,1) PRIMARY KEY,
        payment_method NVARCHAR(50) NOT NULL
    );

    INSERT INTO dimtables.dbo.dim_payment_id (payment_method)
    SELECT DISTINCT LTRIM(RTRIM(payment_method))
    FROM dimtables.dbo.raw_pc_data
    WHERE payment_method IS NOT NULL;
END;


🧾 fact_table_procedure
CREATE PROCEDURE dbo.sp_load_pc_sales_fact
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('dimtables.dbo.pc_sales_fact', 'U') IS NOT NULL
        DROP TABLE dimtables.dbo.pc_sales_fact;

    CREATE TABLE dimtables.dbo.pc_sales_fact(
        sale_id INT IDENTITY(1,1) PRIMARY KEY,
        customer_id INT,
        location_id INT,
        pc_product_id INT,
        channel_id INT,
        payment_id INT,
        sales_person_id INT,
        date_id INT,
        shop_id INT,
        priority_id INT,
        cost_price INT NOT NULL,
        sale_price INT NOT NULL,
        discount_amount INT NOT NULL,
        finance_amount NVARCHAR(50) NOT NULL,
        credit_score INT NOT NULL,
        total_sales_per_employee INT NOT NULL,
        pc_market_price INT NOT NULL
    );

    INSERT INTO dimtables.dbo.pc_sales_fact
    (cost_price, sale_price, discount_amount, finance_amount,
     credit_score, total_sales_per_employee, pc_market_price)
    SELECT DISTINCT
        cost_price,
        sale_price,
        discount_amount,
        finance_amount,
        credit_score,
        total_sales_per_employee,
        pc_market_price
    FROM dimtables.dbo.raw_pc_data
    WHERE cost_price IS NOT NULL
      AND sale_price IS NOT NULL
      AND discount_amount IS NOT NULL
      AND finance_amount IS NOT NULL
      AND credit_score IS NOT NULL
      AND total_sales_per_employee IS NOT NULL
      AND pc_market_price IS NOT NULL;
END;

📁 available_procedures

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
🧠 data_engineering_approach

this project follows a layered architecture:

staging layer → raw csv data
transformation layer → cleaning & deduplication
presentation layer → star schema

stored procedures ensure the pipeline is:

repeatable
maintainable
scalable

📈 key_learnings

designing a star schema from raw data
building dimension and fact tables
data cleaning and deduplication techniques
implementing etl pipelines using stored procedures
structuring projects like real-world data warehouses

🚀 future_improvements

add foreign key constraints for referential integrity
integrate with power bi or looker studio
automate etl using pipelines (e.g., azure data factory)
add advanced metrics (profit, revenue trends)

