### Pacotes necessários:
#install.packages("e1071") 
#install.packages("caret")
library("caret")


### Leitura dos dados
setwd("C:/Users/norto/Documents/Machine Learning Study/knn/5-bank-prediction")
dados <- read.csv("4 – Banco - Dados.csv")
View(dados)

### Cria um arquivo com treino com 80% e teste com 20% das linhas de forma randomizada
set.seed(202695)
ran <- sample(1:nrow(dados), 0.8 * nrow(dados))
treino <- dados[ran,] 
teste <- dados[-ran,] 
### Faz um grid com valores para K e Executa o KNN
tuneGrid <- expand.grid(k = c(1,3,5,7,9))
set.seed(202695)
knn <- train(y ~ ., data = treino, method = "knn",tuneGrid=tuneGrid)
knn

### Faz a predição e mostra a matriz de confusão
predict.knn <- predict(knn, teste)

### PREDIÇÕES DE NOVOS CASOS
dados_novos_casos <- read.csv("4 – Banco -  Novos Casos.csv")
View(dados_novos_casos)
predict.knn <- predict(knn, dados_novos_casos)
dados_novos_casos$y <- NULL
resultado <- cbind(dados_novos_casos, predict.knn)
View(resultado)