# Quinto Ejercicio

#SE PERMITE INVESITGAR POR FUERA DE LOS MATERIALES DE SER NECESARIO
#AL FINALIZAR LA CLASE ENVIEN UNA COPIA POR GRUPO A emilio.leon@bue.edu.ar
# Debido a lo hablado en clase vamos a replantear el tema de puntajes. Si no han terminado la guia 4 pueden seguir haciendola.

#Plotear y ver detalles sobre un dataset.

#En su forma mas vasica, plotear es trazar un set de puntos de dos vectores o conjuntos de datos

mtcars
x <-c(mtcars$hp) #traigo hp del dataset y lo cargo en un vector
y <-c(mtcars$cyl) #traigo cyl del dataset y lo cargo en un vector
plot (x,y) #ploteo los vectores o scatterplot

#De hecho puedo hacer estos diagramas, correr cada plot independientemente
plot(x,y, main ='Scatterplot') #el main solo indica nombre
plot (factor(mtcars$cyl), main = 'Barplot') #alternativamente puedo cargar factor en una variable

#Por cierto si quieren resolver funciones en matematica alguna vez:
plot(function(x) x)
plot(function(x) x^2)
plot(function(x) x^3)
plot(function(x) x^2 + 2)

##O para hacerla completa
funcion <-(function(x) -x^2)
plot(funcion, -100,100, main = 'Binomial')


# Plotear y ver detalles de un dataset nos permite encontrar o intuir patrones. Vamos a ver como trazar un histograma, un boxplot y una comparación de dos variables usando mtcars:

#Creando el histograma
hist(mtcars$mpg,
     col='steelblue',
     main='Histograma',
     xlab='mpg',
     ylab='Frequencia')
#esto lo podemos hacer para cualquier columna que queramos comparar.

#el boxplot me permite ver la distribución de valores desde el promedio de valor.
boxplot(mtcars$mpg,
        main='Distribución de valores de mpg',
        ylab='mpg',
        col='steelblue',
        border='black')

#creando una comparación de dos variables, me permite empezar a visualizar posibles relaciones entre ambas. Por ejemplo si comparo mpg, contra wt:
plot(mtcars$mpg, mtcars$wt,
     col='steelblue',
     main='Comparasón de variables',
     xlab='mpg',
     ylab='wt',
     pch=19)

#Puedo setear colores facilmente
col='green'
col='yellow'
col='red'

#IMPORTANTE, ESTOS DIAGRAMAS PUEDEN HACERSE DE OTRAS MANERAS, CON MUCHAS MAS VARIABLES Y USANDO OTRAS LIBRERIAS, LO DE ARRIBA ES NATIVO. CON GGPLOT2

install.packages("ggplot2")
library (ggplot2)

ggplot(mtcars, aes(x = mpg, y = hp)) + 
  geom_point(color = "#0099f9", size = 5) + 
  geom_point(aes(size = qsec, color = cyl)) +
  labs(
    title = "Millas vs Caballo de fuerza",
    subtitle = "Prueba de otro metodo",
    caption = "Source: MTCars dataset"
  )

#Para los ejercicios nativo es suficiente.

#Se pueden hacer con mas de dos variables. Corran esto sección por sección y vean como el grafico va cambiando.

######-- Inicio de sección --#####
  
# Por ejemplo, agrego el primer set de variables en x,y (en cada vector tambien podria cargar data de un dataset por ejemplo)
var_x1 = c(9,1,8,7,7,3,2,4,5,6)
var_y1 = c(7,4,1,5,9,6,3,3,6,9)

# Agrego el segundo set de variables en x, y (en cada vector tambien podria cargar data de un dataset por ejemplo)
var_x2 = c(4,1,5,9,7,4,5,2,8,4)
var_y2 = c(9,1,5,7,4,1,3,6,5,2)

# Ploteo el primer set de variables
plot(var_x1,var_y1, col='darkgreen', pch=19)#donde coloco las variables, col es el color, y pch el tipo de punto, de hecho cambien este numero al azar y vean que pasa XD

# Agrego los pundos del segundo set
points(var_x2, var_y2, col='red', pch=19)

#cambio los nombres de variables
legend(1,9,legend=c('Variable 1', 'Variable 2'), 
       pch=c(19, 19), col=c('darkgreen', 'red'))

######-- Fin de sección --#####

#Esto se puede hacer con cuantas variables se crea necesario, pero en general lo ideal es considerar en x e y dos variables cuya relación sea evidente, por ejemplo en mtcars, cyl y hp.

#Ejercicios

#Ejercicio 1: Usando el dataset de titanic, plotear las variables clase y si sobrevivio o no en un histograma.

#Ejercicio 2: usando el dataset de iris comparar el sepal.length y el petal length, trazar en un diagrama de dispersión (Scatterplot)

# Ejercicio 3 usando el dataset de iris nuevamente comparar el sepal length y el sepal with. Trazar en un diagrama de dispersion.

#Ejercicio 4. comarar todos los datos numericos de iris en un plot, tener en cuenta como se comparan los datos para poder interpretarlos correctamente


#Ejercicio 5, trazar un boxplot de cada columna de mtcars


#Ejercicio 6, el siguiente ejemplo (abrirlo en linea 120) usa un dataset del package Mass y genera un histograma de todas las variables numericas del set. Replicar este mismo ejemplo para mtcars.


#----
#-------Ejemplo---
# Instalar MASS
install.packages("MASS")

# cargar Mass
library(MASS)

#Cargar el dataset
data(Boston)

#Instalar tidymodels y tidyr
install.packages("tidymodels")
install.packages("tidyr")

# cargar las librerias
library(tidymodels)
library(tidyr)

# preparar el dataset
boston_data_long <- Boston %>%
  pivot_longer(cols = everything(),
               names_to = "variable",
               values_to = "value")

# Histograma de todos los valores (de hecho este se puede saltar)
boston_histograms <- ggplot(boston_data_long, aes(x = value)) +
  geom_histogram(bins = 30, color = "black", fill = "lightblue") +
  facet_wrap(~variable, scales = "free", ncol = 4) +
  labs(title = "Histograms of Numeric Variables in the Boston Housing Dataset",
       x = "Value",
       y = "Frequency") +
  theme_minimal()

# Plotear
print(boston_histograms)
