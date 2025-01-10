# RESUMEN
Este proyecto analiza las dinámicas de costos de reserva para los diferentes clubes de pádel de la ciudad de Bogotá, Colombia. Se toman en cuenta diferentes variables para conocer su influencia sobre el costo, y se determina cuáles clubes son los más económicos y más costosos para hacer una reserva.

# OBJETIVOS
1.  Obtener la información general de los clubes de pádel de Bogotá, identificando cuáles cuentan con mayor número de canchas y el rango de precios de una reserva.

2.  Identificar la variación en precios a lo largo del día para los clubes entre semana y los fines de semana.

3. Conocer si el momento del día, la longitud de una reserva, y el número de canchas tienen una influencia significativa sobre los precios de los clubes.

4. Identificar los clubes más económicos y caros para hacer una reserva.

# FUENTE DE DATOS
Se hizo una selección manual de los clubes de Bogotá acorde a la aplicación de reservas “easycancha”, de la cual también se obtuvo los horarios disponibles, la longitud de reservas y el costo de estas para los diferentes días de la semana. Estos datos se almacenaron en un documento de Excel ([datos_easycancha.xlsx](/EXCEL/datos_easycancha.xlsx)), el cual fue la base para la elaboración de todos los procesos por medio de las diferentes herramientas empleadas. 

# MÉTODOS
- Se utilizó SQL (con PostgreSQL como sistema de gestión de bases de datos) para la obtención de información general y creación de archivos csv.
- Se utilizó Python (3.12.3) para la visualización.
- Se utilizó R (4.3.2) para la visualización y análisis estadístico.

Tanto SQL y Python se manejaron con el programa de Visual Studio Code, mientras que R se manejó por medio de R Studio.

# ANÁLISIS

## 1. Descripción de los clubes 
*NOTE: El archivo [descripción_general.sql](/SQL/descripción_general.sql) en la carpeta [SQL](/SQL/) contiene los queries elaborados para esta parte. Los códigos de las visualizaciones de esta parte se encuentran en el archivo [descripción_general.R](/R/descripción_general.R) en la carpeta [R](/R/).*

### 1.1 Número de clubes en Bogotá
*NOTE: Se utilizó SQL.*

| Número de clubes |
|------------------|
|        21        |

Se identificaron 21 clubes **activos** en la ciudad.

### 1.2 Número de canchas por club
*NOTE: Se utilizó SQL para la obtención de los datos, y R para su visualización*

![Numero de canchas por club](IMG\canchas_por_club.png)

La cantidad de canchas por club varía entre 1 y 8, siendo **LocosxPadel** el club con más canchas. El número de canchas por club que más se repite es **1**, habiendo **6 clubes** que sólo cuentan con una cancha de pádel.

### 1.3 Rango de precios
*NOTE: Se utilizó SQL*

| Valor mínimo de reserva |Valor máximo de reserva|
|-------------------------|-----------------------|
|$30000                   |$220000                |

El rango de precios es bastante grande, siendo el valor máximo hasta casi **8 veces** mayor que el valor mínimo de reserva. Para entender por qué se da esto, se visualizó y analizó la diferencia de los precios a lo largo del día teniendo en cuenta, también, la duración de la reserva (una hora u hora y media) y los días de la semana (lunes - viernes y sábado - festivos).

## 2. Variación de los precios a lo largo del día
*NOTE: El archivo [variación_precios.pynb](/PYTHON/variacion_precios.ipynb) en la carpeta [PYTHON](/PYTHON/) cuenta con el código para esta parte.*



Se utilizó Python para la elaboración de gráficos de puntos con el objetivo de identificar las tendencias de los precios de reserva de los diferentes clubes de Bogotá a lo largo del día. Se obtuvieron dos gráficos, uno para los valores entre semana y otro para los valores los fines de semana.

![Costo de reservas por hora LV](/IMG/Costo_reserva_hora_LV.png)
![Costo de reservas por hora SF](/IMG/Costo_reserva_hora_SF.png)

