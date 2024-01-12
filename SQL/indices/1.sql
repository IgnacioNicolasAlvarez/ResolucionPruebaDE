-- 1

CREATE INDEX tbl_idx ON tbl (date_column)  
SELECT COUNT(*) FROM tbl WHERE DATEPART(YEAR, date_column) = 2017 

-- TO 

CREATE INDEX tbl_idx ON tbl (date_column)  
SELECT COUNT(*) FROM tbl WHERE date_column >= '2017-01-01' AND date_column < '2018-01-01';

-- Se realiza la modificacion para evitar el uso de funciones en el where, ya que esto hace produce que se evalué la funcion para cada fila de la tabla.

