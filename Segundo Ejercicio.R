# Segundo Ejercicio

#SE PERMITE INVESITGAR POR FUERA DE LOS MATERIALES DE SER NECESARIO
#AL FINALIZAR LA CLASE ENVIEN UNA COPIA POR GRUPO A emilio.leon@bue.edu.ar
#PRIMERA PUNTUACION AL FINALIZAR LA CLASE 5 PUNTOS POR EJERCICIO COMPLETO
#PUNTUACION ADICIONAL POR EJERCICIOS PRESENTADOS HASTA EL MARTES SIGUIENTE 3 PUNTOS POR EJERCICIO
# El proximo jueves comienzan las preguntas, -7 puntos por faltante

#TODOS LOS GRUPOS YA TIENEN 50 PUNTOS, por la prueba piloto

#Notas
#Las variables pueden definirse por tipo, usando as.<type>, donde type es variable, por ejemplo:
var1 <- as.integer(5) #asignando como entero
print(var1) #imprimo el entero
var2 <-as.Date(3021) #asignando como fecha
print(var2) #imprimo la fecha
#puedo ver los objetos en memoria en cualquier momento
print(ls.str())
#otros ejemplos

var3 <- as.numeric(5)
var4 <- as.integer(5)
var5 <- as.complex(5i) #no se asusten, no vamos a entrar con numeros imaginarios, solo para que sepan que se puede.

#Se puede requerir el ingreso de datos en variables usando readline, por ejemplo
nombre <- readline(prompt="Ingrese su nombre: ")
edad <- readline(prompt="Ingrese su edad: ")
print(paste("Mi nombre es",nombre, "y tengo",edad ,"años."))

#Vectores - Los vimos en la guia anterior, la estructura es simple: <- vector <- c(5,6,7,8,9)
vector <- c(5,6,10,8,9,8)
#Podemos hacer un ploteo simple de cualquier vector
plot(vector)

#Funciones estadísticas

print(mean(vector)) #promedio
max (vector) #maximo
min (vector) #minimo
median (vector) #valor medio, de la secuencia ordenada
mode (vector) #valor mas comun

#Hay funciones para percentiles y quantiles los veremos mas adelante

#Funciones matemáticas simples
sum(vector)
prod(vector)
#restos, sirven para divisibilidad
10%%2
13%%2
15%%5

#existen tambien, funciones trigonométricas, logaritmicas, etc.

#rangos
print(1:10)

#Muestreos al azar
sample(0:100, 10, replace=TRUE)
#vista de lista
lista <- c(1:10)
print (head(lista))
print (head(lista,3)) #o para limitar, alternativamente para ver los ultimos, usar tail.

#dataframes/datasets
dataset <- data.frame(mes = character(),
                      temperatura = numeric(),
                      precipitaciones = numeric(),
                      humedad = numeric())

#Ordenado
sort(lista,decreasing=FALSE)

# Datasets integrados a R

morley #datos de velocidad de la luz en distintos medios
nhtemp #promedio de temperaturas por año en New Haven (vector)
mtcars #Pruebas de distintos vehiculos
nottem #temperaturas promedio en nottingham (matriz)
iris #medidas de distintas flores

?mtcars #para ver información de este dataset
#mas datasets integrados con:
#datasets::
datasets::airmiles

#Para asignar datos a un dataset:
Data_autos <- mtcars

#Si quisiera encontrar el max y minimo de hp de los vehiculos en el dataset:

max(Data_autos$hp)
min(Data_autos$hp)




#++++++++++++++++++++++
#Ejercicios
#++++++++++++++++++++++
#1 - Escriba un programa de R para tomar la entrada del usuario (nombre y edad) y mostrar los valores.
nombre <- readline(prompt="Ingrese su nombre: ")
edad <- readline(prompt="Ingrese su edad: ")
print(paste("Mi nombre es",nombre, "y tengo",edad ,"años."))


#-----------------------------------------------------------------------------------------------------------------------------
#2 - Escriba un programa de R para obtener los detalles de los objetos en memoria. Hacerlo con un vector, 
#variables y finalmente con un set de datos integrados.
vector

nombre

iris

#-----------------------------------------------------------------------------------------------------------------------------
#3 - Escribe un programa R para crear una secuencia de números del 10 al 50 y encuentra la media de los números del 20 
#al 60 y la suma de los números del 51 al 91.

#10-50
seq(from=10, to=50, by=1)

#20-60
mean(seq(from=20, to=60, by=1))

#51-91
sum(seq(from=51, to=91, by=1))

#-----------------------------------------------------------------------------------------------------------------------------
#4 - Escribe un programa de R para crear un vector que contenga 10 valores enteros aleatorios entre -10 y +10.
sample(c(-10:10), size=10, replace=TRUE)

#-----------------------------------------------------------------------------------------------------------------------------
#5 - Escribe un programa para imprimir únicamente los diez primeros vehículos del dataset de mtcars. 
#Adicionalmente, que liste aparte las 5 primeras cilindradas, y que me diga la cilindrada más común.
head(mtcars,10)

primerosCinco = head(mtcars, 5)  
library(DescTools)
DescTools::Mode(primerosCinco$cyl)[1] #Mode() devuelve 2 cosas: la moda y la frecuencia de esa moda. 

#-----------------------------------------------------------------------------------------------------------------------------
#6 - Cual es el promedio de cilindrada de los vehículos en mtcars?
mean(mtcars$cyl)

