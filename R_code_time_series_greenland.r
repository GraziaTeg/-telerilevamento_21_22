#Time series analysis of Greenland LST data 
#Analisi delle serie temporali dei dati LST della Groenlandia
#inserire pacchetti 
library(raster)
#cartella di lavoro 
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab/greenland")
#aggiungere anche la cartella greenland

?raster

#importiamo immagine 2000
raster("lst_2000.tif")
lst2000 <- raster("lst_2000.tif")
lst2000
#plottiamo 
plot(lst2000)

#Exercise: import all the data 
#importiamo tutti i dati del 2005, 2010, 2015
#2005
raster("lst_2005.tif")
lst2005 <- raster("lst_2005.tif")
lst2005
#2010
raster("lst_2010.tif")
lst2010 <- raster("lst_2010.tif")
lst2010
#2015
raster("lst_2015.tif")
lst2015 <- raster("lst_2015.tif")
lst2015




