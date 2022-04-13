
library(magrittr)
#' Beregn justering byggeomkostning
#'
#' @description
#' Funktion til at beregne den samlede justering af enten additive eller
#' multiplikative faktorer.
#'
#' @param scr \code{data.frame} Scoredata.
#' @param katalog \code{data.frame} Katalog med informationer om justeringer.
#' @param byggeri_type \code{character} Byggeritype.
#' @param type \code{character} 'additiv' eller 'multiplikativ'.
#' @param basisfaktor,basispris TODO: skal dokumenteres
#' @return \code{tibble} Samlet justering.
#'
#' @export


readMyCsvData <- function(path ="~/_withR-master/city_data.csv"){

  df <- readr::read_csv(path, show_col_types = FALSE) %>%
    as.data.frame()
  rownames(df) <- df[["Row-name"]]

  return(df)
}

configureTrip <- function(df){

  trip <- colnames(df)[colnames(df) != "Row-name"]
  trip <- c(trip[1],trip[sample(c(2:length(trip)), length(trip)-2)], trip[1])

  return (trip)

}


calculateDistance <- function(trip, df){

  distance <- c()
  for (i in seq.int(1 ,length(trip)-1)) {
    distance <- append(distance, df[trip[i],][[trip[i+1]]])
    }
  distance <- append(distance, df[dplyr::nth(trip,-2),][[dplyr::last(trip)]] )

  return(list(distance=sum(distance)/1000, trip=trip))

}

