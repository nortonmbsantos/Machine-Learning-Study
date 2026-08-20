### Instalação dos pacotes necessários
install.packages("caret") 
install.packages("e1071") 
library(caret) 
install.packages("mlbench") 
install.packages("mice")
library(mlbench) 
library(mice)


### Leitura dos dados
setwd("C:/Users/norto/Documents/Machine Learning Study/nnet/5-bank-prediction")
dados <- read.csv("4 – Banco - Dados.csv")
View(dados)

### Criar bases de Treino e Teste
set.seed(202695)
indices <- createDataPartition(dados$y, p=0.80,list=FALSE)
treino <- dados[indices,] 
teste <- dados[-indices,]
### Treinar o modelo com Hold-out
set.seed(202695)
rna <- train(y~., data=treino, method="nnet",trace=FALSE)
rna



### Predições dos valores do conjunto de teste
predict.rna <- predict(rna, teste)
### Matriz de confusão
confusionMatrix(predict.rna, as.factor(teste$y))


### indica o método cv e numero de folders 10
ctrl <- trainControl(method = "cv", number = 10)
### executa a RNA com esse ctrl
set.seed(202695)
rna <- train(y~., data=treino, method="nnet",trace=FALSE, trControl=ctrl)
predict.rna <- predict(rna, teste) 
confusionMatrix(predict.rna, as.factor(teste$y))

### size, decay
grid <- expand.grid(size = seq(from = 1, to = 35, by = 10),decay = seq(from = 0.1, to = 0.6, by = 0.3))
set.seed(202695)
rna <- train(
  form = y~. , 
  data = treino , 
  method = "nnet" , 
  tuneGrid = grid , 
  trControl = ctrl , 
  maxit = 2000,trace=FALSE) 

### Verifica o resultado do Treinamento
rna

### Faz as predições e mostra matriz de confusão
predict.rna <- predict(rna, teste)
confusionMatrix(predict.rna, as.factor(teste$y))

### PREDIÇÕES DE NOVOS CASOS
dados_novos_casos <- read.csv("4 – Banco -  Novos Casos.csv")
View(dados_novos_casos)
predict.rna <- predict(rna, dados_novos_casos)
dados_novos_casos$y <- NULL
resultado <- cbind(dados_novos_casos, predict.rna)
View(resultado)