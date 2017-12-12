# Instalación y carga de paquetes y lectura de la información de las palabras utilizadas en una página web
install.packages('RCurl')
library(RCurl)
install.packages('XML')
library(XML)

html <- getURL("http://www.ub.edu/datascience/postgraduate/", followlocation = TRUE)

html <- getURL("http://www.lavanguardia.com/alminuto", followlocation = TRUE)


# Es importante hacer un "parse" del contenido html
doc = htmlParse(html, asText=TRUE)
plain.text <- xpathSApply(doc, "//p", xmlValue)
cat(paste(plain.text, collapse = "\n"))
plain.text<-gsub("á", "a", plain.text)
plain.text<-gsub("é", "e", plain.text)
plain.text<-gsub("í", "i", plain.text)
plain.text<-gsub("ó", "o", plain.text)
plain.text<-gsub("ú", "u", plain.text)

# Instalación y carga del paquete necesario para construir una matriz de términos con la que poder trabajar
install.packages("tm")
library(tm)
# Creamos un Corpus, que es un objeto de R que permite trabajar con datos textuales
myCorpus = Corpus(VectorSource(plain.text))

#Pasamos la mayúsclas a minúsculas 
myCorpus = tm_map(myCorpus, tolower)

# Eliminamos los signos de puntuación
myCorpus = tm_map(myCorpus, removePunctuation)

# Eliminamos los números
myCorpus = tm_map(myCorpus, removeNumbers)

# Eliminamos algunas palabras sin significado propio (artículos,..)
myCorpus = tm_map(myCorpus,removeWords, stopwords('spanish'))

# Creamos la matriz de términos
myDTM <- DocumentTermMatrix(myCorpus)

# La convertimos en una matriz de datos
m = as.matrix(myDTM)

# Ordenamos las filas en función de su mayor o menor frecuencia
v = sort(colSums(m), decreasing = TRUE)


# Instalación y carga del paquete necesario para obtener la nube de términos
install.packages('wordcloud')
library(wordcloud)

set.seed(4363)
# Finalmente creamos la nube:
wordcloud(names(v),v, min.freq = 5000, 
          colors=brewer.pal(6,"Dark2"),random.order=FALSE)