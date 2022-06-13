#19.05.22
#ripasso scorsa volta
#eterogeneità in una certa immagine
#perchè calcolare l'eterogeneità?
#è relazionata alla biodiversità maggiore è la diversità in termini spettrali 
#maggiore sarà la presenza di tante nicchie diverse presenti in varie specie, 
#laghi, prateria, bosco, ....
#+ è eterogeneo il segnale + sarà la biodiversità in una certa area
#+ #da un punto di vista geologico = maggiore sono le diversità 
#+ #geomorfologiche del terreno 
#+ #es. fratture, frane,... maggiore sarà l'eterogeneità a livello 
#+ #di misura del satellite nel sensore

#R code variability 3 - using PC components
library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)
library(viridis)

setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")

#importare immagine 
#con la funzione brick = importa un intero pacchetto di dati 
brick("sentinel.png")
sen <- brick("sentinel.png")
sen
#ci sono 4 livelli = ne utilizziamo 3 
#NIR = 1
#red = 2
#green = 3

#utilizziamo ggplot per fare ggRGB
#stretch in aumtomatico
#mettere la libreria
library(ggplot2)
ggRGB(sen, 1, 2, 3)

#Exercise: visualize the image such as vegetation becomes green (fluo!)
#in modo che la vegetazione diventi verde fluo e suolo nudo viola
#metto il NIR sulla componente verde
ggRGB(sen, 3, 1, 2)

#colori astrazione del nostro cervello 

#di questa immagine dobbiamo astrarre un solo layer 

#ora passiamo da tre layer (NIR, RED E GREEN) a un layer solo che sarà 
#la prima componente principale 
#compattando tutta l'informazione in un unico layer
#con la funzione rasterPCA
#tanti tipi di analisi multivariata
#multivariate analysis
?rasterPCA
rasterPCA(sen)
sen_pca <- rasterPCA(sen)
sen_pca

#ci sono tanti gruppi 
#già successo con la classificazione 

#ci sono vari pezzi che si legano alla PCA con il $
#$call = la funzione utilizzata
#$model = modello che andiamo a utilizzare  
#$map = quello che noi andiamo a utilizzare
#attributi = con funzione e pacchetto 

#facciamo una summary del modello 
?summary
#quanta variabilità spiega questa PCA con la prima componente
summary(sen_pca$model)
#console
#Importance of components:
#  Comp.1     Comp.2
#Standard deviation     77.3362848 53.5145531
#Proportion of Variance  0.6736804  0.3225753
#Cumulative Proportion   0.6736804  0.9962557
#Comp.3 Comp.4
#Standard deviation     5.765599616      0
#Proportion of Variance 0.003744348      0
#Cumulative Proportion  1.000000000      1

#la prima componente con la proportional = spiega il 
#1 = 0.67
#2 = 0.32 
#3 = 0.003
#ce ne bastano 2 per spiegare il 99.62%

#plottiamo la mappa 
#facciamo con il default
plot(sen_pca$map)
#abbiamo le 3 bande più quella di controllo la 4 
#4 = banda vuota
#la PC1 = spiega gran parte della variabilità 
#= c'è informazione
#la PC3 = è solo rumore = non c'è informazione praticamente

#ora con ggplot = dei pannelli con i vari componenti

#ggplot = vediamo come si usa
#ggplot vuoto = solitamente per i raster si fa così
#+ la geometri raster [ci sono varie funzioni]
#plottiamo la prima componente della PCA = PC1 oppure il [[1]] = 1 elemento 
sen_pca$map
#devo tutti i valori che mi servono 
pc1 <- sen_pca$map$PC1
pc2 <- sen_pca$map$PC2
pc3 <- sen_pca$map$PC3
#aes = aestetics 
#fill = si chiama PC1 
ggplot() + 
  geom_raster(pc1, mapping =aes(x=x, y=y, fill=PC1)) 

#abbiamo la prima componente

#ora possiamo plottare le 3 componenti una accanto all'altra
#con il pacchetto patchwork
library(patchwork)
?patchwork
#ggplot() + 
#  geom_raster(pc1, mapping =aes(x=x, y=y, fill=PC1)) 
#assegnamo il nome a questo ggplot
g1 <- ggplot() + 
  geom_raster(pc1, mapping =aes(x=x, y=y, fill=PC1)) 