#-----------------------------------------------------------------------------------------------------------------------------
#7 -Escribe un programa para guardar todos los hp de los vehículos de mtcars en un vector, calcular modo, media y 
#mediana, e imprimir la información. Luego, ordenar los datos y mostrar los 10 superiores
HP = mtcars$hp
print(paste("Media: ", mean(HP), "///",
            "Mediana: ", median(HP),"///",
            "Moda: ", DescTools::Mode(HP)[1]
            ))

#-----------------------------------------------------------------------------------------------------------------------------
#8 (INVESTIGAR) Escribe un programa que contenga 3 vectores con 5 numeros al azar, luego, unir los tres vectores en 
#una matriz, finalmente que muestre el contenido de la matriz, en cada ejecución la matriz debe cambiar (hint: cbind)
vector1 = sample(c(0:999), size=5, replace=TRUE)
vector2 = sample(c(0:999), size=5, replace=TRUE)
vector3 = sample(c(0:999), size=5, replace=TRUE)

matrix(cbind(vector1,vector2,vector3), nrow=3, ncol=5)

#-----------------------------------------------------------------------------------------------------------------------------
#9 - Usando el dataset notten, escribir un programa que me indique la temperatura mas baja de todo el set, la maxima, 
#y despues la minima y maxima por mes, y finalmente el minimo, maximo y promedio por año.


NOTTIM = data.frame(temp = as.matrix(nottem), year = 1920:1939, 
                    month = c('Jan',  'Feb' , 'Mar','Apr',  'May',  'Jun',  'Jul',  'Aug',  'Sep',  'Oct' , 'Nov' , 'Dec'))
#X mes:
min(NOTTIM$temp)
aggregate(temp ~ month, data = NOTTIM, FUN = min)
aggregate(temp ~ month, data = NOTTIM, FUN = max)

#Desp idem x anio...

#-----------------------------------------------------------------------------------------------------------------------------
#10 - Crear un dataset que contenga el nombre, apellido, edad, año de nacimiento, mes de nacimiento y día de nacimiento 
#de cada miembro de su grupo. Puede hacerse directamente o con cbind. Una vez hecho, que muestre el contenido, que 
#indique la edad maxima, la minima y el promedio de edad del grupo.

grupo = data.frame(
    nombre = c( "Estefy",'Gonza', 'Juanjo', 'Caro', 'Yao'),
    edad = c(25,26,27,28,29),
    anio = c(1990,1991,1992,1993,1994),
    mes = c("Ene", "Feb", "Mar","Oct","Dic"),
    dia = c(10,2,5,24,19))

max(grupo$edad)
mean(grupo$edad)


#-----------------------------------------------------------------------------------------------------------------------------
#11 - (INVESTIGAR) Usando el dataset creado en el ejercicio 10, imprimir el resumen de la información. Probar de hacer
#lo mismo con iris.

summary(grupo)

summary(iris)

#-----------------------------------------------------------------------------------------------------------------------------
#12 Del set IRIS, ordenar indicar el promedio de longitud de pétalos, solamente de la especie setosa. Luego indicar el 
#máximo de longitud de pétalo, solo de la especie virginica. (Se puede resolver solo con lo aclarado en esta guía pero 
#hay formas mas elegantes de hacerlo)
attach(iris)
setosa = iris[iris$Species=='setosa',]
mean(setosa$Petal.Length)

virgi = iris[iris$Species=='virginica',]
max(virgi$Petal.Length)

#-----------------------------------------------------------------------------------------------------------------------------
#13 Usando el dataset de nhtemp, cual es el promedio total de temperaturas? cual es el promedio total de temperaturas
#entre 1912 y 1922, y cual es el promedio de temperaturas entre 1961 y 1971. En todos los casos, cual es el mínimo y
#el máximo.

temperatura = data.frame(temp =as.matrix(nhtemp), year = 1912:1971)
prom_total  = mean(temperatura$temp)

temps_1 =  temperatura[(temperatura$year >= 1912 & temperatura$year <= 1922), ]
mean(temps_1$temp)
min(temps_1$temp)
max(temps_1$temp)

#-----------------------------------------------------------------------------------------------------------------------------
#13 Usando el dataset mtcars, indicar cuantos vehículos tienen caja de cambios en números impares
cambios = mtcars$gear
cambios_impares = cambios%%2!=0
sum(cambios_impares) #porque FALSE = 0 y TRUE = 1

#-----------------------------------------------------------------------------------------------------------------------------
#14 Calcular la relación entre los cilindros y el hp de los vehículos en mtcars y mostrarlo. Luego calcular, modo,
#mediana y promedio
cociente = mtcars$cyl / mtcars$hp
plot(cociente)
mean(cociente)
median(cociente)
DescTools::Mode(cociente)[1]

#-----------------------------------------------------------------------------------------------------------------------------
#15 - Usando cualquier dataset en datasets::, hacer un estudio aplicando todo lo visto hasta ahora, este ejercicio es 
#libre, pero se pide al menos un resumen, mediana, modo, promedio, alguna relacion, top de informacion, etc. 
#Esta informacion tiene que tener sentido y ser consistente dentro de los datos analizados.

summary(iris) #Summary
mean(iris$Petal.Width) #Media
median(iris$Sepal.Length) #Mediana
DescTools::Mode(iris$Sepal.Width)[1] #Moda

head(iris,15) #top15 datos

#Relacion ancho/largo sepalo vs ancho/largo petalo  
plot(iris$Sepal.Length/iris$Sepal.Width, iris$Petal.Length/iris$Petal.Width )



#BONUS
#Distribución normal al azar
n = floor(rnorm(10000, 500, 100)) #floor() redondea al entero mas cercano
t = table(n)
barplot(t)
#Les debería servir en estadística ;)
