#04.03.22
# Questo è il primo script che useremo a lezione

#prima funzione che useremo
#richiamiamo la libreria raster
library(raster)

#10.03.22
#richiamiamo la libreria raster
#installazione
#install.packages("raster")[apriamo le virgolette perchè siamo usciti da R]
library(raster)

#Settaggio cartella di lavoro = selezionato cartella di lavoro = LAB 
#setwd("~/lab/") #linux
#setwd("/User/utente/lab") #mac
setwd("C:/lab/") #windows = miio sistema operativo 

#import
#per importare un pacchetto di dati esiste una funzione in R
#la funzione per importare tanti dati in R si chiama BRICK
#come si usano le funzioni su R
brick("p224r63_2011.grd") #funzione per importare interi pacchetti di dati, cioè un'immagine satellitare
#poi l'assegnamo all'oggetto
l2011 <- brick("p224r63_2011.grd")
#dopo aver importato i dati = diamo il nome l2011 e usciranno tutte le informazioni 
l2011
#questa immagine [p224r63_2011.grd] era relazionata a satellite Landsat
#Landsat = uso più antico usato da tutti, immagini gratuite, con un percorso che segue la rotazione terrestre = 
#con un percorso che si chiamano path = p, con percorsi e visualizzazione di tutto il pianeta
#se rappresentassimo questi percorsi in due dimensioni = sinusoidi = riportando il percoso piano = path con numerino e poi 
#dividiamo in righe = row ==> battagli navale 
#la nostra immagine si trova in Parakana, in cui c'è stato un forte disboscamento 

#plot
plot(l2011)

#per cambiare il colore della leggenda
#al seguente link: https://www.r-graph-gallery.com/42-colors-names.html
colorRampPalette()
colorRampPalette(c("black", "grey", "light grey"))
#abbiamo un passaggio graduale non è netto 
#quante ne vogliamo?? = quanti numeri di passaggio = con 100 colori 
colorRampPalette(c("black", "grey", "light grey")) (100)
#diamo un nome 
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
#nella funzione plot = l'argomento da inserire come colore = col
plot(l2011, col = cl)

#se non fa il grafico mettere dev.off() -> per un problema di grafica = ripulire tutto 
dev.off()

#18.03.22

