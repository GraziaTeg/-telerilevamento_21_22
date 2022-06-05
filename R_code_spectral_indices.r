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
dvi1992 = l1992[[1]] - l1992[[2]]
dvi1992

#facciamo un plot di questo dato del DVI 1992
cl <- colorRampPalette(c("dark blue", "yellow", "red", "black")) (100)
plot(dvi1992, col = cl)


#ora andiamo a fare 2006 
#bande sempre le stesse
dvi2006 = l2006[[1]] - l2006[[2]]
dvi2006
#facciamo un plot di questo dato del DVI 2006
cl <- colorRampPalette(c("dark blue", "yellow", "red", "black")) (100)
plot(dvi2006, col = cl)

#c'è un altro metodo per il calcolo della DVI 
#invece di usare gli elementi [[1]] e [[2]]
#possiamo usare i nomi 
dvi1992 = l1992$defor1_.1 - l1992$defor1_.2
dvi1992
cl <- colorRampPalette(c("dark blue", "yellow", "red", "black")) (100)
plot(dvi1992, col = cl)
dvi2006 = l2006$defor1_.1 - l2006$defor1_.2
dvi2006
cl <- colorRampPalette(c("dark blue", "yellow", "red", "black")) (100)
plot(dvi2006, col = cl)

#DVI 1992 = abbiamo della vegetazione 
#DVI 2006 = abbiamo meno vegetazione ma più deforestazione 
#ora facciamo la differenza tra 
#DVI1992 - DVI2006 = otteniamo la differenza di DVI 
#la differenza di DVI = dvi_dif
#DVI difference in time 
dvi_dif = div1992 - dvi2006
cld <- colorRampPalette(c("blue", "white", "red"))(100)

#mi da un warning, non errore = ci sono magari nel bordo esterno, visto che sono immagini esportate
#non importa 
#Warning message:
#In dvi1992 - dvi2006 :
#  Raster objects have different extents. Result for their intersection is returned
#facciamo il plot
dev.off()
plot(dvi_dif, col = cld)


