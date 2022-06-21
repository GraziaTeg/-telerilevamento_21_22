#24
#03.06.22

#Come si fa una funzione
#Funzione in R open source ognuno può contribuire

#La struttura base di una funzione ha 3 elementi:
#-nome della funzione
#-argomento: valori usati nella funzione
#Quando faccio una funzione e la chiamo la funzione corre solo in un suo 
#ambiente, nell’ambiente globale vedo solo quello che la funzione ritorna
#-corpo: tutto il codice della funzione

#Scriviamo una funziona che saluta
#Function per dire che è una funzione e tra parentesi metto argomento
#C’è assegnazione di solito assegniamo funzioni agli oggetti, qui l’oggetto
#è una nuova funzione e si fa con function

#Poi passo il nome all’argomento
#Funzione paste prende 2 strighe e il nome e li mette in 1 stringa usando 
#il separatore sep che vogliamo qui spazio
#Poi stampa

cheer_me <- function(your_name) {
  cheer_string <- paste("Hello", your_name, sep = " ")
  print(cheer_string)
}

#Non abbiamo ancora interagito con la funzione l’abbiamo solo definita
#Dobbiamo richiamarla
cheer_me("Grazia")
#"" per testo e non variabile

#cheer_me associato alla funzione

#ripeto tante volte usando il ciclo
#in R per questo caso uso il for
#function per definire nuova funzione
#n numero di volte del for numero iterazioni
#for ripete tante volte la stampa 

#si scrive for (i in seq(1,n))
#  i prende valori da 1 a n
#(1,n) vettore

#i è il contatore parte da 1
#stampa
#poi i diventa uguale a i+1
#stampa
#a i aggiunge ancora 1 eccetera fintanto che i non diventa uguale a n
#e stampa l’ultima volta poi non fa più il ciclo


cheer_me_n_times <- function(your_name, n) {
  
  cheer_string <- paste("Hello", your_name, sep = " ")
  
  for(i in seq(1, n)) {
    print(cheer_string)
  }
}

#quando chiamo la funzione con i due parametri
#-o mantengo l’ordine e quindi quello che scrivo corrisponde ai parametri
#-oppure scrivo n=3, your_name=”Grazia”

#n non può essere una stringa e darebbe errore
#potrei usare for anche per le immagini


#ora facciamo un set e scegliamo il path 
#mettiamo qualche dato diamo un nome dato
#sentinel e lo riprendo come raster
#serve anche la libreria

#setwd(“~/lab”)
library(raster)
setwd("D:/UNIVERSITA' MAGISTRALE/1 ANNO/2 SEMESTRE/TELERILEVAMENTO GEO-ECOLOGICO/R/3. 10.03.22/lab")
dato <- raster("sentinel.png")

plot(dato)

#e viene una cartina 

#procedo con una funzione che usa un’immagine satellitare
#faccio la funzione e uso plot scegliendo una palette di colori

#chiamo la funzione plot_raster
#argomenti raste r e col color
#metto NA come valore iniziale se non do niente color rimarrà NA

#poi controllo se col ha un valore se sì stampa con i colori della palette 
#inserita altrimenti voglio che comunque mi faccia il plot uso if

#(!is.na(col)) controllo che col abbia valore na
#!is vuol dire no
#Quindi se col non è na

#Se ho dato il colore costruisco la palette di colori predefinita
#Poi plottoraster r con color= palette

#Se la condizione dell’if non vera fa quello che c’è nell’else
#IF-ELSE si usa per i controlli anche per controllare com’è il dato
#Qui il nostro raster è r

plot_raster <- function(r, col  = NA) {
  
  if(!is.na(col)) {
    pal <- colorRampPalette(col)(100)
    plot(r, col = pal)
  } else {
    
    plot(r)
  }
  
}


#Chiamo la funzione così
plot_raster(dato, c("brown", "yellow", "green"))

#non ho usato proprio palette ma ho fatto una funzione
#se non metto i colori plotta comunque perché entra in else
#  dà un piccolo errore perché passiamo alla funzione un vettore ma 
#poi nell’if ne controllo uno non tutto il vettore

#-creare una funzione
#-ciclo for se devo fare tante iterazioni
#-funzione che unisce varie funzioni spesso si fa con if else
  
  
