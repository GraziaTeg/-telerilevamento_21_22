#code for generating land cover maps from satellite imagery
#codice per la generazione di mappe di copertura del suolo da immagini satellitari
library(raster)
library(RStoolbox) #funzioni per la classificazione 
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")
#su Virtuale -> immagini -> defor1_.jpg e defor2_.jpg [del Rio Peixoto = in Brasile]
#immagini del 1992 e 2006 in lab 

brick("defor1_.jpg") 
l92 <- brick("defor1_.jpg")
l92

#NIR = 1
#rosso = 2
#verde = 3 

plotRGB(l92, 1, 2, 3, stretch= "lin")
#1 = NIR = vicino infrarosso = e tutto quello che è diventato rosso è vegetazione

#exercise: import defor2 and plot both in a single window = importa defor2 e traccia entrambi in un'unica finestra
brick("defor2_.jpg")
l06 <- brick("defor2_.jpg")
l06
plotRGB(l06, 1, 2, 3, stretch= "lin")

#par = perchè abbiamo immagini multispettrali 
par(mfrow = c(2, 1))
plotRGB(l92, 1, 2, 3, stretch= "lin")
plotRGB(l06, 1, 2, 3, stretch= "lin")

#altri pacchetti per fare il multiframe 
#making a simple multiframe with ggplot2 = creare un semplice multiframe con ggplot2
?ggplot2
install.packages("ggplot2")
#pacchetto elegante per la visualizzazione dei dati 
library(ggplot2)
#libro gratis di ggplo2

#usiamo funzioni 
#?ggRGB function RStoolbox = con ggRGB {RStoolbox}
#ggRGB(
#  img,
#  r = 3,
#  g = 2,
#  b = 1,
#  stretch = "none",)
ggRGB(l92, 1, 2, 3, stretch = "lin")

#sulla x e y ci sono le coordinate = a immagine non geo referenziate
#utile per plottare in modo speditivo le immagini satellitari 
#e anche multiframe favolori 
ggRGB(l06, 1, 2, 3, stretch = "lin")

#ora come facciamo ad unire le due immagini = con pacchetto 
??patchwork
#molto bello
#io considero il mio plot come se fosse un oggetto e lo assegno a un oggetto = p1
#poi p2 
#e poi faccio la somma p1 + p2

install.packages("patchwork")
library(patchwork)

#associamo i due plot precedenti a un nome = 2 oggetti 
ggRGB(l92, 1, 2, 3, stretch = "lin")
p1 <- ggRGB(l92, 1, 2, 3, stretch = "lin")
p1
ggRGB(l06, 1, 2, 3, stretch = "lin")
p2 <- ggRGB(l06, 1, 2, 3, stretch = "lin")
p2
p1 + p2
#uno accanto all'altro 

#se li voglio uno sopra e uno sotto 
#mettere la divisione 
p1/p2


#la classificazione = classification #unsupervised classification 
?unsuperClass #con C maiuscola 
#unsuperClass(
#  img,
#  nSamples = 10000,
#  nClasses = 5,....)
#nelle nostre imamgini 2/3 classi 

unsuperClass(l92, nClass = 2)
l92c <- unsuperClass(l92, nClasses = 2)
l92c 

dev.off()

#fare plot 
#è un modello e ci leghiamo la mappa che possiamo plottare
plot(l92c$map)
#colori diversi dal prof.
#classe 1 = è la foresta = verde 
#classe 2 = è l'agricoltura + acqua = bianca 
#se si una la funzione di set.seed() 
#la prossima volta che lo apro viene fuori la stessa cosa

#exercise: classify the Landsat image from 2006 classificare l'immagine Landsat del 2006
unsuperClass(l06, nClass = 2)
l06c <- unsuperClass(l06, nClasses = 2)
l06c 
dev.off()
plot(l06c$map)

#frequenza = misura di quante volte avviene un certo evento
#in questo caso i pixel che appartengono alla classe foresta

#frequenza = funzione di chiama freq = frequencies
?freq
#genera delle tabelle di frequenze = quanti pixel ci sono 
#frequenza dei pixel delle due classi 
freq(l92c$map)
#value  count
#[1,]     1  34807
#[2,]     2 306485
#noi abbiamo a disposizione della mappa l92c = 341292 pixel totali 
#di questi = 34807 = appartengono alla classe 1 = agricoltura
#mentre la classe 2 = foresta ha 306485
#diverso dal prof = 305213 foresta classe 1 e 36079 = agricoltura classe 2


