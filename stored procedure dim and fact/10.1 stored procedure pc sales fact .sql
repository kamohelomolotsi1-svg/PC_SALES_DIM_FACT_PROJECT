DROP PROCEDURE [dbo].[sp_load_pc_sales_fact]

CREATE PROCEDURE [dbo].[sp_load_pc_sales_fact]
AS
BEGIN
    SET NOCOUNT ON;

    -- Drop table if exists (full reload)
    IF OBJECT_ID('[dimtables].[dbo].[pc_sales_fact]', 'U') IS NOT NULL
        TRUNCATE TABLE [dimtables].[dbo].[pc_sales_fact];

     
        INSERT INTO [dimtables].[dbo].[pc_sales_fact]
        (
            [customer_id],
            [location_id],
            [pc_product_id],
            [channel_id],
            [payment_id],
            [sales_person_id],
            [date_id],
            [shop_id],
            [priority_id],
            [cost_price],
            [sale_price],
            [discount_amount],
            [finance_amount],
            [credit_score],
            [total_sales_per_employee],
            [pc_market_price]
        )

        SELECT  
            ISNULL(J.customer_id, -1),
            ISNULL(D.location_id, -1),
            ISNULL(B.pc_product_id, -1),
            ISNULL(I.channel_id, -1),
            ISNULL(E.payment_id, -1),
            ISNULL(C.sales_person_id, -1),
            ISNULL(H.date_id, -1),
            ISNULL(F.shop_id, -1),
            ISNULL(G.priority_id, -1),

            A.cost_price,
            A.sale_price,
            A.discount_amount,
            A.finance_amount,
            A.credit_score,
            A.total_sales_per_employee,
            A.pc_market_price

        FROM [dimtables].[dbo].[raw_pc_data] A 

        LEFT JOIN (
            SELECT pc_make, MIN(pc_product_id) AS pc_product_id
            FROM [dimtables].[dbo].[dim_pc_product]
            GROUP BY pc_make
        ) B ON A.pc_make = B.pc_make

        LEFT JOIN (
            SELECT sales_person_department, MIN(sales_person_id) AS sales_person_id
            FROM [dimtables].[dbo].[dim_sales_person]
            GROUP BY sales_person_department
        ) C ON A.sales_person_department = C.sales_person_department

        LEFT JOIN (
            SELECT continent, MIN(location_id) AS location_id
            FROM [dimtables].[dbo].[dim_locations]
            GROUP BY continent
        ) D ON A.continent = D.continent

        LEFT JOIN (
            SELECT payment_method, MIN(payment_id) AS payment_id
            FROM [dimtables].[dbo].[dim_payment_id]
            GROUP BY payment_method
        ) E ON A.payment_method = E.payment_method

        LEFT JOIN (
            SELECT shop_name, MIN(shop_id) AS shop_id
            FROM [dimtables].[dbo].[dim_shop]
            GROUP BY shop_name
        ) F ON A.shop_name = F.shop_name

        LEFT JOIN (
            SELECT priority, MIN(priority_id) AS priority_id
            FROM [dimtables].[dbo].[dim_priority]
            GROUP BY priority
        ) G ON A.priority = G.priority

        LEFT JOIN (
        SELECT full_date, MIN(date_id) AS date_id
        FROM [dimtables].[dbo].[dim_date2]
        GROUP BY full_date
        ) H
        ON TRY_CONVERT(DATE, A.purchase_date) = H.full_date

        LEFT JOIN (
            SELECT channel, MIN(channel_id) AS channel_id
            FROM [dimtables].[dbo].[dim_channel]
            GROUP BY channel
        ) I ON A.channel = I.channel

        LEFT JOIN (
            SELECT customer_name, MIN(customer_id) AS customer_id
            FROM [dimtables].[dbo].[dim_customer_details]
            GROUP BY customer_name
        ) J ON A.customer_name = J.customer_name;


            SELECT * FROM [dimtables].[dbo].[pc_sales_fact];
END;




EXEC [dbo].[sp_load_pc_sales_fact];

 