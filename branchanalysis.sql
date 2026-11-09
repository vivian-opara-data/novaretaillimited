USE NovaRetail;
GO
SELECT
    b.branch_name,
    b.state,
    COUNT(*) AS delivered_orders,
    SUM(o.quantity) AS units_sold,

    SUM(o.quantity * o.unit_price) AS gross_sales,

    SUM(o.quantity * o.unit_price * o.discount_pct)
        AS total_discount,

    SUM(o.quantity * o.unit_price * (1 - o.discount_pct))
        AS net_revenue,

    SUM(o.quantity * o.unit_cost)
        AS cost_of_goods_sold,

    SUM(
        o.quantity * o.unit_price * (1 - o.discount_pct)
        - o.quantity * o.unit_cost
    ) AS gross_profit,

    ROUND(
        100.0 * SUM(
            o.quantity * o.unit_price * (1 - o.discount_pct)
            - o.quantity * o.unit_cost
        )
        / NULLIF(
            SUM(o.quantity * o.unit_price * (1 - o.discount_pct)),
            0
        ),
        2
    ) AS gross_profit_margin_pct

FROM dbo.nrorderscsv AS o

INNER JOIN dbo.nrbranchescsv AS b
    ON o.branch_id = b.branch_id

WHERE o.order_status = 'Delivered'

GROUP BY
    b.branch_name,
    b.state

ORDER BY gross_profit DESC;