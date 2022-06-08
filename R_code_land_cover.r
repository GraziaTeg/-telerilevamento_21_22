#code for generating land cover maps from satellite imagery
#codice per la generazione di mappe di copertura del suolo da immagini satellitari
library(raster)
library(RStoolbox) #funzioni per la classificazione 
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")
#su Virtuale -> immagini -> defor1_.jpg e defor2_.jpg [del Rio Peixoto = in Brasile]
#immagini del 1992 e 2006 in lab 

brick("defor1_.jpg") 
l92 <- brick("defor1_.jpg")
l92

#NIR = 1
#rosso = 2
#verde = 3 

plotRGB(l92, 1, 2, 3, stretch= "lin")
#1 = NIR = vicino infrarosso = e tutto quello che è diventato rosso è vegetazione

#exercise: import defor2 and plot both in a single window = importa defor2 e traccia entrambi in un'unica finestra
brick("defor2_.jpg")
l06 <- brick("defor2_.jpg")
l06
plotRGB(l06, 1, 2, 3, stretch= "lin")

#par = perchè abbiamo immagini multispettrali 
par(mfrow = c(2, 1))
plotRGB(l92, 1, 2, 3, stretch= "lin")
plotRGB(l06, 1, 2, 3, stretch= "lin")

#altri pacchetti per fare il multiframe 
#making a simple multiframe with ggplot2 = creare un semplice multiframe con ggplot2











