CREATE INDEX tbl_idx ON tbl (text)  
SELECT * FROM tbl WHERE text LIKE 'TJ%' 


-- En este caso puede que el tipo de indice no sea adecuado dada la posible alta cardinalidad de text donde este puede ser de tamaño variable, donde no hay valores fijos o rangos.

-- Se podria bien usar un indice de texto completo "FULLTEXT" o bien limitar la longitud maxima de text y buscar por igualdad agregando otra columna al filtro