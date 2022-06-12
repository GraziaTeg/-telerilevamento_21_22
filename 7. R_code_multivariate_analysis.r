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

#fare il plot
plot(p224r63_2011)
#vediamo le bande che abbiamo a disposizione 
#7 bande dall'immagine Landsat #banda 6 = con l'infrarosso termico 
#sarebbe 6.1 e 6.2 = alla fine 8 immagini #qui la 6 già compattate = quindi ne ho 7
#riflettanza in 7 bande

#aggregate cells: resampling (ricampionamento) 
#= celle aggregate: ricampionamento (ricampionamento)
#fact = fator = lavora linearmente 10*10 = 100 pixel tutti insieme 
aggregate(p224r63_2011, fact = 10)
p224r63_2011res <- aggregate(p224r63_2011, fact = 10)
#p224r63_2011res = res = resampling
p224r63_2011res

#ci vuole un pò #perché deve ricampionare tutto 

#possiamo fare il ggplot2
#mettere le librerie
library(ggplot2)
library(patchwork)

#usiamo bande infrarosso, rosso e verde = 4, 3, 2
ggRGB(p224r63_2011, 4, 3, 2)
g1 <- ggRGB(p224r63_2011, 4, 3, 2)
g1
ggRGB(p224r63_2011res, 4, 3, 2)
g2 <- ggRGB(p224r63_2011res, 4, 3, 2)
g2
g1 + g2

#immagine una vicino all'altra 
#si vede bene che 
#a sinistra la risoluzione dell'immagine è più alta di quella a destra
#a destra = un pò più sfumata
#sinistra = più nel dettaglio 

#il pattern è lineare = il fattore di cambiamento #fattore iniziale 30*30 
#con il campionamento (resampling) la risoluzione nuova è di 300*300
#con un fattore 10 compattiamo 10 pixel 

#se voglio con un fattore di 100*100
#resampling più aggressivo 
#aggressive resamplig con fattore 100
aggregate(p224r63_2011, fact = 100)
p224r63_2011res100 <- aggregate(p224r63_2011, fact = 100)
p224r63_2011res100

#rifacciamo il ggRGB
ggRGB(p224r63_2011, 4, 3, 2)
g1 <- ggRGB(p224r63_2011, 4, 3, 2)
g1
ggRGB(p224r63_2011res, 4, 3, 2)
g2 <- ggRGB(p224r63_2011res, 4, 3, 2)
g2
ggRGB(p224r63_2011res, 4, 3, 2)
g3 <- ggRGB(p224r63_2011res100, 4, 3, 2)
g3
g1 + g2 + g3
#sx = 30*30
#mezzo = 300*300
#dx = 100*100 = 3000*3000 pixel [100 * 30 pixel]
#dx = campionato in modo pesantina = perchè è stata ricampionata


#06.05.22
#Analisi multivariata = ci serve per compattare un set
#in un numero inferiore di bande
#e poter calcolare su una sola di queste la variabilità spaziale 
#= analisi di quella che è la variabilità basandosi su quella che è 
#PCA

#su git hub

#riassunto puntata precedente

#libreria
library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)

#settaggio cartella di lavoro
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")

#immagine 
brick("p224r63_2011_masked.grd") 
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
plot(p224r63_2011)
#immagine pesante per calcolare una PCA sopra
#allora utilizziamo il comando aggregate che fa un resamplit
#il resampling
#--> abbiamo l'immagine originale, diamo un certo fattore
#e andiamo a creare una nuova immagine sulla quale fare un calcolo
#il fattore è lineare,
#se io metto un fattore di ricampionamento pari a 10 
#= prendo delle finestre = 10*10 pixel e all'interno calcolo un valore medio 
#e così possono ricampionare l'immagine con una risoluzione inferiore 
#per esempio 

?aggregate 
aggregate(p224r63_2011, fact = 10)
p224r63_2011res <- aggregate(p224r63_2011, fact = 10)
p224r63_2011res
ggRGB(p224r63_2011, 4, 3, 2)
g1 <- ggRGB(p224r63_2011, 4, 3, 2)
g1
ggRGB(p224r63_2011res, 4, 3, 2)
g2 <- ggRGB(p224r63_2011res, 4, 3, 2)
g2
g1 + g2

#poi lo abbiamo fatto con il fattore 100
aggregate(p224r63_2011, fact = 100)
p224r63_2011res100 <- aggregate(p224r63_2011, fact = 100)
p224r63_2011res100
ggRGB(p224r63_2011, 4, 3, 2)
g1 <- ggRGB(p224r63_2011, 4, 3, 2)
g1
ggRGB(p224r63_2011res, 4, 3, 2)
g2 <- ggRGB(p224r63_2011res, 4, 3, 2)
g2
ggRGB(p224r63_2011res, 4, 3, 2)
g3 <- ggRGB(p224r63_2011res100, 4, 3, 2)
g3
g1 + g2 + g3


#ora facciamo la PCA con l'immagine ricampionata [media di tutti i valori interni]
#la funzione si chiama #rasterPCA #funzione del RStoolbox
?rasterPCA #andiamo a utilizzare

#PCA Analysis #PCA scritto in maiuscolo
#immagine quella che finiva con res
rasterPCA(p224r63_2011res)
p224r63_2011respca <- rasterPCA(p224r63_2011res)
p224r63_2011respca

#ora noi abbiamo fatto la PCA 
#abbiamo creato un oggetto da un modello
#crea una mappa, variazioni [quanta variazione spiega una banda], serie di tabelle 

#con il dollaro [$] crea:
#1. $call --> la funzione che abbiamo fatto partire 
#= rasterPCA con l'immagine
#2. $model = modello --> stessa cosa della classificazione
# ci sono tutte le varibilità spiegate dalle varie componenti 
#standard deviation
#3. $map = mappa --> 
#4. tipo di classe che è 

#come sapere le informazioni legate al modello 
#con la funzione summary per avere tutte le statistiche in uscita
?summary
#Object Summaries
#= riassunto per ogni oggetto che abbiamo creato 
#in questo caso un modello

#ha creato:
#$call
#$model
#$map

#summary del modello 
summary(p224r63_2011respca$model)

#importanza delle varie componenti 
#7 componenti = alle 7 bande
#c'è una propozione della varianza = quanta variabilità viene spiegata 
#da ogni singola componente
#PC1 = abbiamo il 99,83% della variabilità = tutta l'informazione 
#PC2 = 0.14%, ....
#la proporzione accumulata = la prima 0.99 + la seconda 
#fino ad arrivare alla 7 che abbiamo 1 

#fare plot = per vedere tutte le componenti 
plot(p224r63_2011respca$map)


