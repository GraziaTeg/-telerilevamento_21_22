#25.03.22
#serve per calcolare gli indici di vegetazione 
library(raster)

#poi fare uil settaggio della cartella di lavoro della Working directory
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")

#esercizio
#import the firth file -> defor1_.jpg -> give it the name l1992
#importare la prima immagine satellitare con l1992
brick("defor1_.jpg")
l1992 <- brick("defor1_.jpg")
l1992

