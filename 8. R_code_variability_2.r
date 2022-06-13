#r code for calculating spatial variability based on multivariate maps
#r codice per il calcolo della variabilità spaziale sulla base di mappe multivariate 
#in questo caso non andiamo a sceglierci noi una banda, ma andiamo 
#a compattare l'immagine originale su una solo banda
#= PC1 e su quella facciamo il calcolo
library(raster)
library(RStoolbox)
library(ggplot2)

#settaggio
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")
brick("sentinel.png")
siml <- brick("sentinel.png")
siml
#console
#class      : RasterBrick 
#dimensions : 794, 798, 633612, 4  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 798, 0, 794  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : sentinel.png 
#names      : sentinel.1, sentinel.2, sentinel.3, sentinel.4 
#min values :          0,          0,          0,          0 
#max values :        255,        255,        255,        255 

#già elaborata
#ci interessano le prime 3 per la visualizzazione 

#NIR = 1
#Red = 2
#Green = 3

#facciamo un ggRGB
library(ggplot2)
ggRGB(siml, 1, 2, 3)
#eccolo il ghiacciaio del Similaun

#per evidenziare di più le parti a suolo nudo possiamo cambiare
#anche l'ordine
#es. NIR nella parte del verde
ggRGB(siml, 3, 1, 2)
#NIR = verde = sforescente 
#parte suolo nudo = viola
#acqua = scura perché assorbe tutto l'infrarosso 

#Exercise = calsulate a PCA on the image
?rasterPCA
rasterPCA(siml)
simlpca <- rasterPCA(siml)
simlpca

#abbiamo la $call = funzione, $modello, $mappa 
#$call
#$model
#$map

#Exercise: view how much variance is explainde by each PC 
#visualizza quanta varianza viene spiegata da ciascun PC

#fare un summary del modello 
?summary
#spiegazione 
summary(simlpca$model)

#la prima componente spiega solo il 77%
#prime due il 99% insieme
#sono solo le prime tre

#le visualizziamo con il ggplot
#mettere la libreria
library(viridis)
ggplot() + 
  geom_raster(simlpca$map, mapping =aes(x=x, y=y, fill=PC1)) + 
  scale_fill_viridis(option = "inferno") +
  ggtitle("PC1")

#bomba di mappa
#mappa originale = applichiamo la PCA e applichiamo la prima componente
#i valori + alti = vegetale 
#valori + bassi = in altre zone 
#tanta informazione

#proviamo a plottare l'immagine numero 3 
#spiegava da solo solo 0.03% di proporzione della variabilità totaòe 
ggplot() + 
  geom_raster(simlpca$map, mapping =aes(x=x, y=y, fill=PC3)) + 
  scale_fill_viridis(option = "cividis") +
  ggtitle("PC3")
#tanto rumore 
#molta meno informazione rispetto al PC1
ggplot() + 
  geom_raster(simlpca$map, mapping =aes(x=x, y=y, fill=PC3)) + 
  scale_fill_viridis(option = "inferno") +
  ggtitle("PC3")

#plottiama accianto all'altra
#con library 
library(patchwork)
g1 <- ggplot() + 
  geom_raster(simlpca$map, mapping =aes(x=x, y=y, fill=PC1)) + 
  scale_fill_viridis(option = "inferno") +
  ggtitle("PC1")
g3 <- ggplot() + 
  geom_raster(simlpca$map, mapping =aes(x=x, y=y, fill=PC3)) + 
  scale_fill_viridis(option = "inferno") +
  ggtitle("PC3")
g1 + g3 
#la 1 rispetto alla 3
#1 = informazione 

#ora inseriamo anche la seconda componente
#Exercise: insert the second component in the graph
g2 <- ggplot() + 
  geom_raster(simlpca$map, mapping =aes(x=x, y=y, fill=PC2)) + 
  scale_fill_viridis(option = "inferno") +
  ggtitle("PC2")
g1 + g2 + g3
#1 = 77%
#2 = 30% circa = anche questa ha molto informazione
#le varie componenti non sono mai correlate tra di loro 


#facciamo il calcolo della variabilità #let's calculate variability
#creiamo un nuovo oggetto 
pc1 <- simlpca$map[[1]]

sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd) #applico una finestra mobile di 3*3
sd3

#plottiamo 
plot(sd3)

#ora facciamo un plot con ggplot
ggplot() + 
  geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis(option = "inferno") +
  ggtitle("Standard deviation of PC1")

#la mappa di più alta variabilità possibili
#indica qui punti dove c'è una discontinuità più forte 
#dove ci sono i crepacci, variazioni di un tipo generale e un altro
#più è di + sulla parte geomorfologica

#la volta scorsa abbiamo utilizzato la banda dell'infrarosso
#per fare il calcolo
#questa volta come tutte quelle volte nelle quali possiamo utilizzare 
#una sola variabile = una sola banda 
#questa volta abbiamo utilizzato la PC1

#questi metodi di analisi multivariata servono proprio per compattare
#dati = quindi li possiamo applicare anche da dati tabellari di qualsiasi natura
#c'è un pacchetto che si chiama VEGAN 
#e ordinano i dati 





