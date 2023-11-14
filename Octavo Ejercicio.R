# Octavo Ejercicio

#SE PERMITE INVESITGAR POR FUERA DE LOS MATERIALES DE SER NECESARIO
#AL FINALIZAR LA CLASE ENVIEN UNA COPIA POR GRUPO A emilio.leon@bue.edu.ar

#Esta guia tiene como limite de tiempo para entregarse el 20 Esta guía suma 10 puntos por ejercicio, pero debe entregarse completa para considerarse.

#Arboles de clasificación
##--------------
#NOTAS

#Recuerden el ejemplo de Arbol:

#librerías a usar e instalar:
# install.packages("caTools")
# install.packages("rpart")
# install.packages("rpart.plot")

#usamos las librerías
library(caTools)
library(rpart)
library(rpart.plot)
library(caret)
library(dplyr)

#vamos a usar el dataset iris para este ejemplo:
head(iris)


set.seed(42) #generador de numeros al azar
#iniciamos la separacion de la muestra

str(iris) #del set de Iris

#tomamos el particionamos en 75% y 25% 
particion_muestra <- sample.split(Y = iris$Species, SplitRatio = 0.75) 

#creamos el set de entrenamiento tomando los verdaderos - 75%
particion_entrenamiento <- subset(x = iris, particion_muestra == TRUE) 

#creamos el set de prueba tomando los falsos - 25%
particion_prueba <- subset(x = iris, particion_muestra == FALSE)

#usando la libreria rpart, creamos el modelo. Ponemos la variable objetivo a la izquierda.
modelo_arbol <- rpart(Species ~ ., data = particion_entrenamiento, method = "class")

#y lo vemos, notar que es para la muestra de 75%, es decir la particion de entrenamiento. 
print (modelo_arbol)

#diagramamos el arbol
rpart.plot(modelo_arbol)

#analizamos el poder predictivo, viendo cuanto pesa cada variable en la predicción
poder_prediccion <- varImp(modelo_arbol)
poder_prediccion %>% arrange(desc(Overall))

#ahora usamos el set de prueba para predecir con el modelo
prediccion <- predict(modelo_arbol, newdata = particion_prueba, type = "class")

#vemos detalles de predicción
print(prediccion) 
plot(prediccion)

#analizamos la predicción
confusionMatrix(particion_prueba$Species, prediccion)

#Ahora, como ajustar hiperparametros...facil:
library(rpart)
control <- rpart.control(minsplit = 20, minbucket = 7, maxdepth=30)
fit <- rpart(Species ~ ., data=iris, method="class", control=control)

#y se genera el arbol como parametros ajustados
modelo_arbol_corregido <- rpart(Species ~ ., data = particion_entrenamiento, method="class", control=control)

#ploteamos corregido
rpart.plot(modelo_arbol_corregido) #ojo, aca es muy facil caer en overfitting. 

#veamos que representa cada sección:
#min.split: indica la cantidad minima de observaciones para realizar una división o split en cada nodo.
#minbucket: indica la cantidad minima de observaciones en nodos terminales, es decir la clasificación en si.
#maxdepth: indica la profundidad maxima de los nodos del arbol final. Dependiendo de los datos, esta profundidad puede alcanzarse o no.

#OJO CON OVERFITTING O UNDERFITTING, SI LA CONFIABILIDAD YA ES ALTA (MAS DE 95) puede que no necesiten ajustar, pero para probar que pasa ajusten.


# ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---...
library("ggplot2")
# Ejercicio 1: Usando uno de los datasets integrados crear un arbol de clasificación. 
# Recordar verificar que los datos sean adecuados y que la muestra sea representativa.

diam = ggplot2::diamonds #la idea es clasificar el tipo de diamante (cut)

#Particiono: 75% train, 25% test
particion_muestra <- sample.split(Y = diam$cut, SplitRatio = 0.75) 
particion_train <- subset(x = diam, particion_muestra == TRUE) #Set de training 75% de los datos 
particion_test <- subset(x = diam, particion_muestra == FALSE)#Set de testing 25% de los datos 

#---TRAIN---
#Creo el mdoelo con rpart
arbol_diamonds <- rpart(cut ~ ., data = particion_train, method = "class") #method = class XQ es clasificacion, sino para una regresion seria lm, poisson, exp, etc.

#Grafico el arbol de clasificacion
rpart.plot(arbol_diamonds)

#analizamos el poder predictivo, viendo cuanto pesa cada variable en la predicción
poder_prediccion <- varImp(arbol_diamonds)
poder_prediccion %>% arrange(desc(Overall))

#---TEST---
#Veo si mi modelo performa bien
prediccion_diam <- predict(arbol_diamonds, newdata = particion_test, type = "class")
plot(prediccion_diam)

