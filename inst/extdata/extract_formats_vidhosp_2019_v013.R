# Importer le CSV après découpage dans tabula
db <- readr::read_csv('inst/extdata/formats_vidhosp_2019_v013.csv')

# En bazard. Ne garder que les lignes qui vont bien.

attr(db, 'spec') <- NULL

library(dplyr)
library(magrittr)

db %<>%
  filter(!is.na(X1) | !is.na(X2))


# Retirer la colonne de consignes et celle du type de la norme et position dans
# la norme car non utile.
db %<>% select(-X8, -X5, -Position)

# Nommer les colonnes
names(db) <- c('nom', 'taille', 'debut', 'fin', 'obligatoire')

# Retirer ligne titre
db <- db[-1, ]

# Typer

db %<>%
  mutate(taille = as.integer(taille), debut = as.integer(debut),
         fin = as.integer(fin))

# Récupérer les noms lorsque tronqué car multiligne
# Pour ce faire, lorsqu'il y a un NA au niveau d'un nom, prendre le précédent et le suivant et concaténer

noms_na <- which(is.na(db$nom))

recup_nom <- function(position)
  paste(db$nom[position-1],db$nom[position+1])

for(position in noms_na)
  db$nom[position] <- recup_nom(position)

# Supprimer les positions NA
db <- db[!is.na(db$taille), ]

# Pour les parties variables, supprimer les doublons
premiere_ligne_trop <- grep('DMT n° N', x = db$nom)
db <- db[-(premiere_ligne_trop:nrow(db)), ]

library(lisvidhosp)

db$nom_variable <- normalise(db$nom)

db$format_date_applicable <- as.Date('2019-03-01')
db$format_version <- 'V013'
db$position_variable <- is.na(db$debut)
glimpse(db)


formats_path <- 'data/formats.rda'

# TODO: a tester
if (file.exists(formats_path)) {
  load(formats_path)
  # Retirer cette version si déjà existatne
  formats <- filter(formats, format_version != db$format_version[1])
  formats %<>% bind_rows(db)

} else {
  # Première création
  formats <- db
}

usethis::use_data(formats, overwrite = TRUE)
