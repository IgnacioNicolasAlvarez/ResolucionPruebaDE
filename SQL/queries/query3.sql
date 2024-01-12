-- Calcula la recency de compra (días desde la última compra) para todos los clientes con 
-- compra

SELECT
    customer_id,
    EXTRACT(
        DAY
        FROM
            (CURRENT_DATE - order_ts)
    ) :: INT AS days_diff
FROM
    (
        SELECT
            c.customer_id,
            ol.order_ts,
            ROW_NUMBER() OVER (
                PARTITION BY c.customer_id
                ORDER BY
                    ol.order_ts DESC
            ) AS row_num
        FROM
            orderlines ol
            INNER JOIN customers c ON ol.customer_id = c.customer_id
    ) subquery
WHERE
    row_num = 1;