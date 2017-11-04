# Comprobamos y establecemos directorio de trabajo
> getwd()
[1] "C:/Users/Mireia/Documents/Actividad_colaborativa_M3"
> if (!file.exists("C:/Users/Mireia/Documents/Actividad_colaborativa_M3/scripts")) {dir.create("C:/Users/Mireia/Documents/Actividad_colaborativa_M3/scripts")}
> setwd("C:/Users/Mireia/Documents/Actividad_colaborativa_M3/scripts")
> getwd()
[1] "C:/Users/Mireia/Documents/Actividad_colaborativa_M3/scripts"

 # Creamos directorio para los datos
> if(!file.exists("../datos")) {dir.create("../datos")}

# Descargamos dataset
> fileURL <- "http://samplecsvs.s3.amazonaws.com/SacramentocrimeJanuary2006.csv"
> download.file(fileURL,destfile="../datos/Sacramentocrime.csv",method="auto")
> fechaDescarga <- date()
> fechaDescarga
[1] "Sat Nov 04 15:14:15 2017"


# Leemos el fichero de la siguiente manera con tal de poder verlo agrupado en columnas
> library(knitr)
> library (reshape)
> sacramentoCrime <-read.csv("../datos/Sacramentocrime.csv", header=TRUE)
> head(sacramentoCrime)

# Comprobamos que todas las columnas estén escritas siguiendo el mismo patrón(en minúsculas), sino hubiéramos aplicado la función tolower() or toupper()
> names(sacramentoCrime)
[1] "cdatetime"     "address"       "district"      "beat"          "grid"         
[6] "crimedescr"    "ucr_ncic_code" "latitude"      "longitude"    

# Ordenamos crímenes por fecha y hora, distrito y beat 
> sacramentoCrime2 <- sacramentoCrime[order( xtfrm(sacramentoCrime[,1]), xtfrm(sacramentoCrime[,3]), xtfrm(sacramentoCrime[,4])), ]

# Escribimos directorio para tidy data
> if(!file.exists("../datos/tidy_data")) { dir.create("../datos/tidy_data")}
> write.table(sacramentoCrime2, file = "../datos/tidy_data/sacramentocrime_modif.csv", sep=";")

 # Comprobamos la existencia de espacios en la columna beat y los eliminamos
 > length(grep(" ", sacramentoCrime2$beat))
[1] 7584
> sacramentoCrime2$beat <- gsub(" ","",sacramentoCrime2$beat)
> length(grep(" ",sacramentoCrime2$beat))
[1] 0

 # Lo mismo con ucr_ncic_code, latitude y logitude
 > sacramentoCrime2$ucr_ncic_code <- gsub(" ", "", sacramentoCrime2$ucr_ncic_code)
 > length(grep(" ",sacramentoCrime2$ucr_ncic_code))
[1] 0
 > sacramentoCrime2$latitude <- gsub(" ", "", sacramentoCrime2$latitude)
 > length(grep(" ",sacramentoCrime2$latitude))
[1] 0
 > sacramentoCrime2$longitude <- gsub(" ", "", sacramentoCrime2$longitude)
 > length(grep(" ",sacramentoCrime2$longitude))
[1] 0

# En las columnas address y crimedescr eliminamos los dobles espacios y comprobamos
> sacramentoCrime2$crimedescr <- gsub("  ", " ", sacramentoCrime2$crimedescr)
> sacramentoCrime2$address <- gsub("  ", " ", sacramentoCrime2$address)
> length(grep("  ", sacramentoCrime2$crimedescr))
[1] 0
> length(grep("  ", sacramentoCrime2$address))
[1] 0

# Algunas direcciones tienen abreviaturas con punto y otras no, así que las eliminamos para tener un dataset homogeneo
> length(grep(".", sacramentoCrime2$address))
[1] 7584
> sacramentoCrime2$address <- gsub(".","", sacramentoCrime2$address)
> length(grep(".", sacramentoCrime2$address))
[1] 0
