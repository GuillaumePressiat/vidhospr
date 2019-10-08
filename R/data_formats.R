#' Formats des fichiers VID-HOSP
#'
#' Formats permettant d'importer les fichiers VID-HSOP. Ils sont importés directement depuis les PDF fournis par l'ATIH à l'aide de [tabula](https://tabula.technology/) qui produit des CSV puis de scripts adaptés pour chaque années disponibles dans `inst/extdata``
#'
#' @format Un data.frame avec 9 variables
#' - *nom* Nom de la variable tel que décrit dans le manuel de l'ATIH
#' - *taille* Taille du champ
#' - *debut* Position du premier caractère de la variable. NA pour les champs à position relative.
#' - *fin* Position du dernier caractère de la variable. NA pour les champs à position relative.
#' - *obligatoire* O = obligatoire, F = Facultatif. NA et N ne sont pas documentés.
#' - *nom_variable* Nom de la variable à utiliser dans R. Est une normalisation à 20 caractères avec uniquement des caractères alphanumériques minuscules ASCII et des underscores à la place des espaces.
#' - *format_version* Version du format
#' - *position_variable* Indique si le champ est à position variable. TRUE si *debut* et *fin* sont NA.
#'
#' @source
#' - Formats 2019 : \url{https://www.atih.sante.fr/formats-pmsi-2019}
#' - Formats 2018 : \url{https://www.atih.sante.fr/formats-pmsi-2018}
#' - Formats 2017 : \url{https://www.atih.sante.fr/formats-pmsi-2017}
"formats"
