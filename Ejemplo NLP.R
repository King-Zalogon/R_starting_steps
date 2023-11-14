#Ejemplo básico de NLP

#Ojo, este ejemplo requiere de alrededor de 2.1gb de memoria en su sistema. NOTA: Este ejemplo no es mio, porque toma bastante hacer un NLP, esta tomado y traducido de: https://blogs.rstudio.com/ai/posts/2020-07-30-state-of-the-art-nlp-models-from-r/

#agregue una libreria que se olvidaron en el ejemplo original como visualizaciones para la estructura del dataset.

#Instalamos paquetes que se requieren
install.packages("keras")
install.packages("tensorflow")
install.packages("text2vec")
install.packages("dplyr")
install.packages("tfdatasets")

#Instalamos esto de python
reticulate::py_install('transformers', pip = TRUE)

#cargamos las librerias
library(keras)
library(tensorflow)
library(dplyr)
library(text2vec)
library(tfdatasets)
transformer = reticulate::import('transformers')

#en text2vec tenemos un dataset integrado para este ejemplo. Pueden usar y probar otros para ver resultados.

#Solo para ver los detalles del dataset de ejemplo:
summary(movie_review)
str(movie_review)
?movie_review

#este dataset es binario, donde 1 identifica reviews positivas y 0 a las negativas.

#preparamos los datos:

library(text2vec)
data("movie_review")
df = movie_review %>% rename(target = sentiment, comment_text = review) %>% 
  sample_n(2000) %>% 
  data.table::as.data.table()

#generamos la parte de entrenamiento y prueba
idx_train = sample.int(nrow(df)*0.8)
train = df[idx_train,]
test = df[!idx_train,]

#vamos a entrenar en tres modelos para proceso de lenguaje GPT-2, RoBERTa y Electra
ai_m = list(
  c('TFGPT2Model',       'GPT2Tokenizer',       'gpt2'),
  c('TFRobertaModel',    'RobertaTokenizer',    'roberta-base'),
  c('TFElectraModel',    'ElectraTokenizer',    'google/electra-small-generator')
)

#y consideramos estos parametros
max_len = 50L
epochs = 2
batch_size = 10

# creamos la lista de resultados modelo
gather_history = list()

for (i in 1:length(ai_m)) {
  
  # tokenizador
  tokenizer = glue::glue("transformer${ai_m[[i]][2]}$from_pretrained('{ai_m[[i]][3]}',
                         do_lower_case=TRUE)") %>% 
    rlang::parse_expr() %>% eval()
  
  # modelo
  model_ = glue::glue("transformer${ai_m[[i]][1]}$from_pretrained('{ai_m[[i]][3]}')") %>% 
    rlang::parse_expr() %>% eval()
  
  # inputs
  text = list()
  # outputs
  label = list()
  
  data_prep = function(data) {
    for (i in 1:nrow(data)) {
      
      txt = tokenizer$encode(data[['comment_text']][i],max_length = max_len, 
                             truncation=T) %>% 
        t() %>% 
        as.matrix() %>% list()
      lbl = data[['target']][i] %>% t()
      
      text = text %>% append(txt)
      label = label %>% append(lbl)
    }
    list(do.call(plyr::rbind.fill.matrix,text), do.call(plyr::rbind.fill.matrix,label))
  }
  
  train_ = data_prep(train)
  test_ = data_prep(test)
  
  # corte del dataset
  tf_train = tensor_slices_dataset(list(train_[[1]],train_[[2]])) %>% 
    dataset_batch(batch_size = batch_size, drop_remainder = TRUE) %>% 
    dataset_shuffle(128) %>% dataset_repeat(epochs) %>% 
    dataset_prefetch(tf$data$experimental$AUTOTUNE)
  
  tf_test = tensor_slices_dataset(list(test_[[1]],test_[[2]])) %>% 
    dataset_batch(batch_size = batch_size)
  
  # creamos capa de inserción
  input = layer_input(shape=c(max_len), dtype='int32')
  hidden_mean = tf$reduce_mean(model_(input)[[1]], axis=1L) %>% 
    layer_dense(64,activation = 'relu')
  # creamos una capa de salida para clasificación binaria
  output = hidden_mean %>% layer_dense(units=1, activation='sigmoid')
  model = keras_model(inputs=input, outputs = output)
  
  # compilamos con AUC score
  model %>% compile(optimizer= tf$keras$optimizers$Adam(learning_rate=3e-5, epsilon=1e-08, clipnorm=1.0),
                    loss = tf$losses$BinaryCrossentropy(from_logits=F),
                    metrics = tf$metrics$AUC())
  
  print(glue::glue('{ai_m[[i]][1]}'))
  # entrenamos el modelo
  history = model %>% keras::fit(tf_train, epochs=epochs, #paso a paso por epoca; steps_per_epoch=len/batch_size,
  validation_data=tf_test)
  gather_history[[i]]<- history
  names(gather_history)[i] = ai_m[[i]][1]
}

#Extracción de resultados para ver las mediciones:
  
  res = sapply(1:3, function(x) {
    do.call(rbind,gather_history[[x]][["metrics"]]) %>% 
      as.data.frame() %>% 
      tibble::rownames_to_column() %>% 
      mutate(model_names = names(gather_history[x])) 
  }, simplify = F) %>% do.call(plyr::rbind.fill,.) %>% 
  mutate(rowname = stringr::str_extract(rowname, 'loss|val_loss|auc|val_auc')) %>% 
  rename(epoch_1 = V1, epoch_2 = V2)


