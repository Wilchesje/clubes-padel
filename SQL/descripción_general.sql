-- TABLAS PARA IMPORTAR DATOS --
CREATE TABLE datos_inicial ( 
	ID_CLUB VARCHAR(20),
    FRANJA_HORARIA VARCHAR(20),
    DIAS VARCHAR(20),
    COSTO INT,
    LONGITUD_RESERVA VARCHAR(20),
    MOMENTO_DIA VARCHAR(20)
	);

--- en caso de que necesite volver a cargar la tabla ---
DROP TABLE datos_inicial;

COPY datos_inicial
FROM '\clubes padel\EXCEL\df_con_momento_dia.csv'
DELIMITER ';' CSV HEADER;

CREATE TABLE clubes_canchas ( 
	ID_CLUB VARCHAR(20),
    NOMBRE VARCHAR(50),
    DIRECCION VARCHAR(50),
    NUMERO_CANCHAS INT
	);

--- en caso de que necesite volver a cargar la tabla ---
DROP TABLE clubes_canchas;

COPY clubes_canchas
FROM '\clubes padel\clubes_bogota.csv'
DELIMITER ';' CSV HEADER;

---------------------------------------------------------------------------------------------------------------------------------------------

--NÚMERO DE CLUBES--
SELECT COUNT(DISTINCT id_club) AS numero_clubes
FROM datos_inicial;


--NÚMERO DE CANCHAS POR CLUB--
SELECT DISTINCT datos_inicial.id_club, numero_canchas
FROM datos_inicial 
JOIN clubes_canchas ON datos_inicial.id_club = clubes_canchas.id_club
ORDER BY numero_canchas DESC;

---Exportación de la anterior tabla para su visualización con R---
COPY(
    SELECT DISTINCT datos_inicial.id_club, numero_canchas
    FROM datos_inicial 
    JOIN clubes_canchas ON datos_inicial.id_club = clubes_canchas.id_club
    ORDER BY numero_canchas DESC
) TO '\clubes padel\EXCEL\num_canchas_por_club.csv' DELIMITER ';' CSV HEADER;


--RANGO DE PRECIOS PARA UNA RESERVA--
SELECT MIN(costo) AS precio_minimo, MAX(costo) AS precio_maximo
FROM datos_inicial;