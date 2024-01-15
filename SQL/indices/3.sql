CREATE INDEX tbl_idx ON tbl (a, b)  

SELECT * FROM tbl WHERE a = 38 AND b = 1  

SELECT * FROM tbl WHERE b = 1

-- Para el caso de esta query, el índice tbl_idx tiene sentido para la primera consulta, dado que se esta aprovechando ambas columnas en la condicion
-- de filtrado. Sin embargo, para la segunda consulta, el índice no seria tan performante dado que la columna a no esta siendo utilizada en la condición de filtrado.

-- Se podria crear un nuevo índice con la columna b. 
-- Se debe considerar que esto va a afectar el rendimiento de los inserts, updates y deletes en la tabla. Se deberia evaluar que query sera mas consultada a los fines de crear un nuevo indice o no.