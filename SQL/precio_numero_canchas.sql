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
-- NÚMERO DE CANCHAS Y COSTO DE RESERVA PARA CADA CLUB --
SELECT datos.id_club, NOMBRE, DIAS, longitud_reserva, momento_dia, COSTO, NUMERO_CANCHAS
    FROM datos
    JOIN clubes_canchas ON datos.ID_CLUB = clubes_canchas.ID_CLUB
     ORDER BY 
        datos.id_club,
        CASE 
            WHEN dias = 'L-V' THEN 1
            WHEN dias = 'S-F' THEN 2
        END,
        CASE
            WHEN longitud_reserva = 'HORA' THEN 1
            WHEN longitud_reserva = 'HORA Y MEDIA' THEN 2
        END,
        CASE
            WHEN momento_dia = 'MANANA' THEN 1
            WHEN momento_dia = 'TARDE' THEN 2
            WHEN momento_dia = 'NOCHE' THEN 3
        END;

---Exportación de la anterior tabla para su visualización y análisis con R---
COPY (    
    SELECT datos.id_club, NOMBRE, DIAS, longitud_reserva, momento_dia, COSTO, NUMERO_CANCHAS
    FROM datos
    JOIN clubes_canchas ON datos.ID_CLUB = clubes_canchas.ID_CLUB
     ORDER BY 
        datos.id_club,
        CASE 
            WHEN dias = 'L-V' THEN 1
            WHEN dias = 'S-F' THEN 2
        END,
        CASE
            WHEN longitud_reserva = 'HORA' THEN 1
            WHEN longitud_reserva = 'HORA Y MEDIA' THEN 2
        END,
        CASE
            WHEN momento_dia = 'MANANA' THEN 1
            WHEN momento_dia = 'TARDE' THEN 2
            WHEN momento_dia = 'NOCHE' THEN 3
        END
) TO '\clubes padel\EXCEL\precio_num_canchas.csv' DELIMITER ';' CSV HEADER;