Se puede apreciar los siguientes patrones y diferencias entre los gráficos desarrollados:
1. Las reservas de una hora son **más económicas** que las reservas de hora y media tanto entre semana como los fines de semana.

2. Para los días entre semana, las reservas de una hora son dominantes en la mañana y tarde (00:00 – 17:00), y las reservas de hora y media dominan en la noche (17:00 – 00:00). Se ve un patrón **parcialmente opuesto** los fines de semana, siendo las mañanas (00:00 – 12:00) la franja horaria dominada por reservas de hora y media, y la tarde y noche (12:00 – 00:00), dominadas por reservas de una hora.

3. Entre semana los precios son **mayores en la noche** que en la mañana y la tarde, pero en los fines de semana, los precios son **mayores en la mañana** que en la tarde y noche.

A partir de esto, se creó una nueva variable llamada ***“MOMENTO_DIA”*** donde, dependiendo la hora en la que empieza la reserva, se clasifica como *“MAÑANA”*, *“TARDE”* o *“NOCHE”*. Estas categorías se tomarían en cuenta para los análisis estadísticos siguientes.

| MAÑANA      |     TARDE   |NOCHE        |
|-------------|-------------|-------------|
|00:00 - 12:00|12:00 - 17:00|17:00 - 00:00|

## 3. Efecto de diferentes variables sobre el costo de reserva

### 3.1 Efecto del momento del día sobre el costo de reserva
*NOTE: El archivo [precios_momento_dia_longitud_reserva.R](/R/precios_momento_dia_longitud_reserva.R) en la carpeta [R](/R/) cuenta con el código para esta parte.*

Se realizaron diferentes visualizaciones para las reservas entre semana y las reservas los fines de semana.

![Distribución precios momento LV](/IMG/precios_momento_dia_LV.png)
![Distribución precios momento SF](/IMG/precios_momento_dia_SF.png)

Los diagramas de violín muestran cómo se distribuyen los precios para cada elemento de la variable independiente (en este caso el momento del día). Las partes más gruesas del sombreado muestran dónde hay mayor acumulación de los datos, y las partes más finas lo opuesto.

Estos diagramas reafirman que, para entre semana, los precios son mayores en la noche que en la mañana y en la tarde, y que, para los fines de semana, los precios son mayores en la mañana que en la tarde y la noche. Esto es reafirmado por medio de un análisis de varianza (ANOVA).

*NOTE: No solo para esta parte pero de aquí en adelante se interpreta que un valor - P menor a 0.05 representa una diferencia significativa entre los grupos analizados. Por otro lado mientras mayor sea el valor - F, más confiable es ese valor - P.*

| Días de la semana      | Valor - F | Valor - P     |
|------------------------|-----------|---------------|
| Lunes – Viernes        | 230,46    | **2 × 10⁻¹⁶*** |
| Sábados – Festivos     | 76,863    | **2 × 10⁻¹⁶** *|

'*' *representa un valor p significativo* 

### 3.2	Efecto de la longitud de reserva en el costo de la reserva
*NOTE: El archivo [precios_momento_dia_longitud_reserva.R](/R/precios_momento_dia_longitud_reserva.R) en la carpeta [R](/R/) cuenta con el código para esta parte.*

Al igual que en la sección 3.1, se realizaron diagramas de violín para identificar las diferencias entre los grupos.

![Distribución precios longitud LV](/IMG/precios_longitud_reserva_LV.png)
![Distribución precios longitud SF](/IMG/precios_longitud_reserva_SF.png)

Los diagramas de violín reafirman que, para entre semana, los precios son mayores en la noche que en la mañana y en la tarde, y que, para los fines de semana, los precios son mayores en la mañana que en la tarde y la noche. Esto es reafirmado por medio de un análisis de varianza (ANOVA).

| Días de la semana     | Valor - F | Valor - P     |
|-----------------------|-----------|---------------|
| Lunes – Viernes       | 76,95     | **2 × 10⁻¹⁶*** |
| Sábados – Festivos    | 281,078   | **2 × 10⁻¹⁶***|

