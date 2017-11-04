#Comprobamos y establecemos directorio de trabajo
getwd()
if (!file.exists("C:/Users/Mireia/Documents/Actividad_colaborativa_M3/scripts")) {dir.create("C:/Users/Mireia/Documents/Actividad_colaborativa_M3/scripts")}
setwd("C:/Users/Mireia/Documents/Actividad_colaborativa_M3/scripts")
getwd()
#Creamos directorio para los datos
if(!file.exists("../datos")) {dir.create("../datos")}
#Descargamos dataset
library(knitr)
library("knitr", lib.loc="~/R/win-library/3.4")
download.file(fileURL,destfile="../datos/Sacramentocrime.csv",method="auto")
fechaDescarga <- date()
fechaDescarga
sacramentoCrime <- read.table("../datos/Sacramentocrime.csv", row.names=NULL, sep=";", header=TRUE)
kable(head(sacramentoCrime[,1:5]))
#Leemos el fichero de la siguiente manera con tal de poder verlo agrupado en columnas
library (reshape)
sacramentoCrime <-read.csv("../datos/Sacramentocrime.csv", header=TRUE)
head(sacramentoCrime)
View(sacramentoCrime)
#Comprobamos que todas las columnas estan escritas en minusculas o mayusculas
names(sacramentoCrime)
#Ordenamos crimenes por fecha y hora, distrito y beat
sacramentoCrime2 <- sacramentoCrime[order(xtfrm(sacramentoCrime[,1]), xtfrm(sacramentoCrime[,3]), xtfrm(sacramentoCrime[,4]))]
head(sacramentoCrime) [,1:5]
sacramentoCrime2 <- sacramentoCrime[order( xtfrm(sacramentoCrime[,1]), xtfrm(sacramentoCrime[,3]), xtfrm(sacramentoCrime[,4])), ]
sacramentoCrime2 [1:10,1:5]
#Escribimos destino tidy data
if(!file.exists("../datos/tidy_data")) { dir.create("../datos/tidy_data")}
write.table(sacramentoCrime2, file = "../datos/tidy_data/sacramentocrime_modif.csv", sep=";")
head(sacramentoCrime2) [,1:6]
#Comprobamos la existencia de espacios en las columnas district, beat y grid
length(grep(" ", sacramentoCrime2$district))
length(grep(" ", sacramentoCrime2$beat))
length(grep(" ", sacramentoCrime2$grid))
#Eliminamos los espacios en beat
sacramentoCrime2$beat <- gsub(" ","",sacramentoCrime2$beat)
length(grep(" ",sacramentoCrime2$beat))
#Lo mismo con ucr_ncic_code, latitude y longitude
sacramentocrime2$ucr_ncic_code <- gsub(" ", "", sacramentoCrime2$ucr_ncic_code)
sacramentoCrime2$ucr_ncic_code <- gsub(" ", "", sacramentoCrime2$ucr_ncic_code)
length(grep(" ",sacramentoCrime2$ucr_ncic_code))
sacramentoCrime2$latitude <- gsub(" ", "", sacramentoCrime2$latitude)
length(grep(" ",sacramentoCrime2$latitude))
sacramentoCrime2$longitude <- gsub(" ", "", sacramentoCrime2$longitude)
length(grep(" ",sacramentoCrime2$longitude))
head(sacramentoCrime2) [1:6,1:9]
#En las columnas address y crimedescr eliminamos los dobles espacios
length(grep("  ", sacramentoCrime2$crimedescr))
sacramentoCrime2$address <- gsub("  ", " ", sacramentoCrime2$address)
sacramentoCrime2$crimedescr <- gsub("  ", " ", sacramentoCrime2$crimedescr)
length(grep("  ", sacramentoCrime2$crimedescr))
length(grep("  ", sacramentoCrime2$address))
sacramentoCrime2$crimedescr <- gsub("  ", " ", sacramentoCrime2$crimedescr)
length(grep("  ", sacramentoCrime2$crimedescr))
length(grep(".", sacramentoCrime2$address))
#Algunas direcciones tienen abreviaturas con punto y otras no, asi que las eliminamos para tener un dataset homogeneo
sacramentoCrime2$address <- gsub(".","", sacramentoCrime2$address)
length(grep(".", sacramentoCrime2$address))
length(grep(".", sacramentoCrime2$address))
savehistory("~/Actividad_colaborativa_M3/scripts/actividad_colaborativa.R")
