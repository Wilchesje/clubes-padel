#PAQUETES
library(ggplot2)

#IMPORTE ARCHIVOS
setwd()
df = read.csv("minimo.csv", sep = ";")
df2 = read.csv("maximo.csv", sep = ";")

#PLOTS
#Acumulado de clubes con menores costos
ggplot(df, aes(x = nombre)) +
  geom_bar(fill = "#957DAD", color = "black") +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, size = 3) +
  labs(title = "Clubes con las reservas más económicas",
       x = "Club",
       y = "Conteo") +
  ylim(0,8)+
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), 
        plot.title = element_text(hjust = 0.5))

#Acumulado de clubes con mayores costos
ggplot(df2, aes(x = nombre)) +
  geom_bar(fill = "#957DAD", color = "black") +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, size = 3) +
  labs(title = "Clubes con las reservas más costosas", x = "Club", y = "Conteo") +
  ylim(0,8)+
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), plot.title = element_text(hjust = 0.5))
