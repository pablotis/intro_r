

library(eph)
library(tidyverse)


######################################## Descargo base de datos:
eph_ind <- get_microdata(2019, 3)

eph_ind <- get_microdata(2019, 2:4) %>% 
  unnest()

table(eph_ind$ANO4, eph_ind$TRIMESTRE)

######################################## Etiqueto la base de datos:
eph_ind_etiquetada <- eph_ind %>% 
  organize_labels()

table(eph_ind$CH04)
table(eph_ind_etiquetada$CH04)


library(expss)


######################################## Armo tabulados:
eph_ind %>% 
  calculate_tabulates("ESTADO", "CAT_OCUP")

tabla <- eph_ind_etiquetada %>% 
  filter(ESTADO == 1) %>% 
  calculate_tabulates("CH04", "CAT_OCUP", 
                      add.totals = "col",
                      add.percentage = "row",
                      weights = "PONDERA"
                      )



######################################## Armo paneles de datos:
## Descargo base
eph_ind_2019t3 <- get_microdata(2019,3)
eph_ind_2019t4 <- get_microdata(2019,4)

## Armo lista
lista_bases <- list(eph_ind_2019t3,
                    eph_ind_2019t4)

## Creo panel
panel_trimestral_t3_4_2019 <- organize_panels(bases = lista_bases,
                                    variables = c("ESTADO", "PONDERA"),
                                    window = "trimestral")

nrow(panel_trimestral) / nrow(eph_ind_2019t3) * 100

calculate_tabulates(panel_trimestral, "consistencia", add.percentage = "col")

calculate_tabulates(panel_trimestral, 
                    "ESTADO", "ESTADO_t1", 
                    add.percentage = "col",
                    add.totals = "row",
                    weights = "PONDERA_t1")



######################################## Armo variables de ocupacion y tarea:
eph_ind_2019t3 <- eph_ind_2019t3 %>% 
  organize_cno() %>% 
  organize_caes()


eph_ind %>% 
  filter(ESTADO == 1 & CAT_OCUP == 3) %>% 
  calculate_tabulates("CALIFICACION", add.percentage = "col", weights = "PONDERA")


eph_ind <- eph_ind %>% 
  

library(tidyverse)
canastas_regionales <- get_poverty_lines(regional = TRUE)


