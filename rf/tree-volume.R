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
set.seed(202695)
indices <- createDataPartition(dados$Volume, p=0.80,list=FALSE)
treino <- dados[indices,] 
teste <- dados[-indices,]
### Treinar Randon Forest com a base de Treino 
set.seed(202695)
rf <- train(Volume~., data=treino, method="rf")
rf

### Aplicar modelos treinados na base de Teste
predicoes.rf <- predict(rf, teste)
### Calcular as métricas
install.packages("Metrics")
library(Metrics)
rmse(teste$Volume, predicoes.rf)
r2 <- function(predito, observado) {
  return(1 - (sum((predito-observado)^2) / sum((observado-mean(observado))^2)))
}
r2(predicoes.rf,teste$Volume)

#### Cross-validation RF
ctrl <- trainControl(method = "cv", number = 10)
set.seed(202695)
rf <- train(Volume~., data=treino, method="rf", trControl=ctrl)
rf
predicoes.rf <- predict(rf, teste)
### Calcular as métricas
rmse(teste$Volume, predicoes.rf)
r2 <- function(predito, observado) {
  return(1 - (sum((predito-observado)^2) / sum((observado-mean(observado))^2)))
}
r2(predicoes.rf ,teste$Volume)

#### Vários mtry
tuneGrid = expand.grid(mtry=c(2, 5, 7, 9))
set.seed(202695)
rf <- train(Volume~., data=treino, method="rf", trControl=ctrl, tuneGrid=tuneGrid)
rf
predicoes.rf <- predict(rf, teste)
rmse(teste$Volume, predicoes.rf)
r2(predicoes.rf ,teste$Volume)

### PREDIÇÕES DE NOVOS CASOS
dados_novos_casos <- read.csv("2 - Volume - Dados - Novos Casos.csv")
View(dados_novos_casos)
dados_novos_casos$Volume <- NULL
predict.rf <- predict(rf, dados_novos_casos)
resultado <- cbind(dados_novos_casos, predict.rf)
View(resultado)