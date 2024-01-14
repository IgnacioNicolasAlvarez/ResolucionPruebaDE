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

-- La subconsulta interna utiliza la función ROW_NUMBER() para asignar un número de fila a cada compra de cada cliente. Se ordena por la fecha de la orden en orden descendente, de modo que la compra más reciente tenga el número de fila 1.

-- La subconsulta se utiliza externamente para seleccionar el customer_id y calcular la recencia de compra (days_diff).

-- La cláusula WHERE row_num = 1 filtra solo las filas correspondientes a la última compra de cada cliente.