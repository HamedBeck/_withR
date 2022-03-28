
library(magrittr)

readMyCsvData <- function(path ="~/my-r/city_data.csv"){

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

