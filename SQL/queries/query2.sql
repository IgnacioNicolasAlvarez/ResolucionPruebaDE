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


-- La cláusula WITH define dos tablas temporales (partial_cesta_by_gender y partial_cesta_by_id) que calculan el gasto promedio de cesta de compra, diferenciando por género y por cliente respectivamente.

-- En la consulta principal, se realiza un INNER JOIN entre estas dos tablas temporales utilizando la condición de igualdad en el género.

-- La cláusula HAVING filtra los resultados, mostrando solo aquellos casos donde el gasto promedio de cesta por cliente es menor que el gasto promedio por género.

-- Finalmente, los resultados se ordenan por cliente