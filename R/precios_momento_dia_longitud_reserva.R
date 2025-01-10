#PAQUETES NECESARIOS
library(ggplot2)
library(scales)
library(car)

#IMPORTE ARCHIVO
setwd()
df = read.csv("df_con_momento_dia.csv", sep = ";")

##subsets de df dependiendo de la variable DIA
df_LV <- subset(df, DIA == "L-V") 
df_SF <- subset(df, DIA == "S-F")  

#PLOTS
##violin por momento del día para L-V
ggplot(data = df_LV, aes(x = MOMENTO_DIA, y = COSTO, fill = MOMENTO_DIA)) +
  geom_violin(trim = FALSE, alpha = 0.5) +
  geom_boxplot(width = 0.1, outlier.shape = NA, alpha = 0.7, color = "black") +
  labs(
    title = "Distirbución de precios por momento del día (L-V)",
    x = "Momento del día",
    y = "Precio"
  ) +
  scale_fill_manual(values = rainbow(7)) +
  scale_y_continuous(labels = label_number()) +
  theme_minimal()

##violin por momento del día para S-F
ggplot(data = df_SF, aes(x = MOMENTO_DIA, y = COSTO, fill = MOMENTO_DIA)) +
  geom_violin(trim = FALSE, alpha = 0.5) + 
  geom_boxplot(width = 0.1, outlier.shape = NA, alpha = 0.7, color = "black") +
  labs(
    title = "Distirbución de precios por momento del día (S-F)",
    x = "Momento del día",
    y = "Precio"
  ) +
  scale_fill_manual(values = rainbow(7)) +
  scale_y_continuous(labels = label_number()) +
  theme_minimal()

##violin por longitud de reserva para L-V
ggplot(data = df_LV, aes(x = TIEMPO, y = COSTO, fill = TIEMPO)) +
  geom_violin(trim = FALSE, alpha = 0.5) + 
  geom_boxplot(width = 0.1, outlier.shape = NA, alpha = 0.7, color = "black") +
  labs(
    title = "Distirbución de precios por momento del día (L-V)",
    x = "Momento del día",
    y = "Precio"
  ) +
  scale_fill_manual(values = rainbow(7)) +
  scale_y_continuous(labels = label_number()) +
  theme_minimal()

##violin por longitud de reserva para S-F
ggplot(data = df_SF, aes(x = TIEMPO, y = COSTO, fill = TIEMPO)) +
  geom_violin(trim = FALSE, alpha = 0.5) +  
  geom_boxplot(width = 0.1, outlier.shape = NA, alpha = 0.7, color = "black") +
  labs(
    title = "Distirbución de precios por momento del día (S-F)",
    x = "Momento del día",
    y = "Precio"
  ) +
  scale_fill_manual(values = rainbow(7)) +
  scale_y_continuous(labels = label_number()) +
  theme_minimal()

#MODELOS DE ANOVA (para revisar si hay relación significativa)
costo_modelo_LV = aov(COSTO~MOMENTO_DIA*TIEMPO, data = df_LV) #con interacción de variables independientes
costo_modelo_SF = aov(COSTO~MOMENTO_DIA*TIEMPO, data = df_SF) #con interacción de variables independientes

#SUPUESTOS DE ANOVA (necesarios para asegurarse de que las conclusiones sean precisas)
par(mfrow=c(2,2))

plot(costo_modelo_LV)
plot(costo_modelo_SF)

#TABLAS DE ANOVA (resumen general que muestra la significancia de las relaciones)
summary(costo_modelo_LV)
summary(costo_modelo_SF)

#PRUEBA DE TUKEY (para conocer especificamente qué combinaciones de las variables independientes son significativas sobre el costo de reserva)
TukeyHSD(costo_modelo_LV)
TukeyHSD(costo_modelo_SF)