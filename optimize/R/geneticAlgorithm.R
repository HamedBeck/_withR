

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

crossover <- function(trip){
  x <-sample(2:(length(trip$trip)-1), 2, replace = FALSE)
  temp <-trip$trip[x[1]]
  trip$trip[x[1]] <- trip$trip[x[2]]
  trip$trip[x[2]] <- temp
  trip <- calculateDistance(trip$trip)
  return(trip)
}

mutation <- function(trip){
  mutated <- crossover(trip)
  delta <- trip$distance - mutated$distance
  if(delta > 0 |
     exp(-delta/runif(1, min = 0.5, max = 10)) > runif(1, min = 0, max = 1)){
    return(mutated)
  }
  else
    return(trip)
}



geneticAlgorithm <- function(nPopulation){

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
  toCross <-sample(seq_along(generation), 0.3*diffLength)
  generation <- append(generation,
                       lapply(toCross, function(x){
                         generation[[x]] %>%
                           crossover()})
  )
  toMut <-sample(seq_along(generation), 0.25*diffLength)
  generation <- append(generation,
                       lapply(toMut, function(x){
                         generation[[x]] %>%
                           mutation()})
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


generationLoop <- function(nGeneration, nPopulation){
  purrr::map(seq_len(nGeneration), ~ geneticAlgorithm(nPopulation))[[nGeneration]] %>%
    naturalSelection(., min)
}

generationLoop(10, 50) -> tst
