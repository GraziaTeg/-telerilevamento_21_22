#R_code_variability

library(raster) 
library(RStoolbox) #for image viewing and variability calculation 
#per la visualizzazione delle immagini e il calcolo della variabilità
library(ggplot2) #for ggplot plotting

#Exercise: import the Similaun image

brick("sentinel.png")
sen <- brick("sentinel.png")
sen
#4 bande disponibili 

#Exercise: plot the image by the ggRGB function = con funzione ggRGB
#plottiamo con infrarosso [1 banda] = nella componente 1
ggRGB(sen, 1, 2, 3, stretch = "lin")
#con ggRGB = possiamo anche non mettere lo stretch [possiamo utilizzare + valori]
ggRGB(sen, 1, 2, 3)

#ora infrarosso nella componente green 
ggRGB(sen, 2, 1, 3)
#diventa verde e viola #si vede bene le parti di bosco, crepacci, nevi

#Exercise: plot the two graphs one beside the other = uno accanto all'altro 
#con il pacchetto patchwork
#possiamo unire questi due grafici
library(patchwork)

#plottarli uno accanto all'altro 
#ggRGB(sen, 1, 2, 3)
#ggRGB(sen, 2, 1, 3)
ggRGB(sen, 1, 2, 3)
g1 <- ggRGB(sen, 1, 2, 3)
g1
ggRGB(sen, 2, 1, 3)
g2 <- ggRGB(sen, 2, 1, 3)
g2
g1 + g2 


#la funzione si chiama focal
#per fare un calcolo dalle media
?focal
#su una singola variabile = dei vari layer ne dobbiamo scegliere 1
#NIR oppure indice spettrale [NDVI]

#calculation of variability over NIR = calcolo della variabilità rispetto al NIR
nir <- ser[[1]]
nir 
#prima banda 

#faccio il plot nir
plot(nir)

#funzione focal in #?focal
#= immagine per calcolare la variabilità è NIR e poi mettere la matrice

#definiamo la matrice = è formata da 3 per 3 pixel = 1 su 9 pixel  
#funzione = fun = è la deviazione standard
focal(nir, matrix(1/9, 3, 3), fun = sd)
sd3 <- focal(nir, matrix(1/9, 3, 3), fun = sd)
#sd = standard deviation
sd3
#faccio il plot
plot(sd3)

#abbiamo fatto una colorRampPalette
clsd <- colorRampPalette(c("blue", "green", "pink", "magenta", "orange", "brown", "red", "yellow")) (100)
plot(sd3, col = clsd)

#luoghi a più bassa variabilità 
#ci aspettiamo che siano quelli con roccia compatta (senza crepacci = blu)
#quelli con acqua 
#quelli con variabilità alta = bordi = rossi = zona a più alta variabilità
#la neve = molto compatta crepacci molto forti 
#tra crepaccio = tra roccia e ombra 

#installo in pacchetto viridis
install.packages("viridis")
library(viridis)
#facciamo il plot con ggplot #e vidivis
#il ggplot delle immagini = del singolo raster = un pò più complesso del ggRGB
#ggplot = come funzione apre solo un plot vuoto
#ggplot = che apre al suo interno un ggplot vuoto 
ggplot() + 
  geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer))
#geom_raster = quadrati = una serie di pixel 
?geom_raster
#immagine = sd #estretic = aes = sono la x, la y e il colore che vogliamo dare 
#in questo caso essendo un raster dobbiamo inserire un argomento = mapping

#si vedono benissimo i crepacci = zone chiare
#zone di variazione = linee di demarcazione tra bosco e prateria 

#andiamo a vedere altre colorazioni 
#il pacchetto viridis

#https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
#l'idea è che alcuni codici non possono essere visualizzati da tante persone 
#per esempio i daltonici = creare legende che sono create per vederli tutti 
#legente usate molto è la legenda viridis, vividis, magna 
#andiamo a provarle = è quella di vivridis 
#con la funzione che si chiama #scale_fill_viridis() 
#lo aggiungiamolo al ggplot
ggplot() + 
  geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis() +
  ggtitle("Standard deviation by viridis")

#funziona ma bisogna richiamare il pacchetto viridis
#ggtitle = gli diamo un titolo
#ggplot = dove le zone a più alta variabilità sono di quel colore giallo chiaro 
#zone di transizione tra foresta e prateria

#per cambiare la legenda 
#dentro alla ggplot mettiamo una funzione che si chiama 
#usaiamo cividis = con la funzione cividis
ggplot() + 
  geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis(option = "cividis") +
  ggtitle("Standard deviation by viridis")

