-- Calcula  el  listado  de  los  10  productos  con  menos  unidades  vendidas  (hint:  incluye 
-- productos sin ventas)  
SELECT
    p.id,
    p.nombre,
    sum(coalesce(v.cantidad, 0)) AS cantidad_vendidas
FROM
    ventas v
    RIGHT JOIN productos p ON v.producto_id = p.id
GROUP BY
    p.id
ORDER BY
    sum(coalesce(v.cantidad, 0))
LIMIT
    10