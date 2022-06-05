#25.03.22
#serve per calcolare gli indici di vegetazione 
library(raster)

#poi fare uil settaggio della cartella di lavoro della Working directory
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")

#esercizio
#import the firth file -> defor1_.jpg -> give it the name l1992
#importare la prima immagine satellitare con l1992
brick("defor1_.jpg")
l1992 <- brick("defor1_.jpg")
l1992

#Indice di SHANNON = BIT
2^8 #2 al 8
#[1] 256
#o da 0 a 255 = 256
#o da 1 a 256 = 256
#molti immagini satellitari vanno da 0 a 255 = 8 BIT = 
#quindi utilizziamo solo dati interi 

?plotRGB #del pacchetto raster
plotRGB(l1992, r = 1, g = 2, b = 3, stretch = "lin")

#layer 1 = NIR = prima banda
#layer 2 = red
#layer 3 = green

#esercizio: 
#import the second file -> defor2_.jpg -> give it the name l2006
brick("defor2_.jpg")
l2006 <- brick("defor2_.jpg")
l2006
plotRGB(l2006, r = 1, g = 2, b = 3, stretch = "lin")

