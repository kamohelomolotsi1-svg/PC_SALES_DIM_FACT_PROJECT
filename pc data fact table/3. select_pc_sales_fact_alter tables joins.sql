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
    -- Dimension Keys (foreign keys)
    ISNULL(J.customer_id, -1)        AS customer_id,
    ISNULL(D.location_id, -1)        AS location_id,
    ISNULL(B.pc_product_id, -1)      AS pc_product_id,
    ISNULL(I.channel_id, -1)         AS channel_id,
    ISNULL(E.payment_id, -1)         AS payment_id,
    ISNULL(C.sales_person_id, -1)    AS sales_person_id,
    ISNULL(H.date_id, -1)            AS date_id,
    ISNULL(F.shop_id, -1)            AS shop_id,
    ISNULL(G.priority_id, -1)        AS priority_id,

    -- Measures
    A.cost_price,
    A.sale_price,
    A.discount_amount,
    A.finance_amount,
    A.credit_score,
    A.total_sales_per_employee,
    A.pc_market_price

FROM [dimtables].[dbo].[raw_pc_data] A

-- Product
LEFT JOIN [dimtables].[dbo].[dim_pc_product] B
ON UPPER(TRIM(A.pc_make)) = UPPER(TRIM(B.pc_make))

-- Sales Person
LEFT JOIN [dimtables].[dbo].[dim_sales_person] C
ON UPPER(TRIM(A.sales_person_department)) = UPPER(TRIM(C.sales_person_department))

-- Location
LEFT JOIN [dimtables].[dbo].[dim_locations] D
ON UPPER(TRIM(A.continent)) = UPPER(TRIM(D.continent))

-- Payment
LEFT JOIN [dimtables].[dbo].[dim_payment_id] E
ON UPPER(TRIM(A.payment_method)) = UPPER(TRIM(E.payment_method))

-- Shop
LEFT JOIN [dimtables].[dbo].[dim_shop] F
ON UPPER(TRIM(A.shop_name)) = UPPER(TRIM(F.shop_name))

-- Priority
LEFT JOIN [dimtables].[dbo].[dim_priority] G
ON UPPER(TRIM(A.priority)) = UPPER(TRIM(G.priority))

-- Date
LEFT JOIN [dimtables].[dbo].[dim_date] H
ON TRY_CONVERT(DATE, A.purchase_date) = H.purchase_date

-- Channel
LEFT JOIN [dimtables].[dbo].[dim_channel] I
ON UPPER(TRIM(A.channel)) = UPPER(TRIM(I.channel))

-- Customer
LEFT JOIN [dimtables].[dbo].[dim_customer_details] J
ON UPPER(TRIM(A.customer_name)) = UPPER(TRIM(J.customer_name));