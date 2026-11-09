SELECT
    COUNT(*) AS total_delivered_orders,
    SUM(quantity) AS total_units_sold,
    SUM(quantity * unit_price * (1 - discount_pct))
        AS total_net_revenue,
    SUM(quantity * unit_cost)
        AS total_cost_of_goods_sold,
    SUM(
        quantity * unit_price * (1 - discount_pct)
        - quantity * unit_cost
    ) AS total_gross_profit
FROM dbo.nrorderscsv
WHERE order_status = 'Delivered';

SELECT
    p.product_id,
    p.product_name,
    p.category,
    COUNT(o.order_id) AS delivered_orders,
    COALESCE(SUM(o.quantity), 0) AS units_sold,
    COALESCE(
        SUM(o.quantity * o.unit_price * (1 - o.discount_pct)),
        0
    ) AS net_revenue,
    COALESCE(
        SUM(
            o.quantity * o.unit_price * (1 - o.discount_pct)
            - o.quantity * o.unit_cost
        ),
        0
    ) AS gross_profit
FROM dbo.nrproductscsv AS p
LEFT JOIN dbo.nrorderscsv AS o
    ON p.product_id = o.product_id
    AND o.order_status = 'Delivered'
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY net_revenue DESC;