'*' *representa un valor p significativo* 


### 3.3	Efecto de la interacción entre longitud de reserva y momento del día en el costo de la reserva
*NOTE: El archivo [precios_momento_dia_longitud_reserva.R](/R/precios_momento_dia_longitud_reserva.R) en la carpeta [R](/R/) cuenta con el código para esta parte.*

Se realizó un análisis de varianza (ANOVA) que tuviera en cuenta la interacción entre las dos variables independientes anteriormente trabajadas. Con este, se pudo conocer que la interacción tiene un efecto significativo en el costo de reserva, pero solo entre semana, y para los fines de semana, la interacción entre las dos variables independientes no es significativa.

Una interacción significativa representa que el efecto significativo de cada variable independiente sobre el costo es producto de la interacción entre ellas.

| Días de la semana     | Valor - F | Valor - P     |
|-----------------------|-----------|---------------|
| Lunes – Viernes       | 6,966     | **0,00108***   |
| Sábados – Festivos    | 2,907     | 0,0561        |

'*' *representa un valor p significativo* 


### 3.4 Efecto del número de canchas sobre el costo de reserva
*NOTE: Los archivos [precio_numero_canchas.sql](/SQL/precio_numero_canchas.sql) y [precios_momento_dia_longitud_reserva.R](/R/precios_momento_dia_longitud_reserva.R) en las carpetas [SQL](/SQL/) y [R](/R/) respectivamente, cuentan con el código para esta parte.*

Se realizaron modelos de regresión lineal para cada combinación de momento del día con longitud de reserva, tanto entre semana como los fines de semana, para conocer si hay una relación entre el número de canchas y el costo de reserva. En total fueron 12 modelos.

#### Entre semana
![numero canchas costo LV](/IMG/costo_canchas_LV.png)

| **Escenario** | **Momento del día** | **Longitud de reserva** | **Cambio en el precio** | **Valor - P** | **R²**   |
|---------------|----------------------|--------------------------|--------------------------|---------------|----------|
| 1             | Mañana              | Hora                     | <span style="color:red;">-$2770</span>               | **0,00175**   | 0,07218  |
| 2             | Tarde               | Hora                     | <span style="color:red;">-$4550</span>                  | **0,000764**  | 0,1139   |
| 3             | Noche               | Hora                     | <span style="color:green;">$7724</span>                | **0,0013**    | *0,6274*   |
| 4             | Mañana              | Hora y media             | <span style="color:red;">-$26894</span>                 | **0,00001**   | *0,629*    |
| 5             | Tarde               | Hora y media             | -$2984                  | 0,246         | 0,009927 |
| 6             | Noche               | Hora y media             | -$942.6                 | 0,703         | -0,01184 |

Para entre semana, se encuentra que, para los escenarios 1, 2, 3 y 4, el número de canchas está asociado con un cambio en el costo de la reserva. Para los escenarios 1, 2 y 4, a mayor número de canchas, menor es el costo de reserva. Lo opuesto se ve en el escenario 3, donde a mayor número de canchas, mayor costo de reserva. Para los escenarios 1 y 2, a pesar de que la relación sea significativa, el modelo no es capaz de explicar la mayor parte de los datos (Bajo R²), por lo que más datos serían ideales para tener mayor precisión.

#### Fines de semana y festivos
![numero canchas costo SF](/IMG/costo_canchas_SF.png)

| **Escenario** | **Momento del día** | **Longitud de reserva** | **Cambio en el precio**        | **Valor - P** | **R²**   |
|---------------|----------------------|--------------------------|---------------------------------|---------------|----------|
| 1             | Mañana              | Hora                     |-$3180| 0,0875    | 0,05486  |
| 2             | Tarde               | Hora                     | $382,2                         | 0,644     | -0,007754 |
| 3             | Noche               | Hora                     | $851                           | 0,316     | 0,0002139 |
| 4             | Mañana              | Hora y media             |-$776,9  | 0,78      | -0,01278 |
| 5             | Tarde               | Hora y media             | -$11225 | 0,0597    | 0,1458   |
| 6             | Noche               | Hora y media             | <span style="color:red;">-$11538</span> | **0,00737**   | 0,2993   |

