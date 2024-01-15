CREATE INDEX tbl_idx ON tbl (a, date_column)  
SELECT TOP 1 * FROM tbl WHERE a = 12 ORDER BY date_column DESC  


-- En esta consulta, se esta filtrando los resultados basados en la columna a y luego ordenándolos por la columna date_column en orden descendente. 

-- El índice tbl_idx tiene sentido, donde a sea la primera columna y date_column la segunda, porque son invocados en ese orden en la plan de ejecucion. 