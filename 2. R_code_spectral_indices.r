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

#8 BIT
#Range DVI (8 BIT): -255 a 255
#Range NDVI (8 BIT): -1 a 1
#NDVI = normalizzato o standardizzato 

#16 BIT 
#Range DVI (16 BIT): -65535 a 65535
#Range NDVI (16 BIT): -1 a 1

#NDVI può essere usato anche con immagini con risoluzione radiometrica differente 
#[risoluzione radiometrica --> quanti bit ci sono a disposizione di un immagine]

#ora calcoliamo NDVI = per le immagini 
#carichiamo la libreria raswte
library(raster) #raster = rastrum = aratro

#settiamo la Working directory
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")

#importo le due immagini l1992 e l2006
brick("defor1_.jpg")
l1992 <- brick("defor1_.jpg")
l1992
brick("defor2_.jpg")
l2006 <- brick("defor2_.jpg")
l2006
#sono tutti e due 8 BIT

#calcolo 
#DVI = calcolo o con nome o con elementi 
dvi1992 = l1992[[1]] - l1992[[2]]
#dvi = riflettanza NIR - riflettanza R
dvi1992

#NDVI 
#1 banda = NIR
#2 banda = RED
#NDVI 1992
#con parentesi che racchiudono numeratore e denominatore
ndvi1992 = (l1992[[1]] - l1992[[2]]) / (l1992[[1]] + l1992[[2]])
ndvi1992
#oppure
ndvi1992 = dvi1992 / (l1992[[1]] + l1992[[2]])
ndvi1992

#ora facciamo un plot
cl <- colorRampPalette(c("dark blue", "yellow", "red", "black")) (100)
plot(ndvi1992, col = cl) #col = colorRampPalette

#esercizio = multiframe with plotRGB on top pf the NDVI image
#fare un multiframe con il plotRGB dell'immagine sopra [dalla scorsa volta]
#e l'NDVI sotto
par(mfrow = c(2, 1)) #due righe e una colonna
plotRGB(l1992, r = 1, g = 2, b = 3, stretch = "lin")
plot(ndvi1992, col = cl)

#ora facciamo il 2006
dvi2006 = l2006[[1]] - l2006[[2]]
dvi2006

#NDVI 2006
ndvi2006 = (l2006[[1]] - l2006[[2]]) / (l2006[[1]] + l2006[[2]])
ndvi2006
#oppure
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])
ndvi2006
#fare un multiframe con il NDVI1992 dell'immagine sopra e NDVI2006 sotto
#usando sempre questa colorRampPalette
#cl <- colorRampPalette(c("dark blue", "yellow", "red", "black")) (100)
par(mfrow = c(2, 1))
plot(ndvi1992, col = cl)
plot(ndvi2006, col = cl)

################################
#nuova liberia
?RStoolbox
install.packages("RStoolbox")
library(RStoolbox)
?spectralIndices

#Automatic spectral indices by the spectralTindeces function
library(RStoolbox)
install.packages("RStoolbox")
?RStoolbox
library(RStoolbox)
?spectralIndices
#1 banda = NIR
#2 banda = red
#3 banda = green
#ora possiamo usare la funzione spectralIndices = si
si1992 <- spectralIndices(l1992, green = 3, red = 2, nir = 1)

#andiamo a visualizzare i nostri indici 
#cl <- colorRampPalette(c("dark blue", "yellow", "red", "black")) (100) sempre uguale 
plot(si1992, col = cl)

#2006
si2006 <- spectralIndices(l2006, green = 3, red = 2, nir = 1)
plot(si2006, col = cl)

#copernicus
#NDVI a scala globale, il prof lo ha già inserito nel pacchetto ma dobbiamo
#partire dai dati COPERNICUS
#il pacchetto = per la misura della diversità dalla spazio 
#si chiama RASTERDIV
#?rasterdiv #https://cran.r-project.org/web/packages/rasterdiv/index.html
#del prof
#in ogni pacchetto c'è un manuale e poi ci sono anche le vignettes
#rasterdiv = perché è la diversità misurata su dati raster partendo 
#dell'ecologia di comunità = branca dell'ecologia che misura la diversità
#all'interno delle comunità di gruppi di organismi di varie specie che convivono 
#insieme 

####################
#RASTERDIV
install.packages("rasterdiv")
library(rasterdiv)
install.packages("rasterdiv")
#una volta installato il pacchetto
library(rasterdiv)

#facciamo il plot
plot(copNDVI)



