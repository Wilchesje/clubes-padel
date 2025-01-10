#PAQUETES
library(ggplot2)

#IMPORTE ARCHIVO
setwd()
df = read.csv("num_canchas_por_club.csv", sep = ";")

#ESCALA DE COLORES
morados = colorRampPalette(c("#E0BBE4", "#957DAD", "#4A4080"))(length(unique(df$id_club)))

#PLOT
ggplot(df, aes(x = id_club, y = numero_canchas, fill = id_club)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = morados) +
  labs(
    title = "Número de Canchas por Club",
    x = "ID del Club",
    y = "Número de Canchas"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1))
