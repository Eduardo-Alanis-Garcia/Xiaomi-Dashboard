### Explorando la base

# Columnas completas
datos = read.csv("Output/tables_geometry/entrenamientos_toda_informacion/mis_entrenamientos_todas_variables.csv")

datos = datos |> 
  dplyr::select(id:UpdateTime, avg_hrm:end_time, hrm_aerobic_duration:max_cadence, max_hrm:max_speed, min_hrm:time)


write.csv(datos, "Output/tables_geometry/entrenamientos_toda_informacion/datos_variables_completas.csv", row.names = F)



#Datos del reloj nuevo
datos = read.csv("Output/tables_geometry/entrenamientos_toda_informacion/mis_entrenamientos_todas_variables.csv")

datos = datos |> 
  dplyr::filter(!is.na(recover_time))

write.csv(datos, "Output/tables_geometry/entrenamientos_toda_informacion/datos_nuevo_reloj.csv", row.names = F)

