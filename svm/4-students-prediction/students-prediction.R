### Instalação dos pacotes (são os mesmos da classificação)
install.packages("caret") 
install.packages("e1071") 
install.packages("mlbench") 
install.packages("mice")
library(mlbench) 
library(caret) 
library(mice)

### Leitura dos dados
setwd("C:/Users/norto/Documents/Machine Learning Study/svm/4-students-prediction")
dados <- read.csv("3 – Alunos - Dados.csv", header=T)
View(dados)

### Criar bases de Treino e Teste
set.seed(202695)
indices <- createDataPartition(dados$G3, p=0.80,list=FALSE)
treino <- dados[indices,] 
teste <- dados[-indices,]
### Treinar SVM com a base de Treino 
set.seed(202695)
svm <- train(G3~., data=treino, method="svmRadial") 
svm

### Aplicar modelos treinados na base de Teste
predicoes.svm <- predict(svm, teste)
### Calcular as métricas
rmse(teste$G3, predicoes.svm)
r2 <- function(predito, observado) {
  return(1 - (sum((predito-observado)^2) / sum((observado-mean(observado))^2)))
}
r2(predicoes.svm,teste$G3)

#### Cross-validation SVM
ctrl <- trainControl(method = "cv", number = 10)
set.seed(202695)
svm <- train(G3~., data=treino, method="svmRadial", trControl=ctrl)
svm

### Aplicar modelos treinados na base de Teste
predicoes.svm <- predict(svm, teste)
### Calcular as métricas
rmse(teste$G3, predicoes.svm)
r2 <- function(predito, observado) {
  return(1 - (sum((predito-observado)^2) / sum((observado-mean(observado))^2)))
}
r2(predicoes.svm ,teste$G3)

#### Vários C e sigma
tuneGrid = expand.grid(C=c(1, 2, 10, 50, 100), sigma=c(.01, .015, 0.2))
set.seed(202695)
svm <- train(G3~., data=treino, method="svmRadial", trControl=ctrl, tuneGrid=tuneGrid)
svm


### Aplicar modelos treinados na base de Teste
predicoes.svm <- predict(svm, teste)
### Calcular as métricas
rmse(teste$G3, predicoes.svm)
r2 <- function(predito, observado) {
  return(1 - (sum((predito-observado)^2) / sum((observado-mean(observado))^2)))
}
r2(predicoes.svm,teste$G3)

### PREDIÇÕES DE NOVOS CASOS
dados_novos_casos <- read.csv("3 – Alunos - Novos Casos.csv")
View(dados_novos_casos)
dados_novos_casos$G3 <- NULL
predict.svm <- predict(svm, dados_novos_casos)
resultado <- cbind(dados_novos_casos, predict.svm)
View(resultado)