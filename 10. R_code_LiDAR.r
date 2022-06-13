#R code for visualising and analysing LiDAR data
#Codice R per la visualizzazione e l'analisi dei dati LiDAR

#20
#20.05.22

#LiDAR

#Dati LiDAR
#= permetto di avere informazioni sulle strutture della vegetazione e geologiche
#dati basati su una fonte di luce esterna = Sole 
#sono dati attivi al posto di quelli passivi usati fino ad ora
#emettono loro stessi una fonte di energia 
#ad esempio una fonte laser 
#questo strumento di chiama LiDAR (laidar)
#è uno scanner laser che emette una fonte di energia e va a ricevere 
#la risposta dei vari oggetti = con ritorno 
#in base alla velocità di ritorno abbiamo un andamento 
#tridimensionale del terreno o della vegetazione 

#Virtuale 
#dati e codici 

#introduzione dei Lidar
#LiDAR = Light Detection and Ranging

#i principi dei dati LiDAR 
#lidar = tecnologica che si basa su un sensore attivo 
#emette un'energia con impulso laser e 
#questa energia ritorna al sensore ==> calcola la distanza che intercorre 
#tra l'invio e il ricevimento di questo sensore laser = 
#calcola la distanza
#es. sensore (blu) colpisce [uomo, montagna, casa...]
#raggio torna di ritorno e il sensore calcola il tempo che intercorre da quando 
#impulso laser è stato mandato e quello ricevuto 
#tramite varie costanti = calcola anche la distanza tra il sensore e l'oggetto
#usata anche dalla polizia con la velocità 
#usata tutti i giorni 
#quando facciamo una scansione LiDAR quello che abbiamo di ritorno 
#è una nuvola di punti = rappresenta un 3D del nostro ambiente che vogliamo 
#scannerizzare

#un aspetto è la risoluzione di questo dato 
#dipende molto dalla distanza in cui ci mettiamo 
#+ vicini siamo meglio è 
#impulso laser emesso da questo sensore = cambia un pò in base al materiale
#= condizionato anche dalle condizioni ambientali o polvere 

#questo sensore può essere montato su varie piattaforme 
#es aereo, drone, elicottero 
#scansione dall'alto verso il basso o anche satellite
#misurazione 3D di quello che sta scannerizzando 
#anche montato su apparecchio fisso = tls = per esempio per scannerizzare frane
# o ghiacciai = fisso 
#portatili = usati in un bosco, es. parte di un sentiero e si scannerizza 
#il 3D introno
#oppure per interni 
#o montato su macchine, strade e città

#la parte che ci interessa di più è il TLS  
#TLS = TERRESTRIAL LASER SCANNING
#e
#ALS = AIRBORNE LASER SCANNING = su aerei, drone, elicottero
#fa scansioni = sul terreno con delle strisciate
#all'interno dell'apparecchi ci sono dentro 3 strumenti principali:
#- sensore lider
#- un GPS = molto accurato 
#- altro sensore = imu = prende in considerazione gli spostamenti dell'aereo 
#= serve per correggere il dato finale 

#impulso laser = arriva e colpisce l'oggetto [impulso grande diversi cm]
#appena tocca la chioma una parte dell'impulso torna indietro 
#non sempre dipende dalla foresta se è piena o no 
#e alla fine tocca il terreno

#se vogliamo scannerizzare il bosco abbiamo 
#il primo ritorno = che rappresenta la superficie = DSM = modello della superficie
#se quello che vogliamo scannerizzare non è denso 
#una parte continua 
#e colpisce i rami più interni 
#fino ad arrivare al terrein model = possiamo calcolarsi il 3D del terreno, non 
#tanto accurato rispetto al primo 

#se noi abbiamo una foresta e abbiamo il DSM = e li sottraiamo al terreno = DTM
#ci resta l'altezza delle piante = CHM = Canopy Height Model
#stimare tante variabili e anche diversi indicatori di biodiversità
#DSM - DTM = CHM (lo faremo negli esercizi)

#= questa era la parte sull'aereo 

#da alcuni anni c'è la parte montato sul satellite = GEDI che orbita sulla Terra
#+ distante è il sensore da quello che vuole misurare + bassa è la risoluzione 
#con satellite si arriva anche a una risoluzione anche a 30m e 10m
#fa delle strisciate continue sulla terra
#dati si possono scaricare gratuitamente a 30m per poi arrivare a 10m

#LiDAR drone = da poco sviluppato = accuratezza elevata alcune volte troppo
#non riesce a fare superfici enormi 

