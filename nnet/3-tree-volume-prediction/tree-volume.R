### Instalação dos pacotes (são os mesmos da classificação)
install.packages("caret") 
install.packages("e1071") 
install.packages("mlbench") 
install.packages("mice")
library(mlbench) 
library(caret) 
library(mice)

### Leitura dos dados da base de volumes
setwd("C:/Users/norto/Documents/Machine Learning Study/nnet/3-tree-volume-prediction")
dados <- read.csv("2 - Volume - Dados.csv", header=T)
View(dados)

## Cria arquivo de treino e teste
set.seed(202695)
indices <- createDataPartition(dados$Volume, p=0.80, list=FALSE) 
treino <- dados[indices,]
teste <- dados[-indices,]
### Treino com Hold-Out
set.seed(202695)
rna <- train(Volume~., data=treino, method="nnet", linout=T, trace=FALSE)
rna
predicoes.rna <- predict(rna, teste)

### Pacote para cálculo das métriscas (rmse)
install.packages("Metrics")
library(Metrics)
rmse(teste$Volume, predicoes.rna)
r2 <- function(predito, observado) {
  return(1 - (sum((predito-observado)^2) / sum((observado-mean(observado))^2)))
}
r2(predicoes.rna, teste$Volume)

### CV e parametrizacao da RNA
control <- trainControl(method = "cv", number = 10)
tuneGrid <- expand.grid(size = seq(from = 1, to = 10, by = 1), decay = seq(from = 0.1, to = 0.9, by = 0.3))
set.seed(202695)
rna <- train(Volume~., data=treino, method="nnet", trainControl=control, tuneGrid=tuneGrid, linout=T, 
             MaxNWts=10000, maxit=2000, trace=F)
rna

### Predições e métricas
predicoes.rna <- predict(rna, teste)
rmse(teste$Volume, predicoes.rna)
r2(predicoes.rna, teste$Volume)

### PREDIÇÕES DE NOVOS CASOS
dados_novos_casos <- read.csv("2 - Volume - Dados - Novos Casos.csv")
View(dados_novos_casos)
dados_novos_casos$Volume <- NULL
predict.rna <- predict(rna, dados_novos_casos)
resultado <- cbind(dados_novos_casos, predict.rna)
View(resultado)