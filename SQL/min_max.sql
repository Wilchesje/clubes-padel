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

-- PRECIO MÍNIMO POR MOMENTO DEL DÍA, LONGITUD DE RESERVA Y DÍAS --
WITH mi AS (
        SELECT momento_dia, longitud_reserva, dias, MIN(costo) AS precio_minimo
        FROM datos_inicial
        GROUP BY momento_dia, longitud_reserva, dias
    )
    SELECT DISTINCT ON (mi.momento_dia, mi.longitud_reserva, mi.dias)
    mi.momento_dia, mi.longitud_reserva, mi.dias, mi.precio_minimo, di.id_club, nombre, franja_horaria
    FROM mi
    JOIN datos_inicial AS di ON 
        di.momento_dia = mi.momento_dia AND 
        di.longitud_reserva = mi.longitud_reserva AND 
        di.dias = mi.dias AND 
        di.costo = mi.precio_minimo
    JOIN clubes_canchas ON di.id_club = clubes_canchas.id_club
    ORDER BY 
        mi.momento_dia, 
        mi.longitud_reserva, 
        mi.dias, 
        di.id_club

---Exportación de la anterior tabla para su visualización con R---
COPY (
    WITH mi AS (
        SELECT momento_dia, longitud_reserva, dias, MIN(costo) AS precio_minimo
        FROM datos_inicial
        GROUP BY momento_dia, longitud_reserva, dias
    )
    SELECT DISTINCT ON (mi.momento_dia, mi.longitud_reserva, mi.dias)
    mi.momento_dia, mi.longitud_reserva, mi.dias, mi.precio_minimo, di.id_club, nombre, franja_horaria
    FROM mi
    JOIN datos_inicial AS di ON 
        di.momento_dia = mi.momento_dia AND 
        di.longitud_reserva = mi.longitud_reserva AND 
        di.dias = mi.dias AND 
        di.costo = mi.precio_minimo
    JOIN clubes_canchas ON di.id_club = clubes_canchas.id_club
    ORDER BY 
        mi.momento_dia, 
        mi.longitud_reserva, 
        mi.dias, 
        di.id_club
    ) TO '\clubes padel\EXCEL\minimo.csv' DELIMITER ';' CSV HEADER;


--- PRECIO MÁXIMO POR MOMENTO DEL DÍA, LONGITUD DE RESERVA Y DÍAS ---
WITH mi AS (
        SELECT momento_dia, longitud_reserva, dias, MAX(costo) AS precio_maximo
        FROM datos_inicial
        GROUP BY momento_dia, longitud_reserva, dias
    )
    SELECT DISTINCT ON (mi.momento_dia, mi.longitud_reserva, mi.dias)
    mi.momento_dia, mi.longitud_reserva, mi.dias, mi.precio_maximo, di.id_club, nombre, franja_horaria
    FROM mi
    JOIN datos_inicial AS di ON 
        di.momento_dia = mi.momento_dia AND 
        di.longitud_reserva = mi.longitud_reserva AND 
        di.dias = mi.dias AND 
        di.costo = mi.precio_maximo
    JOIN clubes_canchas ON di.id_club = clubes_canchas.id_club
    ORDER BY 
        mi.momento_dia, 
        mi.longitud_reserva, 
        mi.dias, 
        di.id_club

---Exportación de la anterior tabla para su visualización con R---
COPY (
    WITH mi AS (
        SELECT momento_dia, longitud_reserva, dias, MAX(costo) AS precio_maximo
        FROM datos_inicial
        GROUP BY momento_dia, longitud_reserva, dias
    )
    SELECT DISTINCT ON (mi.momento_dia, mi.longitud_reserva, mi.dias)
    mi.momento_dia, mi.longitud_reserva, mi.dias, mi.precio_maximo, di.id_club, nombre, franja_horaria
    FROM mi
    JOIN datos_inicial AS di ON 
        di.momento_dia = mi.momento_dia AND 
        di.longitud_reserva = mi.longitud_reserva AND 
        di.dias = mi.dias AND 
        di.costo = mi.precio_maximo
    JOIN clubes_canchas ON di.id_club = clubes_canchas.id_club
    ORDER BY 
        mi.momento_dia, 
        mi.longitud_reserva, 
        mi.dias, 
        di.id_club
    ) TO '\clubes padel\EXCEL\maximo.csv' DELIMITER ';' CSV HEADER;