#analizamos la predicción
confusionMatrix(particion_test$cut, prediccion_diam)


#Hiperparametros
library(rpart)
control <- rpart.control(minsplit = 20, minbucket = 7, maxdepth=30)
fit <- rpart(cut ~ ., data=diam, method="class", control=control)

#y se genera el arbol como parametros ajustados
modelo_arbol_corregido <- rpart(cut ~ ., data = particion_train, method="class", control=control)

#ploteamos corregido
rpart.plot(modelo_arbol_corregido) #ojo, aca es muy facil caer en overfitting. 

#veamos que representa cada sección:
#min.split: indica la cantidad minima de observaciones para realizar una división o split en cada nodo.
#minbucket: indica la cantidad minima de observaciones en nodos terminales, es decir la clasificación en si.
#maxdepth: indica la profundidad maxima de los nodos del arbol final. Dependiendo de los datos, esta profundidad puede alcanzarse o no.
# ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---...

#Ejercicio 2: Usando cualquier dataset de Kaggle, crear un arbol de clasificación desde un CSV.
stress = read.csv("StressLevelDataset.csv") #FUENTE: https://www.kaggle.com/datasets/rxnach/student-stress-factors-a-comprehensive-analysis
#Subseteo algunas  columnas  (combino algunas fisiologicas y otras psicologicas) de interes, para simplificar el arbol.
vars = c("anxiety_level", 'self_esteem','sleep_quality', 'blood_pressure','living_conditions','stress_level' ) 
stress = stress[vars]
stress$stress_level = as.factor(stress$stress_level) #chequeo que sea un factor

#Particiono: 75% train, 25% test
particion_muestra <- sample.split(Y = stress$stress_level, SplitRatio = 0.75) 
particion_train <- subset(x = stress, particion_muestra == TRUE) #Set de training 75% de los datos 
particion_test <- subset(x = stress, particion_muestra == FALSE)#Set de testing 25% de los datos 

#---TRAIN---
#Creo el mdoelo con rpart
arbol_stress<- rpart(stress_level ~ ., data = particion_train, method = "class") #method = class XQ es clasificacion, sino para una regresion seria lm, poisson, exp, etc.

#Grafico el arbol de clasificacion
rpart.plot(arbol_stress)

#analizamos el poder predictivo, viendo cuanto pesa cada variable en la predicción
poder_prediccion <- varImp(arbol_stress)
poder_prediccion %>% arrange(desc(Overall))

#---TEST---
#Veo si mi modelo performa bien
prediccion_stress <- predict(arbol_stress, newdata = particion_test, type = "class")
plot(prediccion_stress)

#analizamos la predicción
confusionMatrix(particion_test$stress_level, prediccion_stress)
accuracy_stress = confusionMatrix(particion_test$stress_level, prediccion_stress)$overall[1]
print(accuracy_stress)


# ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---... ---...
#Ejercicio 3: Ajustar hiperparametros para mejorar el resultado de ambos arboles.

#NOTA: Resuelto para df stress... pero  seria lo mismo para el otro arbol.


#Hiperparametros - proceso iterativo -> Cambio minsplit, minbucket y maxdepth para ver cual combinacion
# me da un mejor accuracy 
splits = seq(1,100, by=10)
minbuckets = seq(1,100, by=10)
maxdepths  = seq(1,30, by=5)

library(rpart)

generar_arbol = function(stress, particion_train, particion_test, n_split, n_minbucket, n_maxdepth) { 
  #Obs. uso el mismo particion_train y particion_test aplciado sobre el DF stress
  control <- rpart.control(minsplit = n_split, minbucket = n_minbucket, maxdepth = n_maxdepth) #parametros
  arbol_nuevo <- rpart(stress_level ~ ., data = particion_train, method="class", control=control)
  prediccion_stress <- predict(arbol_nuevo, newdata = particion_test, type = "class")
  accuracy_stress = confusionMatrix(particion_test$stress_level, prediccion_stress)$overall[1]
  
  return (c(n_split, n_minbucket, n_maxdepth, accuracy_stress))
}

#Genero un df para guardarme los valores
columns = c("n_split", "n_minbucket", "n_maxdepth", "accuracy") 
hiperparametros = data.frame(matrix(nrow = 0, ncol = length(columns))) 
colnames(hiperparametros) = columns

#Itero
for (i in splits){
  for (j in minbuckets) {
    for (k in maxdepths) {
      
      resultado = generar_arbol(stress, particion_train, particion_test, i,j,k)
      print(paste(i,j,k))
      hiperparametros[nrow(hiperparametros)+1,] = resultado
    }}}

#Busco la combinacion de parametros que me dan el mejor accuracy
a = hiperparametros[hiperparametros$accuracy == max(hiperparametros$accuracy) ,]
print(a)
plot(a)
