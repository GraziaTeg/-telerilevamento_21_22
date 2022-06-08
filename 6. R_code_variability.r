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
