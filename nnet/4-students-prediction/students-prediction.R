### Instalação dos pacotes (são os mesmos da classificação)
install.packages("caret") 
install.packages("e1071") 
install.packages("mlbench") 
install.packages("mice")
library(mlbench) 
library(caret) 
library(mice)

### Leitura dos dados
setwd("C:/Users/norto/Documents/Machine Learning Study/nnet/4-students-prediction")
dados <- read.csv("3 – Alunos - Dados.csv", header=T)
View(dados)

### Cria arquivo de treino e teste
set.seed(202695)
indices <- createDataPartition(dados$G3, p=0.80, list=FALSE) 
treino <- dados[indices,]
teste <- dados[-indices,]
### Treino com Hold-Out
set.seed(202695)
rna <- train(G3~., data=treino, method="nnet", linout=T, trace=FALSE)
rna
predicoes.rna <- predict(rna, teste)

### Pacote para cálculo das métricas (rmse)
install.packages("Metrics")
library(Metrics)
rmse(teste$G3, predicoes.rna)
r2 <- function(predito, observado) {
  return(1 - (sum((predito-observado)^2) / sum((observado-mean(observado))^2)))
}
r2(predicoes.rna, teste$G3)

### CV e parametrizacao da RNA
control <- trainControl(method = "cv", number = 10)
tuneGrid <- expand.grid(size = seq(from = 1, to = 3, by = 1), decay = seq(from = 0.1, to = 0.7, by = 0.3))
set.seed(202695)
rna <- train(G3~., data=treino, method="nnet", trainControl=control, tuneGrid=tuneGrid, linout=T, 
             MaxNWts=10000, maxit=2000, trace=F)
rna

### Predições e métricas
predicoes.rna <- predict(rna, teste)
rmse(teste$G3, predicoes.rna)
r2(predicoes.rna, teste$G3)

### PREDIÇÕES DE NOVOS CASOS
dados_novos_casos <- read.csv("3 – Alunos - Novos Casos.csv")
View(dados_novos_casos)
dados_novos_casos$G3 <- NULL
predict.rna <- predict(rna, dados_novos_casos)
resultado <- cbind(dados_novos_casos, predict.rna)
View(resultado)
