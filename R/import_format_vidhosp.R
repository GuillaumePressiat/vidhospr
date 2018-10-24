#' Normalise noms
#'
#' Simplifie les description des variables pour en faire des noms de variables
#' adaptées à la manipulation dans R. Fonction d'aide pour importer les formats. Utilisé pour importer les formats.
#'
#' @param x chaine de caractère correspondant aux noms des colonnes
#' @param limite nombre de caractère maximum pour le nom de la colonne dans R
#'
#' @return Un vecteur de caractères normalisés
#' @seealso Dans le package, le répertoire `/inst/extdata`.
#' @export
normalise <- function(x, limite = 26) {

  mots_liaison <- " de | du | en | a | la | l'| d'| des | par | au | pour | total | sejour "
  x %>%
    # Retirer les espaces sur-numéraires
    stringr::str_trim() %>%
    # Tout mettre en mininuscule
    stringr::str_to_lower() %>%
    # Passer en ASCII
    iconv(from = 'UTF-8', to = 'ASCII//TRANSLIT') %>%
    # Retirer certains mots de liaisons
    gsub(pattern = mots_liaison, replacement = ' ') %>%
    # Une deuxième fois s'il y en a deux qui se suivent
    gsub(pattern = mots_liaison, replacement = ' ') %>%
    # retirer tout ce qui n'est pas des digits ou ASCII ou espace
    gsub(pattern = '[^a-z^0-9^ ]', replacement = '') %>%
    # Remplacer les expaces par des underscores
    gsub(pattern = ' ', replacement = '_') %>%
    # Limiter à n charactères
    substr(1, limite) %>%
    # Supprimer _ final ou avec une seule lettre
    gsub(pattern = '_.{0,1}$|', replacement = '')


}
