#SDM
#modelli di distribuzioni di specie 
#realizzare variabili in funzioni di altre variabili 
#dati di distribuzione 
#dati a terra + dati vintuali = distribuzione specie nello spazio 
#scopi prevedere e capire com'è la distribuzione 
#pacchetto che si chiama sdm 

#R code for specie distribution modelling
#Codice R per la modellazione della distribuzione delle specie
#installiamo il pacchetto sdm
install.packages("sdm")
install.packages("rgdal", dependencies = T)
#pacchetti 
#raster = dobbiamo gestire dei dati spaziali e geografici
library(raster)#predictors
library(rgdal) 
library(sdm) #specie
library(ggplot2)
library(patchwork)
library(viridis)

#?rgdal #= libreria 
#non utiliziamo il file della woking directory
#ma un file sistem direttamente dalla libreria
?system.file
file <- system.file("external/species.shp", package="sdm") 
#nella cartella external con file species 
file
#fa vedere il percorso 

?shapefile
species <- shapefile(file)
species

#SpatialPointsDataFrame = punti nello spazio 
#ce ne sono 200
#Occurrence = presenza o assenza di una certa specie 

plot(species)
#vediamo dei punti nello spazio 
#cambiamo carattere = 19 punti chiusi 
plot(species, pch=19)

#facciamo un plot con le presenze o assenze
#con nome occurrence
species$Occurrence
#i 200 valori di 0 e 1

#plottiamo il database specie 
#subset = []
#vogliamo solo dove compare 1
occ <- species$Occurrence
#lo assegnamo a un oggetto 
#uguale ==
plot(species[occ == 1,], col="blue", pch=19)
#vengono fuori solo i 1 con i colori blu

#uniamo i punti uguale a 0 = li aggiungiamo con il points
points(species[occ == 0,], col="red", pch=19)
#con points ho aggiunto 
#1 = presenze = blu = dove ho visto la specie 
#2 = assenze = rosso 

#andiamo a vedere i predittori [fattori climatici]
#facciamo una lista di file, con un certo pattern

#1. mettere il path = percorso 
path <- system.file("external", package="sdm")
path

#list the predictors
list.files(path=path, pattern='asc', full.names=T)
lst <- list.files(path=path, pattern='asc', full.names=T)
lst

#full.names is needed in case you want to maintain the whole
#path in the name of the file 
#full.names è necessario nel caso in cui desideri 
#mantenere l'intero percorso nel nome del file

stack(lst)

#plottiamo con una colorRampPalette
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
preds <- stack(lst)
plot(preds, col=cl)

#4 bande = con elevation, precipitation, temperature, vegetation

# plot of predictors with presences
elev <- preds$elevation
prec <- preds$precipitation
temp <- preds$temperature
vege <- preds$vegetation

#plot con le presenze 
#elevation
plot(elev, col=cl)
points(species[occ == 1,], pch=19)

#tempemperature
plot(temp, col=cl)
points(species[occ == 1,], pch=19)

#precipitation
plot(prec, col=cl)
points(species[occ == 1,], pch=19)

#vegetation
plot(vege, col=cl)
points(species[occ == 1,], pch=19)

#MODEL
#dati
#dichiarare quali sono i dati del modellino sdm
#specie + predittori 
?sdmData
#train = dati a terra
#predittori = quali sono
datasdm <- sdmData(train=species, predictors=preds)
datasdm

?sdm
#alt + 126 = ~
sdm(Occurrence ~ elevation + 
      precipitation + temperature + vegetation, data=datasdm, methods="glm")
m1 <- sdm(Occurrence ~ elevation + 
      precipitation + temperature + vegetation, data=datasdm, methods="glm")
m1

#andiamo a fare la predisione 
?predict 
#Model Predictions
predict(m1, newdata=preds)
p1 <- predict(m1, newdata=preds)
p1

#plottiamo = output
plot(p1, col=cl)
#aggiungiamo il points
points(species[occ == 1,], pch=19)

#mappa di previsione della nostra previsione della specie 
#nei punti = ci c'è la specie a terra

#par
par(mfrow=c(2,3))
plot(p1, col=cl) #predict
plot(elev, col=cl)
plot(prec, col=cl)
plot(temp, col=cl)
plot(vege, col=cl)
#nostro modello rispetto a tutti i parametri 

#alternative #2
final <- stack(preds, p1)
plot(final, col=cl)
#mette anche i nomi 
