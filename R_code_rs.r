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
#plottato con tutte le bande

#se non fa il grafico mettere dev.off() -> per un problema di grafica = ripulire tutto 
dev.off()

#18.03.22
#Banda dalla 1 alla 4
#Landsat ETM+ [Enhanced Thematic Mapper Plus]
#b1 = blu
#b2 = verde
#b3 = rosso 
#b4 = infrarosso vicino = NIR 
 
#possiamo fare un plot con le immagine singole e poi tutte insieme 
#noi abbiamo fatto una colorRampPalette (sopra) e poi abbiamo plottato tutte le immagini
#satellitari  = tutte le bande con quella colorRampPalette

#ora plottiamo una singola banda
#plot della banda del blu [solo una] - B1_sre

#qual è la prima banda? 
#si mette 
l2011
#si va a vedere i nomi della prima banda, in names
#B1_sre = spectral reflectance
#il simbolo che lega l'immagine satellitare [l2011] alla banda [B1_sre] è il DOLLARO $
plot(l2011$B1_sre)

#or
#un altro modo 
#questa volta andiamo a prendere il primo elemento 
#e si racchiude in doppia parentesi [[]]
plot(l2011[[1]])
#elemento numero 1 = banda blu

#legenda non ci piace rimettiamo la palette di prima 
#colorRampPalette(c("black", "grey", "light grey")) (100)
#con anche 
cl <- colorRampPallette(c("black", "grey", "light grey")) (100) 
#quindi prendiamo 
plot(l2011$B1_sre)
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(l2011$B1_sre, col = cl) #col = colorare 

#plot b1 da dark blu a blu a light blu 
l2011
plot(l2011$B1_sre)
clblue <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(l2011$B1_sre, col = clblue)


#let's export the image and let it appear in the lab folder: kind of magic
#esportiamo l'immagine e facciamola apparire nella cartella lab: sorta di magia
#la funzione si chiama pdf = es banda1.pdf
#pdf(banda1.pdf) = mancano le "_" perché usciamo da R = path = percorso 
pdf("banda1.pdf")
plot(l2011$B1_sre, col = clblue)

dev.off()

#come facciamo a far capire che vogliamo salvare nella cartella lab
#perchè all'inizio abbiamo settato la cartella di lavoro
#set working directory, con tutto il percorso 
#se lo vogliamo dentro un'altra cartella = cambiando il path mettiamo
#per esempio
#pdf("~/Downloads/banda1.pfd")
#senza specificare il path = percorso va dentro alla cartella lab






