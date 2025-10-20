# Limpieza de Center Sport Record

datos = read.csv("Datos/Descomprimidos/20251013_6218970817_MiFitness_or1_data_copy/20251013_6218970817_MiFitness_hlth_center_sport_record.csv")
datos = datos |> 
  dplyr::select(Time, Value)

datos = datos |> 
  dplyr::mutate(separacion = purrr::map(.x = Value, .f = jsonlite::fromJSON)) |> 
  tidyr::unnest_wider(separacion) |> 
  dplyr::select(-Value)




