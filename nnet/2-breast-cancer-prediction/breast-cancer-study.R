### Instalação dos pacotes necessários
install.packages("caret") 
install.packages("e1071") 
library(caret) 
install.packages("mlbench") 
install.packages("mice")
library(mlbench) 
library(mice)

### Obter os dados
setwd("C:/Users/norto/Documents/Machine Learning Study/nnet/2-breast-cancer-prediction")
temp_dados <- read.csv("1 - Cancer de Mama - Dados.csv")
View(temp_dados)


### Tratar o Id e Missing Values
temp_dados$Id <- NULL
imp <- mice(temp_dados) 
dados <- complete(imp, 1)
### Criar bases de Treino e Teste
set.seed(202695)
indices <- createDataPartition(dados$Class, p=0.80,list=FALSE)
treino <- dados[indices,] 
teste <- dados[-indices,]
### Treinar o modelo com Hold-out
set.seed(202695)
rna <- train(Class~., data=treino, method="nnet",trace=FALSE)
rna

### Predições dos valores do conjunto de teste
predict.rna <- predict(rna, teste)
### Matriz de confusão
confusionMatrix(predict.rna, as.factor(teste$Class))



### indica o método cv e numero de folders 10
ctrl <- trainControl(method = "cv", number = 10)
### executa a RNA com esse ctrl
set.seed(1912)
rna <- train(Class~., data=treino, method="nnet",trace=FALSE, trControl=ctrl)
predict.rna <- predict(rna, teste) 
confusionMatrix(predict.rna, as.factor(teste$Class))


### size, decay
grid <- expand.grid(size = seq(from = 1, to = 45, by = 10),decay = seq(from = 0.1, to = 0.9, by = 0.3))
set.seed(1912)
rna <- train(
  form = Class~. , 
  data = treino , 
  method = "nnet" , 
  tuneGrid = grid , 
  trControl = ctrl , 
  maxit = 2000,trace=FALSE)

### Verifica o resultado do Treinamento
rna


### Faz as predições e mostra matriz de confusão
predict.rna <- predict(rna, teste)
confusionMatrix(predict.rna, as.factor(teste$Class))


### PREDIÇÕES DE NOVOS CASOS
dados_novos_casos <- read.csv("1 - Cancer de Mama - Dados - Novos Casos.csv")
dados_novos_casos$Id <- NULL
View(dados_novos_casos)
predict.rna <- predict(rna, dados_novos_casos)
dados_novos_casos$Class <- NULL
resultado <- cbind(dados_novos_casos, predict.rna)
View(resultado)


### SALVAR O MELHOR MODELO PARA USO NA PRÁTICA
###SALVAR O MODELO
getwd()
saveRDS(rna,"Material 00 - 2 - Cancer de Mama - R - Melhor Modelo.rds")
### LER E APLICAR O MODELO
modelo_lido <- readRDS("./Material 00 - 2 - Cancer de Mama - R - Melhor Modelo.rds")
novas_predicoes <- predict(modelo_lido, teste)
confusionMatrix(novas_predicoes, as.factor(teste$Class))



