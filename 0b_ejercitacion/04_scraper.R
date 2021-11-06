

################## Cargo paquetes
library(dplyr) 
library(rvest) 
library(stringr)


# Extraigo noticias de google
google <- read_html("https://news.google.com.ar/")

# Cargo artículos
articulos <- google %>%
  html_nodes("article")

# Extraer temporalidad
fechas <- articulos %>%
  html_node("time") %>%
  html_text()

# Extraer los medios de la noticia 
medios <- articulos %>%
  html_nodes("a.wEwyrc.AVN2gc.uQIVzc.Sksgp") %>%
  html_text()

# Extraer titulares
titulares <- articulos %>%
  html_nodes("a.DY5T1d") %>%
  html_text()

# Armo
base_noticias <- data.frame(titulares, medios, fechas)
