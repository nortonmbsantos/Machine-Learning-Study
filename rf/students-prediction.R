### Instalação dos pacotes (são os mesmos da classificação)
install.packages("caret") 
install.packages("e1071") 
install.packages("mlbench") 
install.packages("mice")
library(mlbench) 
library(caret) 
library(mice)

### Leitura dos dados
setwd("C:/Users/norto/Documents/Machine Learning Study/databases")
dados <- read.csv("3 – Alunos - Dados.csv", header=T)
View(dados)

### Criar bases de Treino e Teste
set.seed(202095)
indices <- createDataPartition(dados$G3, p=0.80,list=FALSE)
treino <- dados[indices,] 
teste <- dados[-indices,]
### Treinar Randon Forest com a base de Treino 
set.seed(202095)
rf <- train(G3~., data=treino, method="rf")
rf

### Aplicar modelos treinados na base de Teste
predicoes.rf <- predict(rf, teste)
### Calcular as métricas
install.packages("Metrics")
library(Metrics)
rmse(teste$G3, predicoes.rf)
r2 <- function(predito, observado) {
  return(1 - (sum((predito-observado)^2) / sum((observado-mean(observado))^2)))
}
r2(predicoes.rf ,teste$G3)

#### Cross ◉ REGRESSÃO -validation RF – Alunos do Ensino médio
ctrl <- trainControl(method = "cv", number = 10)
set.seed(202095)
rf <- train(G3~., data=treino, method="rf", trControl=ctrl)
rf
predicoes.rf <- predict(rf, teste)
### Calcular as métricas
rmse(teste$G3, predicoes.rf)
r2 <- function(predito, observado) {
  return(1 - (sum((predito-observado)^2) / sum((observado-mean(observado))^2)))
}
r2(predicoes.rf ,teste$G3)

### PREDIÇÕES DE NOVOS CASOS
dados_novos_casos <- read.csv("3 – Alunos - Novos Casos.csv")
View(dados_novos_casos)
dados_novos_casos$G3 <- NULL
predict.rf <- predict(rf, dados_novos_casos)
resultado <- cbind(dados_novos_casos, predict.rf)
View(resultado)