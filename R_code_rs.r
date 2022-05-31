#04.03.22
# Questo è il primo script che useremo a lezione

#prima funzione che useremo
#richiamiamo la libreria raster
library(raster)

#10.03.22
#richiamiamo la libreria raster
#installazione
#install.packages("raster")[apriamo le virgolette perchè siamo usciti da R]
library(raster)

#Settaggio cartella di lavoro 
#setwd("~/lab/") #linux
#setwd("/User/utente/lab") #mac
setwd("C:/lab/") #windows

#import
#per importare un pacchetto di dati esiste una funzione in R
#la funzione per importare tanti dati in R si chiama BRICK
#come si usano le funzioni su R
brick("p224r63_2011.grd")
#poi l'assegnamo all'oggetto
l2011 <- brick("p224r63_2011.grd")
#dopo aver importato i dati = diamo il nome l2011 e usciranno tutte le informazioni 
l2011
