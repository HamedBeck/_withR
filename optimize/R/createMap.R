
library(maps)
library(leaflet)
data("world.cities")
country <- c("Spain", "Serbia", "Germany", "Belgium" ,"Hungary",
             "Denmark","Ireland","Germany","Turkey","Ukraine",
             "UK","Spain","Italy","Russia","Germany","France",
             "Czech Republic","Italy","Bulgaria","Sweden",
             "Austria","Poland", "Romania")
tst[[1]]$trip %>%
  data.frame(name=.) %>%
  dplyr::left_join(.,
                   world.cities %>%
                     dplyr::filter(., name %in% tst[[1]]$trip & country.etc %in% country) %>%
                     dplyr::select(., c(lat, long, name)),
                   by="name")  %>%
  leaflet(.)%>%
  addTiles(.)%>%
  addMarkers(label = ~name) %>%
    addPolylines(., lng=~long, lat=~lat )

