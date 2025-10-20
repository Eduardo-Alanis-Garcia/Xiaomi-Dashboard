datos_geometrias = sf::read_sf("Output/tables_geometry/entrenamientos_toda_informacion/mis_entrenamientos_todas_variables.geojson")
datos_geometrias = datos_geometrias |>  sf::st_coordinates()
datos_geometrias = datos_geometrias |>  as.data.frame()


library(leaflet)
library(leaflet.extras)
mapa = leaflet() |> 
  addTiles() |>
  addHeatmap(lng = datos_geometrias$X, lat = datos_geometrias$Y, blur = 5, radius = 3)

mapa


library(htmlwidgets)
htmlwidgets::saveWidget(mapa, "Output/map_webs/Basic/basic_map.html",selfcontained = T, title = "Mis entrenamientos")
