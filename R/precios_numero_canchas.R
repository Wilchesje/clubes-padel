#PAQUETES
library(ggplot2)
library(scales)
library(car)


#IMPORTE ARCHIVO
setwd()
df = read.csv("precio_num_canchas.csv", sep = ";")

##subsets de df dependiendo de la variable dias
df_LV = subset(df, dias == "L-V")
df_SF = subset(df, dias == "S-F") 

#PLOT
ggplot(df_LV, aes(x = numero_canchas, y = costo)) +
  geom_point() +
  geom_smooth(method = "lm", se = T, alpha = 0.3) +
  facet_grid(longitud_reserva ~ momento_dia) +
  labs(title = "Relación entre el número de canchas en el valor de reserva (L-V)",
       x = "Número de canchas",
       y = "Costo")

ggplot(df_SF, aes(x = numero_canchas, y = costo)) +
  geom_point() +
  geom_smooth(method = "lm", se = T, alpha = 0.3) +
  facet_grid(longitud_reserva ~ momento_dia) +
  labs(title = "Relación entre el número de canchas en el valor de reserva (S-F)",
       x = "Número de canchas",
       y = "Costo")

#SUBSETS DE LAS POSIBLES COMBINACIONES PARA LOS MODELOS DE REGRESIÓN
##para "L-V
df_LV_M_1 = subset(df_LV, momento_dia == "MANANA" & longitud_reserva == "HORA")
df_LV_M_1.5 = subset(df_LV, momento_dia == "MANANA" & longitud_reserva == "HORA Y MEDIA")
df_LV_N_1 = subset(df_LV, momento_dia == "NOCHE" & longitud_reserva == "HORA")
df_LV_N_1.5 = subset(df_LV, momento_dia == "NOCHE" & longitud_reserva == "HORA Y MEDIA")
df_LV_T_1 = subset(df_LV, momento_dia == "TARDE" & longitud_reserva == "HORA")
df_LV_T_1.5 = subset(df_LV, momento_dia == "TARDE" & longitud_reserva == "HORA Y MEDIA")

##para "S-F"
df_SF_M_1 = subset(df_SF, momento_dia == "MANANA" & longitud_reserva == "HORA")
df_SF_M_1.5 = subset(df_SF, momento_dia == "MANANA" & longitud_reserva == "HORA Y MEDIA")
df_SF_N_1 = subset(df_SF, momento_dia == "NOCHE" & longitud_reserva == "HORA")
df_SF_N_1.5 = subset(df_SF, momento_dia == "NOCHE" & longitud_reserva == "HORA Y MEDIA")
df_SF_T_1 = subset(df_SF, momento_dia == "TARDE" & longitud_reserva == "HORA")
df_SF_T_1.5 = subset(df_SF, momento_dia == "TARDE" & longitud_reserva == "HORA Y MEDIA")


#MODELOS DE REGRESIÓN
##para "L-V"
modelo_LV_M_1 = lm(costo ~ numero_canchas, data = df_LV_M_1)
modelo_LV_M_1.5 = lm(costo ~ numero_canchas, data = df_LV_M_1.5)
modelo_LV_N_1 = lm(costo ~ numero_canchas, data = df_LV_N_1)
modelo_LV_N_1.5 = lm(costo ~ numero_canchas, data = df_LV_N_1.5)
modelo_LV_T_1 = lm(costo ~ numero_canchas, data = df_LV_T_1)
modelo_LV_T_1.5 = lm(costo ~ numero_canchas, data = df_LV_T_1.5)

##para "S-F"
modelo_SF_M_1 = lm(costo ~ numero_canchas, data = df_SF_M_1)
modelo_SF_M_1.5 = lm(costo ~ numero_canchas, data = df_SF_M_1.5)
modelo_SF_N_1 = lm(costo ~ numero_canchas, data = df_SF_N_1)
modelo_SF_N_1.5 = lm(costo ~ numero_canchas, data = df_SF_N_1.5)
modelo_SF_T_1 = lm(costo ~ numero_canchas, data = df_SF_T_1)
modelo_SF_T_1.5 = lm(costo ~ numero_canchas, data = df_SF_T_1.5)

#SUPUESTOS DE REGRESIÓN
par(mfrow=c(2,2))

##para L-V
plot(modelo_LV_M_1)
plot(modelo_LV_M_1.5)
plot(modelo_LV_N_1)
plot(modelo_LV_N_1.5)
plot(modelo_LV_T_1)
plot(modelo_LV_T_1.5)

##para S-F
plot(modelo_SF_M_1)
plot(modelo_SF_M_1.5)
plot(modelo_SF_N_1)
plot(modelo_SF_N_1.5)
plot(modelo_SF_T_1)
plot(modelo_SF_T_1.5)

#TABLAS DE REGRESIÓN
#para L-V
summary(modelo_LV_M_1)
summary(modelo_LV_M_1.5)
summary(modelo_LV_N_1)
summary(modelo_LV_N_1.5)
summary(modelo_LV_T_1)
summary(modelo_LV_T_1.5)

##para S-F
summary(modelo_SF_M_1)
summary(modelo_SF_M_1.5)
summary(modelo_SF_N_1)
summary(modelo_SF_N_1.5)
summary(modelo_SF_T_1)
summary(modelo_SF_T_1.5)


