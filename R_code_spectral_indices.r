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

#exercise: 
#plot in a multiframe the two images with one on top of the other
#fare un multiframe 
#due immagini 
#sopra = l1992
#sotto = l2006
#quindi sono 2 righe e 1 colonna
par(mfrow = c(2, 1))
plotRGB(l1992, r = 1, g = 2, b = 3, stretch = "lin")
plotRGB(l2006, r = 1, g = 2, b = 3, stretch = "lin")


#facciamo il calcolo di un indice spettrale
#DVI = Difference Vegetation Index
