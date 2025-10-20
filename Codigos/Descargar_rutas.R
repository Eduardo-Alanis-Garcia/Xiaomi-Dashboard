rutas_entrenamientos = read.csv("Datos/Descomprimidos/20251013_6218970817_MiFitness_or1_data_copy/20251013_6218970817_MiFitness_hlth_center_sport_track_data.csv")

rutas_entrenamientos = rutas_entrenamientos |> 
  dplyr::mutate(id = paste0(Uid, "_",Did, "_", Time)) |> 
  dplyr::relocate(id, .before = Uid)


for (i in 1:nrow(rutas_entrenamientos)) {
  download.file(
    url = rutas_entrenamientos$GPX[i],
    destfile = paste0("Datos/Rutas/", rutas_entrenamientos$id[i], ".gpx"),
    mode = "wb"
  )
}
  

