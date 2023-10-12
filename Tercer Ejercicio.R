# TERCER Ejercicio

#SE PERMITE INVESITGAR POR FUERA DE LOS MATERIALES DE SER NECESARIO
#AL FINALIZAR LA CLASE ENVIEN UNA COPIA POR GRUPO A emilio.leon@bue.edu.ar
#PRIMERA PUNTUACION AL FINALIZAR LA CLASE 5 PUNTOS POR EJERCICIO COMPLETO
#DEBIDO A LA SITUACIÓN QUE ESTOY ATRAVESANDO, ESTA GUIA PUNTUARA 5 PUNTOS HASTA EL MARTES, SIN CAMBIO EN PUNTOS, PARA DARLES TIEMPO A INVESTIGAR Y/O CONSULTARME POR EMAIL.
# Los ejercicios avanzados tomense el tiempo para hacerlos e investigarlos, pero mas importante, trabajen JUNTOS o Colaborativamente, esto no significa al mismo tiempo. 

#Notas

#En esta guía vamos a ver ciclos de control.
# IF e IF ELSE
#IF permite evaluar una condición, y retornar una acción:
varx <- 2
if (varx > 1) print("El numero es mayor a 1")

#if else permite evaluar una condición y retornar una acción por el verdadero y otra por el falso
varx1 <- 1
if (varx1 > 1) print("El numero es mayor a 1") else print ("El numero no es mayor a 1")
if (varx1 > 1) print("El numero es mayor a 1") else print ("El numero no es mayor a 1")


#Un ejemolo de uso de ifelse:

x <- 1:10
ifelse(x %% 5 == 0, "XXX", as.character(x))
ifelse(x %% 2 == 0, "Par", "Inpar")


#Recordar si quiero evaluar mas de una condición debo usar operadores logicos, por ejemplo 
# && - Equivalente al operador logico "Y" (Ambas condiciones deben ser verdaderas)
# ||	- Al menos una condición debe ser vedadera para que retorne "True"
# !	Negación lógica, retorna verdadero si la condición es falsa y viceversa. 
  

#Uso de Switch, para evaluar varias condiciones

cantRuedas <- function(x) {
  switch(x,
         Automotor = 4,
         Camion = 6,
         Monociclo = 1,
         Moto = 2,
         stop("Vehiculo no identificado")
  )
}
cantRuedas ("Automotor")
cantRuedas ("Camion")

#Ciclo FOR, me permite que mientras una condición sea verdadera, una acción se ejecute.

for (i in 1:3) {
  print(i)
}

##Uso de Next o Break. Permite saltar al siguiente o romper el ciclo:

for (i in 1:10) {
  if (i < 3) 
    next
  
  print(i)
  
  if (i >= 5)
    break
}

#Ciclo While: el ciclo corre una accion mientras una condicion es verdadera

z <- 1
while(z > 0.1){
  z <- runif(1)
  print(z)
}

#Otro ejemplo:
x = 1
while(x <= 5){
  print(x)
  x = x + 1
}

##Como leer datos de un csv en un dataframe:
archivoleido = read.csv('/ruta/archivo.csv')

##donde la ruta es la ruta del archivo en el sistema local

##si necesito especificar el separador:
archivoleido = read.csv('/ruta/archivo.csv',sep=',')

##Usando el dataset titanic provisto, y donde lo tengo yo localmente
icebergOuch = read.csv('/Users/ealej/OneDrive/Escritorio/R for IFTS/titanic.csv')
print(icebergOuch)

# EJERCICIOS iniciales 5 puntos cada uno

#Ejercicio 1: Crear un programa que guarde 10 números al azar del uno al 50, los sume, y verifique que: Si la suma es menor a 50, Si la suma es mayor a 50 pero menor a 350, y si la suma es mayor a 350.

#Ejercicio 2: Usando mtcars indicar cuantos vehículos de 6 cilindros hay en el listado.

#Ejercicio 3: Crear un programa que identifique la cantidad de pétalos de una flor ingresando la cantidad de pétalos en el programa. (A modo de prueba, usar 6, margarita, 10 girasol, 7 petunia)

#Ejercicio 4: Usando mtcars, indicar cuantos vehículos tienen cilindrada impar en el listado. 

#Ejercicio 5: que esta haciendo el siguiente código?
xs <- c(1, 2, 3)
for (x in xs) {
  xs <- c(xs, x * 2)
}
xs

#Ejercicio 6: escribir un programa que genere numeros del 1 al 7 usando for, e indicar el cuadrado de cada numero. 

##Ejercicio 7: Escribir un programa que simule el lanzamiento de una moneta 10 veces, indicando en cada lanzamiento si es cara o seca en un vector generado previamente.


# Ejercicios avanzados: Puntos 15 por cada uno.

#Instalar

install.packages("tidyverse")
install.packages("knitr")

#Si quieren ver detalles de tidyverse: https://www.tidyverse.org/packages/
#detalles de knitr: https://www.r-project.org/nosvn/pandoc/knitr.html (deberia estar por defecto)

# Usar
library(tidyverse)
library(knitr)

##Ejercicio 1: Usar dataset titanic provisto. Se estima que el titanic tenia 2224 pasajeros y tripulación a bordo. Usando el CSV provisto, indicar, de cuantas personas tenemos información, cuantos sobrevivieron, y cuantos no. Cual es la tasa de supervivencia de acuerdo a este dataset?

##Ejercicio 2: Usar el dataset Titanic integrado (dataset::Titanic), verificar cuantas personas tenemos en esta versión, cuantas sobrevivieron y cuantos no. Y cual es la tasa de supervivencia.

##Ejercicio 3: Calcular la diferencia entre cada punto de ambos datasets.




