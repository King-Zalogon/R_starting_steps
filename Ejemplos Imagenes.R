#Ejemplo de EBIMAGE
# install.packages('EBImage')  
library(EBImage)

Loro = system.file("images", "sample.png", package="EBImage") #Leo la imagen de ejemplo del paquete

Lorito = readImage(Loro) #la cargo en una variable

display(Lorito) #la muestro

#cargando otra imagen

Tigre = readImage('http://images6.fanpop.com/image/photos/36600000/Tigers-image-tigers-36642865-1600-1200.jpg') #leo y imagen de internet, si no funciona es porque me cambiaron la URL
display(Tigre) #muestro la imagen

#Ejemplos OCR
#CON PATENTES
# install.packages("tesseract") #iNSTALANDO EL PAQUETE
?tesseract_download #DETALLES DEL PAQUETE
library(tesseract) 
eng <- tesseract("eng") #USAMOS INGLES PORQUE TIENE MENOS CARACTERES
textO <- tesseract::ocr("https://www.licenseplateworld.com/Uploads/Product/5e202ef7e286a.jpg", engine = eng) #IMAGEN A TEXTO
cat(textO) #MOSTRANDO 

library(EBImage)
patente = readImage('https://www.licenseplateworld.com/Uploads/Product/5e202ef7e286a.jpg') #leo y imagen de internet, si no funciona es porque me cambiaron la URL
display(patente) #muestro la imagen

#CON INMAGEN
library(tesseract)
eng <- tesseract("eng")
textO <- tesseract::ocr("https://churchfm316.com/wp-content/uploads/2021/01/shutterstock_744158998-2-2048x1365.jpg", engine = eng)
cat(textO)

#viendo detalles de la imagen, pack EBImage
str(patente)
str(Tigre)
Tigre #composición
dim(Tigre) #dimension de la imagen
hist(Tigre) #composición por pixeles

#Manipulando imagenes
print(Tigre, short=TRUE) #data de la imagen
display(Tigre,method='raster',all=TRUE)

#Cropping
Lorito=Lorito[366:749, 58:441]
display(Lorito)

#inversion de colores
Tigre_neg = max(Tigre) - Tigre
display(Tigre_neg)


#Brillo, contraste y gamma
Tigre_comb = combine(
  Tigre,
  Tigre + 0.3,
  Tigre * 2,
  Tigre ^ 0.5
)

display( tile(Tigre_comb, numberOfFrames(Tigre_comb), lwd = 20, fg.col = "white") )

#Separar background de foreground(ajustar valor hasta llegar a punto deseado), en imagenes de escalas de grises con .5 genera una imagen blanco y negro
Tigre_BW = Tigre > .10
display(Tigre_BW)

Lorito_BW = Lorito > .5
display(Lorito_BW)

