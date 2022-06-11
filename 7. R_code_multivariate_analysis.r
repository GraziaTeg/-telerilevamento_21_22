#R code for multivariate analysis

#quali libreria usiamo:
library(raster)
library(RStoolbox)#contiene le funzione per fare l'analisi multivariata

#settaggio della cartella 
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")

#le bande che andremo a utilizzare sono quelle del
#p224r63 #immagini del Landsat
#path del satellite ogni path ha un numero con righe = battaglia navale
brick("p224r63_2011_masked.grd")#altro formato rispetto a quello utilizzato 
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011

