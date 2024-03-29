

naturalSelection <- function(population, objectiveFunction ){

  treshold <- population %>%
    lapply(.,
           function(x){
             x$distance}
           ) %>%
    unlist(.) %>%
    objectiveFunction(.)
  population[purrr::map(.x=population,
                        .f= function(x){
                          x$distance <= treshold}
                        ) %>%
               unlist]
}

crossover <- function(trip, df){
  x <-sample(2:(length(trip$trip)-1), 10, replace = FALSE)
  temp <-trip$trip[x[1:5]]
  trip$trip[x[1:5]] <- trip$trip[x[6:10]]
  trip$trip[x[6:10]] <- temp
  trip <- calculateDistance(trip$trip, df)
  return(trip)
}

mutation <- function(trip, df){
  mutated <- crossover(trip, df)
  delta <- trip$distance - mutated$distance
  if(delta > 0 |
     exp(-delta/runif(1, min = 0.5, max = 10)) > runif(1, min = 0, max = 1)){
    return(mutated)
  }
  else
    return(trip)
}



geneticAlgorithm <- function(nPopulation, df){

  generation <- lapply(seq.int(nPopulation),
                       FUN =function(x) {
                         assign(toString(x),
                                df %>%
                                  configureTrip() %>%
                                  calculateDistance(. , df))}
                       )
  generation <- generation %>%
    naturalSelection(., mean)
  diffLength <- nPopulation - length(generation)
  toCross <-sample(seq_along(generation), 0.2*diffLength)
  generation <- append(generation,
                       lapply(toCross, function(x){
                         generation[[x]] %>%
                           crossover(., df)})
  )
  toMut <-sample(seq_along(generation), 0.08*diffLength)
  generation <- append(generation,
                       lapply(toMut, function(x){
                         generation[[x]] %>%
                           mutation(., df)})
  )
  diffLength <- nPopulation - length(generation)
  idx <- order(sapply(generation, "[[", "distance"))[1:(0.5*diffLength)]
  generation <- append(generation, generation[idx])

  generation <- append(generation,
                       lapply(seq.int((diffLength*0.5)),
                       FUN =function(x) {
                         assign(toString(x),
                                df %>%
                                  configureTrip() %>%
                                  calculateDistance(. , df))}
                       )
  )

}



