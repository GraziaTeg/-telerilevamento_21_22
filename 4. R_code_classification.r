
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







