# Cuarto Ejercicio - Manipulación de datos

#SE PERMITE INVESITGAR POR FUERA DE LOS MATERIALES DE SER NECESARIO
#AL FINALIZAR LA CLASE ENVIEN UNA COPIA POR GRUPO A emilio.leon@bue.edu.ar
#PRIMERA PUNTUACION AL FINALIZAR LA CLASE 5 PUNTOS POR EJERCICIO COMPLETO
#PUNTUACION ADICIONAL POR EJERCICIOS PRESENTADOS HASTA EL MARTES SIGUIENTE 3 PUNTOS POR EJERCICIO
# El  jueves hay preguntas, -7 puntos por faltante

#Notas
#Exploración de datasets. Si bien los ejemplos de esta sección estan sobre datasets integrados, es posible hacerlos sobre datasets en CSV.

#Para visualizar los datasets, dependiendo de que queremos ver, tenemos las siguientes opciones:

datasets::mtcars
print(mtcars)
mtcars

#Para ver resúmenes
?mtcars
summary(mtcars)

#Para explorar las dimensiones del dataset
# use dim() to get dimension of dataset
dim(mtcars) #datos planos

#Si lo quiero presentar mejor uso cat() para indicar que es, guardarlo como texto, 
cat("Dimension:",dim(mtcars))


#Para ver especificamente la cantidad de registros (filas):
nrow(mtcars)

#Para ver especificamente la cantidad de registros (columnas):
ncol(mtcars)

#para ver los nombres de variables (headers de columnas)
names(mtcars)

#Podemos ver, sin usar un vector, los detalles de una variable del dataset
print(mtcars$cyl)
#ó
mtcars$cyl

#adicionalmente podemos ordenar variables con sort()
sort(mtcars$cyl) #como esta en el dataset
sort(mtcars$cyl, decreasing=FALSE) #específicamente incremental
sort(mtcars$cyl, decreasing=TRUE) #ordenado decreciente

#Como recordatorio de guías anteriores - Como leer datos de un csv en un dataframe:
archivoleido = read.csv('/ruta/archivo.csv')

#IMPORTANTE: Puedo aplicar cualquier función estadística y matemática a los datos que traiga del csv o dataframe con el que trabaje. Ver funciones en guías previas.

#Puedo limitar las variables que leo desde un dataset (o csv), con subset():
autosV8 <- subset(mtcars, cyl == 8) # me trae todos los autos con 8 cilindros
print(autosV8)

#Esto es bastante útil para acceder a un grupo particular de datos.


#ahora para escribir la información en un nuevo CSV:

# Creando un dataframe
Mosqueteros <- data.frame (
  Nombre = c("Athos", "Porthos", "Aramis"),
  Edad = c(32, 34, 37),
  Ocupacion = c("Mosquetero", "Mosquetero", "Mosquetero"))

# generando el archivo desde el dataframe
write.csv(Mosqueteros, "mosqueteros.csv")

#alternativamente, generando un archivo desde el resumen de un dataset existente
datosautosV8 <- subset(mtcars, cyl == 8)
write.csv(datosautosV8, "AutosV8.csv")

#ó, en forma directa:
write.csv (subset(mtcars, cyl == 8),"AutosV8v2.csv")

#Esto es útil por dos motivos, permite generar reportes y salidas para usar en otros sistemas, y ademas permite generar un CSV para usar en otro proceso o proyecto. 

#Tambien se puede leer y escribir en formato excel, pero requerimos otra libreria. No se va a usar en esta guia pero si quieren verlo:
install.packages("xlsx")
library("xlsx")
#Leer, donde el sheet es la planilla de excel dentro del archivo
datasetnombre <- read.xlsx('/ruta/archivo.csv', sheetIndex = 1)
#Y para escribir: 
write.xlsx(datasetnombre, "archivo.xlsx")
#hay mas cosas que se pueden hacer, pero de momento dejemos excel por aca.

#para ver los nombres de filas
autos<- c(row.names(mtcars))
print(autos)
#alternativamente, si quisiera solo los que tienen 6 cilindros
autosV6<-row.names(mtcars[mtcars$cyl == 6,])
print(autosV6)

#Ejercicios:
#

#Ejercicio 1: Crear una versión resumida de un dataset de MTCARS donde, el nuevo dataset incluya, el nombre de los vehiculos, la cilindrada, los caballos de fuerza y el peso, y si el motor es en V o lineal.

#Ejercicio 2: volcar el dataset de MTCARS resumido en un nuevo archivo CSV.Tomar el archivo CSV y calcular para todos los vehiculos la relacion entre cilindrada y caballo de fuerza (HP/Cyl) y caballo de fuerza y peso (Wt/hp). Integrar esos datos con los anteriores y generar un nuevo CSV.

#Ejercicio 3: Usando el nuevo dataset, cuantos y qué vehiculos tienen una relacion de fuerza (hp) y cilindrada (cyl) superior a 23 (o lo que es lo mismo, cuantos tienen cada cilindro produciendo mas de 23 hp). Volcar esos nuevos datos en un nuevo CSV.

#Ejercicio 4: Buscar en google los 10 partidos despues de que se uniera messi del Inter Miami. Registrar los oponentes, goles a favor, goles en contra, si se definio en penales, penales a favor, penales en contra. Crear un dataset con esa información. Volcarlo en un archivo CSV.

#Ejercicio 5: Buscar en google los 10 partidos antes de que se una Messi del Inter Miami. Registrar los oponentes, goles a favor, goles en contra, si se definio en penales, penales a favor, penales en contra. Crear un dataset con esa información. Volcarlo en un archivo CSV (hacer el CSV primero y leerlo del programa, si bien resuelve esto, no se considera valido para este ejercicio, pero pueden usarlo como control si lo creen necesario).

#Ejercicio 6: Usando los datos del ejercicio 4 y 5, comparar, la cantidad de partidos ganados antes de messi y después. calcular el total de goles a favor de cada set y compararlos. Comparar también los mínimos y los máximos. En cada comparación indicar el porcentaje en que el dato cambio.

#Ejercicio 7: Si Messi se uniera a LA Galaxy, en que porcentaje hubiera impactado los ultimos cinco partidos. Indicar los oponentes, resultado real, goles a favor esperados y goles en contra esperados si messi hubiera jugado en ese equipo (esto se puede hacer matemáticamente de varias maneras, pero la mas directa es usando la variación porcentual que ya tenemos del inter miami y aplicarla en este caso, a nivel de programar, pensar bien cada paso, y que información necesito).

#Ejercicio 8: Si messi jugara en el LA Galaxy, de los ultimos 5, cual hubiera tenido mayor cantidad de goles? y cual menor cantidad? <- UN MOMENTO, ES ESTO UNA PREDICCION BÁSICA??? XD