################################
library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")

#inserito due immagini = infrarosso nellal componente verde
brick("defor1_.jpg") 
l92 <- brick("defor1_.jpg")
l92
plotRGB(l92, 1, 2, 3, stretch= "lin")
brick("defor2_.jpg")
l06 <- brick("defor2_.jpg")
l06
plotRGB(l06, 1, 2, 3, stretch= "lin")

#mappe
unsuperClass(l92, nClass = 2)
l92c <- unsuperClass(l92, nClasses = 2)
l92c 
dev.off()
plot(l92c$map)
unsuperClass(l06, nClass = 2)
l06c <- unsuperClass(l06, nClasses = 2)
l06c 
dev.off()
plot(l06c$map)

#frequenza
?freq
freq(l92c$map)
#value  count
#[1,]     1  36799 = agricola
#[2,]     2 304493 = foresta
freq(l06c$map)
#value  count
#[1,]     1 179246 = foresta
#[2,]     2 163480 = agricola 
#dai numeri si capisce come è cambiata nel tempo 

#1992
tot92 <- 342192
#proporzione
prop_forest_92 <- 304493 / tot92
prop_forest_92
#[1] 0.8898309
#con %
perc_forest_92 <- 304493 * 100 / tot92
perc_forest_92
#[1] 88.98309 = 89%

#exercise: calculate the percentage of agricultural areasin 1992
#percentuale agricolo 92
#tanti modi 
#1. metodo
perc_agr_92 <- 100 - perc_forest_92
perc_agr_92
#[1] 11.01691

#2. metodo
perc_agr_92_2 <- 36799 * 100 / tot92
perc_agr_92_2
#[1] 10.7539
#i due metodi non mi vengono uguali 

#percent_forest_92 = 88.98309
#percent_agr_92 = 11.01691

#percentuale 2006
tot_06 <- 342726
percent_forest_06 <- 179246 * 100 / tot_06
percent_forest_06
# [1] 52.30009

percent_agr_06 <- 100 - percent_forest_06
percent_agr_06
#[1] 47.69991

#dati finali 
#FINAL DATA:
#percent_forest_92 = 88.98309 = 88.98
#percent_agr_92 = 11.01691 = 11.02
#percent_forest_06 = 52.30009 = 52.30
#percent_agr_06 = 47.69991 = 47.70

#possibilità di creare un dataframe [una tabella]
#con 3 colonne = campo
#1 colonna = classe ==> class = forest e agricoltur
#2 colonna = valori percentuali del 1992 ==> %92
#3 colonna = valori percentuali del 2006 ==> %06

#mettere sempre il punto non le virgole 

#let's build a dataframe with our data = costruiamo un dataframe con i nostri dati
#= costruiamo un dataframe con i nostri dati #columns (fields) = campi 
#class <- Forest, Agriculture #2 elementi dello stesso gruppo = vettore o arrey
#"_" perchè è un testo #evitare simboli
class <- c("Forest, Agriculture") 
percent_1992 <- c(88.98309, 11.01691)
percent_2006 <- c(52.30009, 47.69991)
#dichiarato colonne #ora creare tabella = database = tabella = dataframe
?data.frame
#data.frame e nome delle colonne della tabella
#data.frame(class, percent_1992, percent_2006) #assocciamo a un nome
multitemporal <- data.frame(class, percent_1992, percent_2006)
#analisi multitemporale che conduce alla tabella 
multitemporal
#                class percent_1992 percent_2006
#1 Forest, Agriculture     88.98309     52.30009
#2 Forest, Agriculture     11.01691     47.69991

#valori in formato tabella 
#con la funzione View
View(multitemporal)

#1992
?ggplot
ggplot(multitemporal, aes(x = class, y = percent_1992, color = class)) + geom_bar(stat = "identity", fill = "white")
#a me non viene uguale al prof su RStudio #ma su R viene
#exercise: make the same graph for 2006 = stesso grafico per il 2006
ggplot(multitemporal, aes(x = class, y = percent_2006, color = class)) + geom_bar(stat = "identity", fill = "white")

#fare il pdf = viene salvato nel lab
#1992
pdf("percentages_1992.pdf")
ggplot(multitemporal, aes(x = class, y = percent_1992, color = class)) + geom_bar(stat = "identity", fill = "white")
dev.off()
#2006
pdf("percentages_2006.pdf")
ggplot(multitemporal, aes(x = class, y = percent_2006, color = class)) + geom_bar(stat = "identity", fill = "white")
dev.off()
