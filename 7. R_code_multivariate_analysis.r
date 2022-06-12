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