Para los fines de semana y festivos, el escenario 6 es el único en el que se encuentra una relación significativa entre el número de canchas y el valor de una reserva, siendo esta una relación negativa, donde el aumento de una, representa la reducción de la otra. Sin embargo, este modelo explica el 30% de la variabilidad de los datos, por lo que sería ideal contar con más datos para mayor precisión, al igual que más datos en los otros escenarios, para ver si esto puede generar un cambio en las conclusiones.

## 4. Clubes más económicos y más costosos
*NOTE: Los archivos [min_max.sql](/SQL/min_max.sql) y [min_max.R](/R/min_max.R) en las carpetas [SQL](/SQL/) y [R](/R/) respectivamente, cuentan con el código para esta parte.*

Se eligió el club más económico y costoso teniendo en cuenta algunas de las variables independientes manejadas previamente en este trabajo. Estas siendo: *momento del día*, *longitud de reserva* y *días de la semana*. Para cada combinación posible entre estas 3 variables, se obtuvieron el valor de reserva más económico y más costoso, los clubes a los que pertenecen, y su respectiva franja horaria.

### 4.1 Clubes más económicos

![Clubes más economicos](/IMG/minimo.png)
| **momento del dia** | **longitud de reserva** | **días de la semana** | **precio mínimo** | **id club** | **nombre**                 | **franja horaria** |
|------------------|----------------------|----------|-------------------|-------------|---------------------------------------|---------------------|
| MAÑANA          | HORA                | L-V      | 30000            | BOG13       | **Padel Fedecoltenis Forest Hills**   | 09:00 - 10:00      |
| MAÑANA          | HORA                | S-F      | 32000            | BOG01       | Locos x Padel                         | 04:00 - 05:00      |
| MAÑANA          | HORA Y MEDIA        | L-V      | 50000            | BOG13       | **Padel Fedecoltenis Forest Hills**   | 06:00 - 07:30      |
| MAÑANA          | HORA Y MEDIA        | S-F      | 50000            | BOG13       | **Padel Fedecoltenis Forest Hills**   | 10:30 - 12:00      |
| NOCHE           | HORA                | L-V      | 60000            | BOG12       | Top Padel Bogota                      | 22:00 - 23:00      |
| NOCHE           | HORA                | S-F      | 48000            | BOG01       | Locos x Padel                         | 22:00 - 23:00      |
| NOCHE           | HORA Y MEDIA        | L-V      | 99000            | BOG08       | Azotea Padel                          | 22:00 - 23:30      |
| NOCHE           | HORA Y MEDIA        | S-F      | 80000            | BOG02       | Padel Point                           | 22:00 - 23:30      |
| TARDE           | HORA                | S-F      | 30000            | BOG13       | **Padel Fedecoltenis Forest Hills**     | 13:00 - 14:00      |
| TARDE           | HORA Y MEDIA        | L-V      | 50000            | BOG13       | **Padel Fedecoltenis Forest Hills**     | 15:00 - 16:00      |
| TARDE           | HORA Y MEDIA        | L-V      | 50000            | BOG13       | **Padel Fedecoltenis Forest Hills**     | 13:30 - 15:00      |
| TARDE           | HORA Y MEDIA        | S-F      | 60000            | BOG13       | **Padel Fedecoltenis Forest Hills**     | 12:00 - 13:30      |


Padel Fedecoltenis Forest Hills es el club con las reservas más económicas entre todos los clubes de Bogotá. 7 de los 12 horarios más económicos pertenecen a este club, siendo las reservas más económicas de 30000 pesos colombianos.

### 4.2 Clubes más caros

