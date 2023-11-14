#Ejemplos de Regresiones.

#Regresiones lineales

#correlación edad y altura (observaciones por edad, variable por altura)
edad=c(1,2,3,5,7,9,11,13) #edad para cada ovservación
altura=c(76.1,86.4,95.2,109.1,122.0,133.7,143.7,156.4) #variable, altura de un niño
edadporaltura=data.frame(edad,altura) 
print(edadporaltura) #observo el dataframe

#con el dataframe armado, trazo un plot simple
plot(edadporaltura)

#vemos que existe una relacion observable, entonces
regresion = lm(edad~altura, data=edadporaltura) #lm es la instrucción que me construye la relación. donde, pongo la variable de entrada, la variable de salida y los datos de donde se obtienen. 
print(regresion) #aca vemos la variacion de la varible de salida, mas o menos 15 cm en promedio, y el punto de intercepción del 0


#y si agrego una segunda observación, digamos de la altura de una niña
alturanina=c(74.1,83.4,92.2,105.1,120.0,129.7,137.7,145.4)
edadalturacomp=data.frame(edad,altura,alturanina)
plot(edadalturacomp)

#vemos que en realidad conviene verla por separado, de hecho no me permite la regresion lineal sino
alturanina2=data.frame(edad,alturanina)
plot(alturanina2)

#trazamos la regresión
regresion2=lm(edad~alturanina, data=alturanina2)
print(regresion2)

#Evaluamos el modelo de edad del niño:
summary(regresion)


#Informaciòn a tener en cuenta: Multiple R squared nos dice que tan ajustada es la regresion lineal a los datos reales donde 1 seria una relación 1 a 1, y 0 implica que no hay relacion, aca vemos 0.9922, que implica que es casi perfecto. En general cuando menor es, menor es la relacion entre variables.
#p-value, o prediction value, indica el porcentaje con el cual se puede considerar la correlacion. En este caso es practicamente 0, O sea, la capacidad de prediccion es cercana al 100. 

#Usandolo para predicciones:
interseccionen0 = -11.239690 #es el valor donde intersecta en la regresion
variacionporedad = 0.1527 #crecimiento promedio por edad
predecir_edad = interseccionen0 + variacionporedad * 100 #edad que tendria al alcanzar 100 cm.
print(predecir_edad) #poco mas de 4 años

#ahora que pasa si quiero predecir para una altura de dos metros
predecir_edad2 = interseccionen0 + variacionporedad * 200
print(predecir_edad2) #nos da 19 años, pero aca tenemos que rendir el modelo ante la realidad. 

#Veamos que pasa para 250 cm.
predecir_edad3 = interseccionen0 + variacionporedad * 250
print(predecir_edad3) #26 años, pero como sabemos 250 en un ser humano no es esperable. Es decir nuestro modelo tiene limites.


#Si hacemos esto en algo sin relación

#Numero de lunas en el sistema solar
planetas=c("mercurio","venus","tierra","marte","jupiter","saturno","urano","neptuno","pluton")#notese que me niego a reconocer que pluton no es mas un planeta. Este vector no lo voy a usar, pero por si quieren generar el dataframe completo.

OrdenPlaneta=c(1,2,3,4,5,6,7,8,9)
lunas=c(0,0,1,2,79,82,27,14,1) #y por consiguiente, como considero a pluton un planeta, debo considerar a caronte una luna
lunasdeSol=data.frame(planetas,OrdenPlaneta,lunas)
print(lunasdeSol)

#dataframe reducido para el plot
lunasSolOrden=data.frame(OrdenPlaneta,lunas)
print(lunasSolOrden)
plot(lunasSolOrden) 

#Visualmente ya se ve que no hay relacion lineal, igualmente calculamos la relacion
regresion3=lm(OrdenPlaneta~lunas, data=lunasSolOrden)
print(regresion3)

#y vemos los detalles de la regresión
summary(regresion3)

#vemos que la capacidad de predicción es inexistente, porque el Multiple R Squared es muy bajo, y el pvalue ronda el 50.  Concluimos que la relacion es inexistente y no se puede predecir valores con esto.

#Regresiones logisticas (o logicas) simples

#Este caso una de nuestras variables es una variable binaria o cualitativa de dos categorías donde no puedo aplicar la regresión lineal.
#Por ejemplo en Titanic, si sobrevivio o no. Pero se puede convertir en un operador logistico con la probabilidad de cada opcion, esto permite despues usar las predicciones que normalmente usariamos en regresion lineal.

install.packages("ISLR")
install.packages("tidyverse")
#Si les da error es porque ya lo tienen

library(tidyverse)
library(ISLR)

#Consideremos un ejemplo reducido de pasajeros del titanic (no nos centramos en genero ni otros datos fuera de la observacion)
ordendepasajero=c(1:25) #25 pasajeros
supervivencia=c(1,1,0,0,1,1,0,1,0,0,0,1,1,0,0,0,1,0,0,1,0,1,1,0,0) #donde, 1 indica que sobrevivio.
supervivencia_pasajeros=data.frame(ordendepasajero,supervivencia)
print(supervivencia_pasajeros)

#tenemos que convertir la variable de salida (supervivencia) a probabilidad
# Ajuste de un modelo logístico.
modelo_logistico <- glm(supervivencia ~ ordendepasajero, data = supervivencia_pasajeros, family = "binomial")
print(modelo_logistico)

#ploteamos el modelo
# Con geom_smooth se puede obtener el gráfico directamente.

ggplot(data = supervivencia_pasajeros, aes(x = ordendepasajero, y = supervivencia)) +
  geom_point(aes(color = as.factor(supervivencia)), shape = 1) + 
  stat_function(fun = function(x){predict(modelo_logistico,
                                          newdata = data.frame(ordendepasajero = x),
                                          type = "response")}) +
  theme_bw() +
  labs(title = "Regresión logística",
       y = "Probabilidad Supervivencia") +
  theme(legend.position = "none")

#interesante que si bien no se acerca al clasico S de la forma de las regresiones logisticas, tenemos un claro rango entre 0 y 1, esto es porque la probabilidad de supervivencia de esta pequeña muestra es en general baja.

#Veamos el resumen del modelo logistico
summary(modelo_logistico)

#Las predicciones en este modelo las dejamos de lado ya que requiere de conocimiento estadistico avanzado y en particular el ejemplo que tenemos no es ideal para predecir. Pero usando una prediccion simple:
intercepcion_0 <- 0.32960
ordendepasajero_p <- -0.04438
prediccion_supervivencia = intercepcion_0 + ordendepasajero_p * 26
print(prediccion_supervivencia)

#de nuevo, este ejemplo no es ideal porque una variable meramente indica el orden de pasajero, pero matematicamente asi se haría.