g2 <- ggplot() + 
  geom_raster(pc2, mapping =aes(x=x, y=y, fill=PC2)) 
g3 <-ggplot() + 
  geom_raster(pc3, mapping =aes(x=x, y=y, fill=PC3)) 
#uniamo = vediamo una accanto all'altra 
g1 + g2 + g3

#vediamo tutte le componenti principali a disposizione
#1 = + informazioni
#2 = informazioni
#3 = molto omogenea = rumore


#facciamo il calcolo della variabilità su una delle componenti 
#su quella che spiega la maggior parte della variabilità del sistema

#calcolo
#della deviazione standard della PC1
#Standard deviation of PC1
?focal
#finestra di 3*3
#definire le variabili prima 
focal(pc1, matrix(1/9, 3, 3), fun = sd)
sd3 <- focal(pc1, matrix(1/9, 3, 3), fun = sd)
sd3

#fatto il calcolo della Standard Deviation e abbiamo applicato il calcolo 
#rasterLayer = tirato fuori una mappa
plot(sd3)

#map by ggplot the standar deviation of the first principal component
ggplot() + 
  geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) 
#fill = si guarda il name della mappa 
#si vede bene la differenziazione che c'è nei crepacci del suolo nudo 
#tra l'immagine originale si devono bene le differenza

#mettere il pacchetto viridis
#inferno molto bella 
#utilizziamo viridis è quello di default
library(viridis)
ggplot() + 
  geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option = "viridis") +
  ggtitle("Standard deviation of PC1")
#cividis
ggplot() + 
  geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option = "cividis") +
  ggtitle("Standard deviation of PC1")
#piu in giallo 
#inferno = + bella
ggplot() + 
  geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option = "inferno") +
  ggtitle("Standard deviation of PC1")
#zone a più alta variabilità/etergeneità vengono fuori 

#plottiamo tutto insieme le varie immagini 
#images altogether
#imamgine inziale quella con ggRGB con il NIR nel verde
#ggRGB(sen, 2, 1, 3)
im1 <- ggRGB(sen, 2, 1, 3)
#con anche la prima componente principale 
#g1 e mettiamo im2
im2 <- ggplot() + 
  geom_raster(pc1, mapping =aes(x=x, y=y, fill=PC1)) 
#poi plot con inferno = im3
im3 <- ggplot() + 
  geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option = "inferno") +
  ggtitle("Standard deviation of PC1")

#con patchwork
im1 + im2 + im3 

#uniamo le tre immagini 
#1 = immagini originale = RGB
#2 = PC1 con il calcolo della standandar deviation
#3 = standandar deviation = quello che è in uscita
#sulla legenda inferno di viridis


######
#Calculate heterogeneity in a 5*5 window
#5*5 = 25 = ogni pixel è 1/25
focal(pc1, matrix(1/25, 5, 5), fun = sd)
sd5 <- focal(pc1, matrix(1/25, 5, 5), fun = sd)
sd5

plot(sd5)
ggplot() + 
  geom_raster(sd5, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option = "inferno") +
  ggtitle("Standard deviation of PC1")

#mappatura variabilità in una finestra di 5*5
#è venuto un pò più grande 

#insieme
im4 <- ggplot() + 
  geom_raster(sd5, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option = "inferno") +
  ggtitle("Standard deviation of PC1")

im3 + im4
#im3 = 3*3
#im4 = 5*5
#è più zoomata
#variabilità più grande nella 5*5 = perché ho aumentato la finestra di calcolo

#se facciamo un calcolo 7*7
sd7 <- focal(pc1, matrix(1/49, 7, 7), fun = sd)
sd7
ggplot() + 
  geom_raster(sd7, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option = "inferno") +
  ggtitle("Standard deviation of PC1")
im5 <- ggplot() + 
  geom_raster(sd7, mapping =aes(x=x, y=y, fill=layer)) +
  scale_fill_viridis(option = "inferno") +
  ggtitle("Standard deviation of PC1")

im3 + im4 + im5
#im3 = 3*3
#im4 = 5*5
#im5 = 7*7
#ancora più zoomata 
#effetto simil-sfuocato 
#ma la variabilità è maggiore
