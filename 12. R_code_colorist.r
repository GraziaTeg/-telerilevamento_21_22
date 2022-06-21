#03.06.22

#COLORIST
 
#È un pacchetto
#Introduzione
#Vedremo il problema che ha portato alla creazione di colorist
#I biologi usano le range map per descrivere le distribuzioni degli animali 
#nello spazio e nel tempo
#Hanno molto successo ma incapaci di essere precise
#Le tecnologie per acquisizione e modellizzazione sono migliorate molto 
#recentemente
#L’eccesso di informazioni comporta una serie di sfide
#L’uso di modelli di distribuzione della specie SDM per mappare e monitorare 
#la distribuzione di piante e animali è diventato sempre più importante quando 
#si mira alla comprensione ambientale, dinamica della popolazione e implicazioni ecologiche. Nella slide c’è schema di creazione
#Punto di partenza è la distribuzione che dice dove le specie sono nello 
#spazio e nel tempo
#Serve una rappresentazione grafica
#Che è importante per sapere dove, come, perché la distribuzione cambia
#Problemi:
#-mappe obsolete
#-numero crescente di dati da analizzare
#-rappresentazione grafica efficace ed inclusiva che manca

#Così colorist nato per risolvere questi problemi
#Creato nel 2020
#Obiettivo: dare ai ricercatori mezzi per studiare comprendere e comunicare 
#dati sulle distribuzioni delle specie
#Colorist usa il colore per indicare dove, quando e con quanta coerenza 
#si possono trovare specie, individui o gruppi di animali
#Usa una palette non di uso comune HCL hue-chroma-luminance (tonalità, 
#intensità del colore, luminanza)
#Colorist prende le informazioni da una pila di raster, le elabora e le 
#collega alle tavolozze dei colori HCL in modo specifico in modo che i 
#valori di occorrenza, abbondanza o densità abbiano pesi percettivi quasi 
#uguali nelle mappe rsultanti
#Colorist riesce a standardizzare i dati per renderli confrontabili

#Il flusso di lavoro di base per colorist:
#-metriche: gli utenti calcolano le metriche per descrivere le loro 
#distribuzioni (creano il dato da utilizzare)
#-tavolozza dei colori: gli utenti scelgono una tavolozza dei colori per 
#abilitare la visualizzazione delle metriche
#-mappa: gli utenti combinano metriche e una tavolozza per mappare le 
#distribuzioni in una o più mappe
#-legenda: gli utenti generano una legenda per accompagnare la loro mappa

#Carenza visiva dei colori
#Chi vede tutti i colori non ha problema ma chi ha problemi nella percezione 
#dei colori es. daltonismo
#Dovremmo cercare di comunicare quello che studiamo al più ampio pubblico 
#possibile
#Quindi cercare di manipolare il pacchetto, varie conversioni da colori 
#esadecimali da rgb, hsl (hue, saturation, lightness) e preso hue che è 
#anche in hcl usando il tasto custom_hues(function)
#Colorist importante mappa distillata unione di varie specie
#Più colorato o meno a seconda frequenza specie (1 specie o 10) -> intensità 
#colore e distribuzione specie specificità

#Posso farlo per specie o elementi nel suolo o quello che voglio

#################
#CODICE
#Installazione pacchetto
#Librerie e poi mappiamo dati annuali, c’è già il dato nel pacchetto 
#fiespa_occ sparrow sono uccelli
#Colorist lavora solo con rasterstack
#Creazione rasterstack parte più difficile

#Poi creiamo le metriche met1  usa la funzione metrics_pull
#La funzione sta trasformando i valori dello stack nelle distribuzioni 
#individuali sta preparando il raster per la visualizzazione

#Poi palette
#Abbiamo varie funzioni per creare palette noi usiamo timecycle

#Poi mappa multipla per vedere le opzioni possibili
#Negli attributi metrica, palette e quante colonne vogliamo nella 
#distribuzione, labels dato
#Stiamo dicendo che vogliamo una mappa multipla che prenda la metrica, 
#la palette e divida in tre colonne e che dia alle mappe multiple il nome 
#del nostro dato
#Poi estraggo un mese solo
#Manipolo la mappa es cambio il colore nella mappa
#Facciamo palette personalizzata, prendiamo i 12 mesi e facciamo iniziare 
#hue da 60 invece che da 240 (default) che tende al blu; 60 giallo  p1_custom