![Clubes más caros](/IMG/maximo.png)
| **momento del dia** | **longitud de reserva** | **días de la semana** | **precio máximo** | **id club** | **nombre**                 | **franja horaria** |
|------------------|----------------------|----------|-------------------|-------------|----------------------------|---------------------|
| MAÑANA          | HORA                | L-V      | 120000           | BOG06       | **Swing Padel Club**           | 07:00 - 08:00      |
| MAÑANA          | HORA                | S-F      | 140000           | BOG01       | Locos x Padel              | 09:00 - 10:00      |
| MAÑANA          | HORA Y MEDIA        | L-V      | 180000           | BOG15       | Padel Club Patios          | 06:00 - 07:30      |
| MAÑANA          | HORA Y MEDIA        | S-F      | 220000           | BOG06       | **Swing Padel Club**           | 07:30 - 09:00      |
| NOCHE           | HORA                | L-V      | 140000           | BOG01       | Locos x Padel              | 18:00 - 19:00      |
| NOCHE           | HORA                | S-F      | 110000           | BOG06       | **Swing Padel Club**            | 19:00 - 20:00      |
| NOCHE           | HORA Y MEDIA        | L-V      | 220000           | BOG06       | **Swing Padel Club**           | 21:00 - 22:30      |
| NOCHE           | HORA Y MEDIA        | S-F      | 180000           | BOG15       | Padel Club Patios          | 21:00 - 22:30      |
| TARDE           | HORA                | L-V      | 120000           | BOG23       | Padel DC                   | 13:00 - 14:00      |
| TARDE           | HORA                | S-F      | 150000           | BOG09       | El Parche Padel Club       | 12:00 - 13:00      |
| TARDE           | HORA Y MEDIA        | L-V      | 190000           | BOG21       | Cancha Central             | 17:00 - 18:30      |
| TARDE           | HORA Y MEDIA        | S-F      | 190000           | BOG03       | Padel Shot                 | 12:00 - 13:30      |


Swing Padel Club es el club con mayor cantidad de las reservas más costosas entre los clubes de Bogotá. 4 de los 12 horarios más costosos pertenecen a este club, siendo 220000 pesos colombianos el valor más caro por una reserva.

# CONCLUSIONES
Se obtienen las siguientes conclusiones del análisis:
1. El costo de una reserva es claramente dependiente del día de la semana (entre semana o festivo), el momento del día (mañana, tarde o noche) y la longitud de reserva. En el caso de entre semana, existe una interacción significativa en el momento del día y la longitud de la reserva sobre el costo.

2. Aunque existen escenarios en el que el número de canchas está significativamente relacionado al aumento o disminución del costo de reserva, es ideal contar con más datos para poder generar modelos de regresión con mayor precisión. No se debería asumir que el número de canchas tiene un efecto sobre el costo de reserva únicamente a partir de este análisis.

3. En caso de querer hacer una reserva económica, el mejor club para esto es el Padel Fedecoltenis Forest Hills, y el club a evitar sería Swing Padel Club.

# RECOMENDACIONES
Debido a que el número de clubes en la ciudad puede resultar como un factor limitante para el análisis, se puede considerar un análisis a mayor escala con los clubes en el departamento o incluso a nivel nacional. También se pueden emplear otros métodos estadísticos que interpreten mejor una muestra pequeña (menor a 30) de datos.

# APRENDIZAJES PERSONALES
- <u>Planteamiento y organización del proyecto:</u> A lo largo de este proyecto, tuve que retroceder varias veces para asegurarme de que el material producido y analizado fuera congruente a lo largo de todo el proyecto. Esto me demostró la importancia de una fase inicial en la que se haga un planteamiento claro sobre el proyecto y sus fases, pero también de la resiliencia necesaria que este debe tener frente a diferentes problemas que puedan surgir con su desarrollo. 

- <u>Uso de la inteligencia artificial:</u> La inteligencia artificial como ChatGPT o Github Copilot fueron fundamentales para el desarrollo de este proyecto, y me enseñó la importancia de integrar la inteligencia artificial al trabajo no como un sustituto del cerebro humano, pero como una herramienta capaz de acelerar los procesos como escritura de código, interpretación del material y presentación de resultados.