#TLS = Terrestrial Laser Scanning
#= fisso in un punto 
#= es scannerizzato un ghiacciaio
#funziona con un onda con superfici di ghiaccio, acqua

#per riassumere
#in ambito ambientale e forestare = utilizzato molto per 
#altezza, volume, specie delle piante, ...
#per capire l'eterogeneità di habitat 

#DTM = informazioni con frane e ghiacciai
#usato anche nell'archeologia = si riesce a trovare vecchie manufatti di età non 
#moderna
#infrastrutture = facciate case, problemi della struttura delle case, 
#ponti, ferrovie
#costruzioni di edifici interni e esterni
#autonomi nei veicoli (distanza tra te e macchina davanti = sensori LiDAR)
#negli Ipad = ci sono dei sensori LiDAR per scansionare tutto quello che si vuole

#parte più pratica del dato LiDAR
#anche su Git Hub

#R code for visualising and analysing LiDAR data
#Codice R per la visualizzazione e l'analisi dei dati LiDAR

#i dati li metto nella cartella lab e sono:
#2004 + 2004 + 2013 + 2013 + point = 5 file

#creare un CHM 
#con DSM e DTM = già pronto 

#carichiamo alcune libreria
library(raster)

#settaggio della Working Directory
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")

dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")
dsm_2013

#raster layer
#la risoluzione 0.5 = detagliata 
dtm_2013 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")
dtm_2013

#facciamo un plot
plot(dtm_2013)

#siamo in montagna

#calcoliamo il CHM

chm_2013 <- dsm_2013 - dtm_2013
chm_2013
#in values si vede il minimo e massimo 
#punto più alto e psiù basso 

#library
library(ggplot2)
library(viridis)
library(RStoolbox)

#plottiamo con il ggplot
ggplot() + 
  geom_raster(chm_2013, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis() +
  ggtitle("CHM 2013 San Genesio/Jenesien")

#vediamo la mappa 
#da maps 
#blu = prateria
#valori più chiari = parte alta delle piante
#con anche con QGIS

#facciamo la stessa cosa anche per il 2004

dsm_2004 <- raster("2004Elevation_DigitalElevationModel-2.5m.tif")
dsm_2004

#la risoluzione è più bassa di 2.5m 

dtm_2004 <- raster("2004Elevation_DigitalTerrainModel-2.5m.tif")
dtm_2004

plot(dtm_2004)

chm_2004 <- dsm_2004 - dtm_2004
chm_2004

ggplot() + 
  geom_raster(chm_2004, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis() +
  ggtitle("CHM 2004 San Genesio/Jenesien")

#la risoluzione è calata 

#ora possiamo vedere la differenza dei due CHM
#vediamo in 10 anni cosa è cambiato  
difference <- chm_2013 - chm_2004
#mi errore
#perchè la risoluzione del 
#2013 = è di 0.5m 
#mentre
#2004 = è di 2.5m

?`resample,Raster,Raster-method`
#quindi dobbiamo fare un resample del dato 
#= cambiare la risoluzione del dato 
#è meglio da 0.5 a 2.5 
#meglio una risoluzione più grossolana
#r = resample
#x = ricampionare = chm_2013 a una risoluzione del 
#y = è la chm_2004 = quella che deve venire 

#si perde informazione

chm_2013_r <- resample(chm_2013, chm_2004)
chm_2013_r
#ora la risoluzione è cambiata 

#a questo punto ora possiamo fare la differenza
difference <- chm_2013_r - chm_2004
difference

#plottiamo con ggplot
ggplot() + 
  geom_raster(difference, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis() +
  ggtitle("Difference in CHM")

#aree più scure = aree bosco stato tagliato = valori negativo 
#aree più chiare = aree in crescita piante = valori positivi 
#nella parte centrale non è cambiato niente = verdino 

#anche su QGIS

#la Point line
#il punto di partenza 

install.packages("lidR")
library(lidR)

point_cloud <- readLAS("point_cloud.laz")
#ci sono degli errori ma non ci facciamo caso

plot(point_cloud)
#ci da il 3D di tutta l'area
#ma non riesco a salvarla 
#vediamo = è un versante 
#se andiamo dentro vediamo le singole case e le piante
#misurare dove c'è stata una frana,...

#articolo di Michele Torresani 

#maggiore sarà la variazione all'interno del bosco (altezza, ....) e 
#maggiore sarà la diversità piante in altezza 