#Map distill unisce tutti i livelli layer
#Nella funzione metto i dati
#Poi creo una mappa singola e metto la metrica e la palette
#Le parti colorate hanno specificità per un singolo layer
#Parti grigie parti di bassa specificità=le specie sono presenti in quei 
#punti grigi per la maggior parte dei mesi, invece le parti colorate 
#significano specie solo in qualche mese alta specificità

#Poi metto la legenda, con punto di partenza

#Poi ho massima intensità: quanto spesso una specie si trova in un determinato 
#punto rispetto ad un’altra
#Qui è singola quindi quante volte quel punto è stato toccato dalla specie
#Ci sono altre opzioni per manipolare la legenda


###################
#packages----
install.packages("colorist")
install.packages("ggplot2")

library(raster)
library(colorist)
library(ggplot2)

#Field sparrow----
data("fiespa_occ")

#metrics
met1 <- metrics_pull(fiespa_occ)

#palette
pal <- palette_timecycle(fiespa_occ)

#map
map_multiples(met1, pal, ncol = 3, labels = names(fiespa_occ))

#choise a layer
map_single(met1, pal, layer = 6)
#console

#custom palette
p1_custom <- palette_timecycle(12, start_hue = 60)
map_multiples(met1, p1_custom, labels = names(fiespa_occ), ncol = 4)

#map distill
met1_distill_metrics_distill(fiespa_occ)
map_single(met1_distill, pal)

#leg
legend_timecycle(pal, origin_label = "1 jan")


#Mappare il comportamento individuale di un individuo nel tempo
#Tempo lineare e non più circolare
#Specie pekaria pennati che è un mammifero, di solito si studia con gps 
#a volte trappole
#Nome dato fisher_ud
#Creo la metrica 
#Metric_pull funzione per creare la metrica se uso colorist per mappare un
#singolo individuo nel tempo
#Poi seconda palette non posso usare la stessa palette di prima perché ora 
#ho tempo lineare quindi uso palette timeline
#Uso head per vedere i primi 6 valori di tutto il file, ho 3 colonne con
#specificità, layer id numero di layer e colore dato come esadecimale
#Palette da -360 a +360
#I colori sono definiti anche da sigle #FFFFFF come html
#E ci sono convertitori su internet per passare da rgb a sigla
#0-255.0-255.0-255 per rgb quanto dare a rosso ecc.
#Rgb dà problemi a volte

#Creazione di mappa multipla
#Metto metrica, palette, numero colonne

#Metrica= qualsiasi distribuzione di variabile nello spazio e nel tempo
#Metrica=distribuzione per una specie, potrebbe essere distribuzione di 
#un minerale

#Qui partiamo da dati già pronti ma prima ci sarebbe fase di studio per 
#arrivare alla distribuzione
#Visualizziamo i dati
#Viene un grafico poco capibile e introduciamo il concetto di lambda

#Ci sono 9 notti e i movimenti di 9 notti
#Fattore lambda movimenti in varie notti e come distribuito l’individuo 
#nelle 9 notti
#Prima c’era contorno ora ho solo linee sparse
#Lambda cambiato cambia l’opacità
#Ora lambada basso se metto lambda 12 che è il più alto di opacità cioè 
#più visibile
#Quindi lambda per saturare, marcare di più


#Creo mappa singola
#Distillo le due informazioni
#Creo mappa, metto la metrica distillata, metto le palette 2 e poi metto 
#lambda messo a -10

#E vedo come la martora si è mossa
#Poi faccio la legenda, uso timeline perché tempo lineare
#Vengono valori intensità e specificità
#Poi ha messo in uno spazio reale i movimenti della martora usa anche il 
#pacchetto tigris

#Ogni colore è una notte
#La mappa distillata unisce tutte le mappe, questa permette di vedere la 
#specificità

#5 passaggi fondamentali
#-definizione della metrica di una variabile
#-palette
#-mappare le singole mappe
#-mappa distillata
#-legenda


################
#Codice
data("fisher_ud") 
m2 <- metrics_pull(fisher_ud)
pal2 <- palette_timeline(fisher_ud)
head(pal2)

map_multiples(m2,ncol = 3, pal2)

map_multiples(m2,ncol = 3, pal2, lambda_i = -12)

m2_distill <- metrics_distill(fisher_ud)
map_single(m2_distill,pal2,lambda_i = -5)


#https://github.com/Ludovico-Chieffallo/Lessons
