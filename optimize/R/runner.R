
runner <- function(nGeneration, nPopulation){
  df <- readMyCsvData()
  result <- purrr::map(seq_len(nGeneration), ~ geneticAlgorithm(nPopulation, df))[[nGeneration]] %>%
    naturalSelection(., min)
  createMap(result)
  result

}

tst <- runner(100, 500)
