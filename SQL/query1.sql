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