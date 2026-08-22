### Instalação dos pacotes
library(caret)
### Leitura dos dados
setwd("C:/Users/norto/Documents/Machine Learning Study/databases")
dados <- read.csv("2 - Volume - Dados.csv", header=T)
View(dados)

### Cria arquivos de treino e teste
set.seed(202695)
ind <- createDataPartition(dados$Volume, p=0.80, list = FALSE)
treino <- dados[ind,]
teste <- dados[-ind,]
### Prepara um grid com os valores de k que 
### serão usados 
tuneGrid <- expand.grid(k = c(1,3,5,7,9))
### Executa o Knn com esse grid
set.seed(202695)
knn <- train(Volume ~ ., data = treino, method = "knn",
             tuneGrid=tuneGrid)
knn

### Aplica o modelo no arquivo de teste
predict.knn <- predict(knn, teste)
### Mostra as métricas
#install.packages("Metrics")
library(Metrics)
rmse(teste$Volume, predict.knn)
r2 <- function(predito, observado) {
  return(1 - (sum((predito-observado)^2) / sum((observado-mean(observado))^2)))
}
r2(predict.knn,teste$Volume)

### PREDIÇÕES DE NOVOS CASOS
dados_novos_casos <- read.csv("2 - Volume - Dados - Novos Casos.csv")
View(dados_novos_casos)
predict.knn <- predict(knn, dados_novos_casos)
dados_novos_casos$Volume <- NULL
resultado <- cbind(dados_novos_casos, predict.knn)
View(resultado)
