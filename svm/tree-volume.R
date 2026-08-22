### Pacotes necessários:
install.packages("e1071") 
install.packages("kernlab")
install.packages("caret")
install.packages("Metrics")

### Leitura dos dados da base de volumes
setwd("C:/Users/norto/Documents/Machine Learning Study/databases")
dados <- read.csv("2 - Volume - Dados.csv", header=T)
View(dados)

### Criar bases de Treino e Teste
set.seed(1912)
indices <- createDataPartition(dados$Volume, p=0.80,list=FALSE)
treino <- dados[indices,] 
teste <- dados[-indices,]
### Treinar SVM com a base de Treino 
set.seed(1912)
svm <- train(Volume~., data=treino, method="svmRadial") 
svm

### Aplicar modelos treinados na base de Teste
predicoes.svm <- predict(svm, teste)
### Calcular as métricas
library(Metrics)
library("caret")
rmse(teste$Volume, predicoes.svm)
r2 <- function(predito, observado) {
  return(1 - (sum((predito-observado)^2) / sum((observado-mean(observado))^2)))
}
r2(predicoes.svm,teste$Volume)

#### Cross-validation SVM
ctrl <- trainControl(method = "cv", number = 10)
set.seed(1912)
svm <- train(Volume~., data=treino, method="svmRadial", trControl=ctrl)
svm

### Aplicar modelos treinados na base de Teste
predicoes.svm <- predict(svm, teste)
### Calcular as métricas
rmse(teste$Volume, predicoes.svm)
r2(predicoes.svm,teste$Volume)

#### Vários C e sigma
tuneGrid = expand.grid(C=c(1, 2, 10, 50, 100), sigma=c(.01, .015, 0.2))
set.seed(1912)
svm <- train(Volume~., data=treino, method="svmRadial", trControl=ctrl, tuneGrid=tuneGrid)
svm

### Aplicar modelos treinados na base de Teste
predicoes.svm <- predict(svm, teste)
### Calcular as métricas
rmse(teste$Volume, predicoes.svm)
r2(predicoes.svm,teste$Volume)

### PREDIÇÕES DE NOVOS CASOS
dados_novos_casos <- read.csv("2 - Volume - Dados - Novos Casos.csv")
View(dados_novos_casos)
dados_novos_casos$Volume <- NULL
predict.svm <- predict(svm, dados_novos_casos)
resultado <- cbind(dados_novos_casos, predict.svm)
View(resultado)