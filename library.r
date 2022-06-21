#All'inizio sempre l'installazione e i pacchetti:

#installazione pacchetti 
install.packages("raster")
install.packages("Rstoolbox")
install.packages("ggplot2")
install.packages("patchwork")
install.packages("viridis")
install.packages("lidR")
install.packages("sdm")
install.packages("rgdal")
install.packages("colorist")

#library
library(raster) 

library(RStoolbox)
# = strumento per l'analisi dei dati di telerilevamento = classificazioni 

library(ggplot2)
# = piccoli grafici, statistiche sulla restituzione delle classi (Land Cover) = plottaggio con 
#ggRGB() = grafica

library(patchwork)
# = per unire due immagini più semplice e veloce rispetto a par(mfrow...) 
#[ggRGB con assegnazione di un oggetto]

library(viridis)
# = serve a creare colorazioni con legende, ci sono già i nomi 
#[cividis, viridis, inferno, magma]

library(lidR)
# = per i dati Lidar

library(sdm) 
# = specie = modelizzazione delle distribuzioni di specie [1/0]
# insieme alla library(rgdal)
library(rgdal)

library(colorist)
# = per i colori 
