#Repaso de conceptos básicos de R

#variables

#Variables simples
Numero <- 30
print(Numero)

#Ingreso manual
NumeroMan <- readline("Ingresar numero:  ")
print(NumeroMan)

#alternativamente
(Numero <- 30)

#al reves tambien funciona
204 -> NumeroInv
print(NumeroInv)

#si bien puedo forzar asignacion de tipo de dato, R lo reconoce
Hola <- 'Hola Mundo'
print(Hola)

#para definir el tipo, uso as.type donde type es el tipo de dato
NumeroA <- '22'
print(NumeroA)
str(NumeroA)

#Vectores
#Los vectores son un conjunto de valores individuales contenidos en una sola variable de este tipo.
x <- c(7,9,3,4,5,3,7,8)
print(x)

#Tambien puedo crear vectores vacios indicando el tipo
vectorlogico <- vector('logical', length=12)
print(vectorlogico)

#Los datos se pueden estructurar en vectores, factores, dataframes, tibbles, matrices y listas. a la larga, las mas complejas terminan componiendose de vectores.

#Operadores matematicos básicos
2+7 #suma
2-9 #resta
5*10 #multiplicación
9/3 #division
9^2 #potencia
10%%3 #Parte entera o resto
9%%3 #Parte entera o resto

#Funciones matemáticas, hay más pero para usar de ejemplo
sqrt(9) #raiz cuadrada
log(2, 10) #log de 2 en base 10
abs (-1) #convertir a valor absoluto

#Todo esto se puede operar entre variables operables (variables con variable, vector con vector, matrix con matrix).

#Operadores lógicos
!TRUE #negacion
Numero == NumeroA #comparacion
1 %in% c(4,3,2) #verifico si el numero 1 esta en el vector
Numero != NumeroA #verifico si los dos numeros o variables no son iguales
# <,>,<=,>= menor, mayor, menor o igual y mayor o igual
Numero > NumeroA | NumeroA < NumeroInv #verdadero si alguna condicion es verdadera, o el operador 'O'
Numero > NumeroA & NumeroA < NumeroInv #ambas condiciones deben ser verdaeras o 'y'

#FACTORIZACIÓN DE VECTORES
letras <- c("A","B","A","A","A","A","B","A","C","C","B")
print(letras)
factor(letras)

#Creando dataframes
DF <- data.frame(Col1 = 1:5, #numero de observaciones
                 Col2 = c("Sit1","Sit1","Sit2","Sit2","Sit3"), 
                 Log = c(T,T,F,F,T),
                 Fct = factor(c("A","B","C","B","A")))

print(DF)

#plotear vectores
plot(c(7,9,3,4,5,3,7,8))

#Datasets integrados para práctica
datasets::attitude

#readline
fun <- function(){
  x <- readline("What is the value of x?")  
  y <- readline("What is the value of y?")
  t <- readline("What are the T values?")
  v <- readline("What are the V values?")
  
  x <- as.numeric(unlist(strsplit(x, ",")))
  y <- as.numeric(unlist(strsplit(y, ",")))
  t <- as.numeric(unlist(strsplit(t, ",")))
  v <- as.numeric(unlist(strsplit(v, ",")))
  
  out1 <- x + y
  out2 <- t + v
  
  return(list(out1, out2))
  
}
