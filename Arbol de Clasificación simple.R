#librerías a usar e instalar:
install.packages("caTools")
install.packages("rpart")
install.packages("rpart.plot")
install.packages("caret")
install.packages("dplyr")

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
poder_prediccion %>%
  arrange(desc(Overall))

#ahora usamos el set de prueba para predecir con el modelo
prediccion <- predict(modelo_arbol, newdata = particion_prueba, type = "class")

#vemos detalles de predicción
print(prediccion) 
plot(prediccion)

#analizamos la predicción
confusionMatrix(particion_prueba$Species, prediccion)