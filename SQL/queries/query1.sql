-- Calcula  el  listado  de  los  10  productos  con  menos  unidades  vendidas  (hint:  incluye 
-- productos sin ventas)  
SELECT
    p.product_id, 
    sum(coalesce(ol.product_qty, 0)) AS least_product_qty
FROM
    orderlines ol
    RIGHT JOIN products p ON ol.product_id = p.product_id 
GROUP BY
    p.product_id 
ORDER BY
    sum(coalesce(ol.product_qty, 0))
LIMIT
    10

-- Realiza un RIGHT JOIN entre las tablas orderlines (alias ol) y products (alias p) para obtener productos con y sin ordenes. 

-- Agrupa los resultados por el product_id de la tabla products.
-- Esto significa que la suma de las cantidades de productos se calcula para cada producto individualmente.

-- Ordena los resultados en función de la suma de las cantidades de productos, en orden ascendente.
-- Limita la cantidad de filas resultantes a 10.