
#classifichiamo gli oggetti per vedere se si riesce a vedere arbusti, alberi, zone agricole,...

#installare il pacchetto RStoolbox
library(raster)
install.packages("RStoolbox")
library(RStoolbox)

#salvata dentro la cartella lab 
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")

#quindi a classificare questa immagine 
#recuperiamo questa immagine 
#molto lungo il nome perché così posso andarla a rintracciare 
#messa in lab 
#il nome è Solar_Orbiter_s_first_views_of_the_Sun_pillars
#clssificazione 

#data import
brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#diamo il nome so = solar orbiter
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
so

#faccio un plotRGB
plotRGB(so, r = 1, g = 2, b = 3, stretch ="lin")
#proviamo anche con lo stretch non lineare
plotRGB(so, r = 1, g = 2, b = 3, stretch ="hist")

#classifying the solar data
?unsuperClass
unsuperClass(so, nClasses = 3)
soc <- unsuperClass(so, nClasses = 3)
soc

#plottiamo i risultati con soc
cl <- colorRampPalette(c("yellow", "black", "red")) (100)
plot(soc$map, col = cl) 

#questa è uguale a quella del prof
cl <- colorRampPalette(c("red", "yellow", "black")) (100)
plot(soc$map, col = cl) 

#set.seed can be used for repeating the experiment in the same manner for N times
?set.seed


##################################
#CLASSIFICAZIONE 
#come passare da dati continui a classi mineralogiche 
#algoritmo di classificazione 
#serve per individuare le differenze di composizione mineralogiche 
#della classificazione mineralogica del Grand Canyon
library(raster)
library(RStoolbox)
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")

#scorsa volta con immagini del sole 
#con vari livelli energeti di gas

#oggi GRAND CANYON
#importiamo le immagini 
brick("dolansprings_oli_2013088_canyon_lrg.jpg")
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg") 
gc #Grand Canyon

#rosso = 1
#verde = 2
#blu = 3
plotRGB(gc, r = 1, g = 2, b = 3, stretch ="lin")
#differenza della roccia, nuvole, acqua

plotRGB(gc, r = 1, g = 2, b = 3, stretch ="hist")
#non cambia i dati 



#classificazione
?unsuperClass
#unsupervised = non supervisionata = e cerca te i gruppi 
#immagine, numero di campioni se vogliamo e numero di classe
#ognuno li ha diversi 

unsuperClass(gc, nClasses = 2)
gcclass2 <- unsuperClass(so, nClasses = 2) #gc della classe 2
gcclass2

plot(gcclass2$map)
#pixel random
#classe 1 verde = corrisponde a tutta la parte che c'è di roccia
#parte 2 bianca = corrisponde all'acqua, ombre, + differenziazione roccia,...

#metto insieme per un confronto
par(mfrow = c(2, 1))
plotRGB(gc, r = 1, g = 2, b = 3, stretch ="lin")
plot(gcclass2$map)
 
#per mantenere la stessa si mette la funzione = set.seed()
#es
?set.seed
#set.seed(17)

#ora andiamo con un numero differenti di classi 
#esercizio = classifichiamo la mappa con 4 classi = classify the map with 4 classes
unsuperClass(gc, nClasses = 4)
gcclass4 <- unsuperClass(gc, nClasses = 4)
gcclass4
plot(gcclass4$map)

#mappa con 4 classi 
par(mfrow = c(2, 1))
plot(gcclass4$map, col = cl)
plotRGB(gc, r = 1, g = 2, b = 3, stretch ="hist")

#li cambiamo i colori 
cl <- colorRampPalette(c("yellow", "red", "blue", "black")) (100)
par(mfrow = c(2, 1))
plot(gcclass4$map, col = cl)
plotRGB(gc, r = 1, g = 2, b = 3, stretch ="hist")
