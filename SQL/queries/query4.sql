-- Usa la función ntile para asignar los productos a 3 tiers donde el tier más alto incluye 
-- los productos con mayor facturación. 

WITH product_tiers AS (
    SELECT
        product_id,
        NTILE(3) OVER (
            ORDER BY
                total_revenue DESC
        ) AS tier
    FROM
        (
            SELECT
                p.product_id,
                SUM(ol.product_qty * ol.product_price) AS total_revenue
            FROM
                products p
                INNER JOIN orderlines ol ON p.product_id = ol.product_id
            GROUP BY
                p.product_id
        ) subquery
)
SELECT
    product_id,
    tier
FROM
    product_tiers;