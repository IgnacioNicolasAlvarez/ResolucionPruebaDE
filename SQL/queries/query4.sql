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


-- La subconsulta interna calcula la facturación total para cada producto mediante la suma de la cantidad de productos multiplicada por el precio de cada producto.

-- La subconsulta interna se utiliza en la tabla temporal product_tiers, donde se aplica la función NTILE para asignar cada producto a uno de los tres niveles (tiers) basándose en su facturación total. ORDER BY total_revenue DESC garantiza que los productos con la mayor facturación estarán en el tier más alto.