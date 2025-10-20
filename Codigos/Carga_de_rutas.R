rutas = list.files("Datos/Rutas/", full.names = T, pattern = "\\.gpx")

guardar = NULL

for (i in 1:length(rutas)) {
  rutas_csv = sf::st_read(rutas[i], layer = "tracks") |>  
    dplyr::mutate(id = basename(rutas[i]) |>  gsub(pattern = ".gpx", replacement = "") |>  stringr::str_squish()) |> 
    dplyr::relocate(id, .before = name)
  
  guardar = dplyr::bind_rows(guardar, rutas_csv)
}

guardar = guardar |> 
  dplyr::select(id, geometry) |> 
  sf::st_as_sf()



### Abrimos rutas de entrenamiento

rutas_entrenamientos = read.csv("Datos/Descomprimidos/20251013_6218970817_MiFitness_or1_data_copy/20251013_6218970817_MiFitness_hlth_center_sport_track_data.csv")

rutas_entrenamientos = rutas_entrenamientos |> 
  dplyr::mutate(id = paste0(Uid, "_",Did, "_", Time)) |> 
  dplyr::relocate(id, .before = Uid)


rutas_entrenamientos = rutas_entrenamientos |> 
  dplyr::left_join(y = guardar, by = c("id" = "id"))


class(rutas_entrenamientos)

rutas_entrenamientos = rutas_entrenamientos |>  sf::st_as_sf(crs = 4326)


# ### Colocar hora entendible
# rutas_entrenamientos = rutas_entrenamientos |> 
#   dplyr::mutate(hora_inicio = as.POSIXct(x = Time, origin = "1970-01-01", tz = "America/Mexico_City"),
#                 hora_final = as.POSIXct(x = UpdateTime, origin = "1970-01-01", tz = "America/Mexico_City")) |> 
#   dplyr::relocate(hora_inicio, .after = UpdateTime) |> 
#   dplyr::relocate(hora_final, .after = hora_inicio) |> 
#   dplyr::mutate(duracion = difftime(time1 = hora_final, time2 = hora_inicio, units = "mins") |>  as.numeric() |> round(digits = 2),
#                 duracion = dplyr::if_else(condition = duracion > 90, true = 90, false = duracion)) |> 
#   dplyr::relocate(duracion, .after = hora_final)



###
source("Codigos/Limpieza_Center_Sport_Record_Json.R")
rutas_entrenamientos = rutas_entrenamientos |> as.data.frame() |>  
  dplyr::left_join(y = datos, by = c("Time" = "Time")) |> 
  sf::st_as_sf(crs = 4326)

names(rutas_entrenamientos) = make.names(names(rutas_entrenamientos), unique = TRUE)

rutas_entrenamientos = rutas_entrenamientos |> 
  dplyr::mutate(geometry = sf::st_make_valid(geometry))

rutas_entrenamientos = rutas_entrenamientos |> 
  dplyr::select(-GPX)

rutas_entrenamientos = rutas_entrenamientos |> sf::st_drop_geometry()
write.csv(rutas_entrenamientos, "Output/tables_geometry/entrenamientos_toda_informacion/mis_entrenamientos_todas_variables.csv", row.names = F)


rutas_entrenamientos = rutas_entrenamientos |>  dplyr::select(id)
sf::st_write(rutas_entrenamientos, "mis_entrenamientos_todas_variables.geojson", driver = "GeoJSON", delete_dsn = TRUE)
sf::st_write(rutas_entrenamientos, "mis_entrenamientos_todas_variables.shp", delete_dsn = TRUE)



