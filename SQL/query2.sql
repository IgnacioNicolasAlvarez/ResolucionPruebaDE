-- Calcula un listado de clientes que tienen cesta media (facturación divida en número 
-- de pedidos) inferior a la cesta media de su género. 

WITH partial_cesta_by_gender AS (
    SELECT
        c.gender,
        (
            SUM(ol.product_qty * ol.product_price) / COUNT(ol.order_id)
        ) AS cesta
    FROM
        orderlines ol
        INNER JOIN customers c ON ol.customer_id = c.customer_id
    GROUP BY
        c.gender
),
partial_cesta_by_id AS (
    SELECT
        c.customer_id,
        c.gender,
        (
            SUM(ol.product_qty * ol.product_price) / COUNT(ol.order_id)
        ) AS cesta
    FROM
        orderlines ol
        INNER JOIN customers c ON ol.customer_id = c.customer_id
    GROUP BY
        c.customer_id,
        c.gender
)

SELECT
    pci.customer_id,
    AVG(pci.cesta),
    AVG(o.cesta)
FROM
    partial_cesta_by_id pci
    INNER JOIN partial_cesta_by_gender o ON pci.gender = o.gender
GROUP BY
    pci.customer_id
HAVING
    (AVG(pci.cesta)) < (AVG(o.cesta))
ORDER BY
    pci.customer_id;