#cambiato legenda #simile ma diminuisce la gamma dei colori scuri 
#oppure magma 
ggplot() + 
  geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis(option = "magma") +
  ggtitle("Standard deviation by viridis")

#magma = frutta anche i colori intermedi 

#noi abbiamo utilizzato la finestra 3*3 = possiamo anche aumentare
#la finestra come 5*5, 7*7, 9*9,...

#exercise: make the same calculation with a 7x7 window = fare lo stesso calcolo con una finestra 7x7
##fare lo stesso calcolo con una finestra 7x7
#7 * 7 = 49
#sd = deviazione standard

#jamboard [4]

#il problema è che non si mette la FUNZIONE COME L'OGGETTO 
#sd = sd 
#ora correggere tutto il nome con sd3 tranne nella fun sd

#riprendiamo prossima volta

#16
#03.05.22

#misura dell'eterogeneità #es foresta tropicale = ogni piante ricerca le proprie risorse [in luce e acqua]
#queste zone eterogeneità al massimo #etoregeneità più alta dove ci sono più specie in un certo ambiente
#ognuna ha una propria riflettanza #eterogeità dall'alto #eterogenità = deviazione standard

#sentinel = ghiacciaio del Similaun
#acqua assorbe molto l'infrarosso 

#immagini salvate la scorsa volta
#guardare la cartella 15. 29.04.22
#usiamo ggplot
library(raster) 
library(RStoolbox) # for image viewing and variability calculation
library(ggplot2) # for ggplot plotting +anche ggRGB
library(patchwork)# multiframe with ggplot2 graphs
library(viridis)

setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")
brick("sentinel.png")
sen <- brick("sentinel.png")
sen
#banda 1 = NIR
#banda 2 = red
#banda 3 = green
ggRGB(sen, 1, 2, 3, stretch = "lin")
ggRGB(sen, 1, 2, 3)
g1 <- ggRGB(sen, 1, 2, 3)
g1
#NIR nella parte green 
#vegetazione = verde
ggRGB(sen, 2, 1, 3)
g2 <- ggRGB(sen, 2, 1, 3)
g2
library(patchwork)
#immagini uno accanto all'altro 
ggRGB(sen, 1, 2, 3)
g1 <- ggRGB(sen, 1, 2, 3)
g1
ggRGB(sen, 2, 1, 3)
g2 <- ggRGB(sen, 2, 1, 3)
g2
g1 + g2
#exercise: plot one graph on top of the other = uno sopra all'altro 
g1/g2
#oppure
(g1+g2)/(g1+g2)
#12 e 12

#calculation of variability over NIR
#NIR = primo elemento dell'immagine Sentinel 
nir <- sen[[1]]
nir
plot(nir)

#focal 
#finesta
?focal
focal(nir, w=matrix(1/9, 3, 3), fun = sd)
sd3 <- focal(nir, matrix(1/9, 3, 3), fun = sd)
sd3
plot(sd3)
clsd <- colorRampPalette(c("blue", "green", "pink", "magenta", "orange", "brown", "red", "yellow")) (100)
plot(sd3, col = clsd)

#ora ggplot
#prima vuoto 
#ggplot() + geome_raster(sd3, mapping = aes(x=x, y=y, fill = layer))
#estetiche = parametri per mappare la carta
#install.packages("viridis")
library(viridis)
ggplot() + 
  geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer))
?viridis
ggplot() + 
  geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis() +
  ggtitle("Standard deviation by viridis")
#con cividis
ggplot() + 
  geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis(option = "cividis") +
  ggtitle("Standard deviation by viridis")
#magma
ggplot() + 
  geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis(option = "magma") +
  ggtitle("Standard deviation by viridis")
#inferno
ggplot() + 
  geom_raster(sd3, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis(option = "inferno") +
  ggtitle("Standard deviation by viridis")
#inferno lavora moltissimo sulla differenza dei massimi e oscura di più il minimo
#immagine perfetta per la misura della variabilità

#se aumentiamo la finestra a 7
#exercise. make tha same calculation with a 7*7 window
#focal(nir, w=matrix(1/49, 7, 7), fun = sd)
#sd7 <- focal(nir, matrix(1/49, 7, 7), fun = sd)
#sd7
#plot(sd7)
#clsd <- colorRampPalette(c("blue", "green", "pink", "magenta", "orange", "brown", "red", "yellow")) (100)
#plot(sd7, col = clsd)

#ora non lo facciamo 
