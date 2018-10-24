#' Import un fichier VID-HOSP
#'
#' Lit le fichier VID-HOSP, détermine son format, récupère les positions des variables et l'importe.
#' @param chemin_vidhosp Chemin d'accès vers le ficheir VID-HOSP
#' @param partie_variable Si FALSE, n'importe pas la partie variable. Non fonctionnel pour l'instant, partie variable à implémenter
#' @param etiquettes Ajouter les étiquettes de variables pour plus facilement identifier. A implémenter.
#'
#' @return Un tibble avec les données du VID-HOSP
#' @export
#' @import dplyr
importe_vidhosp <- function(chemin_vidhosp, partie_variable = FALSE, etiquettes =TRUE) {

  # Déterminer la version du format
  v_vidhosp <- lis_format(chemin_vidhosp)

  # Sélectionne les données de format
  format_v <- filter(formats, format_version == v_vidhosp, position_variable == FALSE)

  db <- readr::read_fwf(file = chemin_vidhosp,
                  col_positions = readr::fwf_widths(
                    widths = format_v$taille,
                    col_names = format_v$nom_variable)
  )

  if (etiquettes) {
    NULL
  }

  db
}

#' Lit format d'un VID-HOSP
#'
#' Lit le format d'un fichier VID-HOSP. Récupère la première ligne du fichier et lit le format qui est normalement toujours à la même position
#'
#' @inheritParams importe_vidhosp
#' @param debut Position du premier caractère
#' @param fin Position du dernier caractère
#' @return Une chaine de caractère avec la version du format
#' @export
lis_format <- function(chemin_vidhosp, debut = 49, fin = 52) {
  premiere_ligne <- readLines(chemin_vidhosp, n = 1)
  substr(premiere_ligne, debut, fin)
}
