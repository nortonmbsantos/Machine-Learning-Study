# Execute apenas uma vez para instalar:
setwd("C:/Users/norto/Documents/Machine Learning Study/breast-cancer-prediction")
### Leitura dos dados
dados <- read.csv("1 - Cancer de Mama - Dados.csv")

### Retira o atributo ID
dados$Id <- NULL
View(dados)

### Cria um arquivo com treino com 80% e teste com 20% das linhas de forma randomizada
set.seed(202695)
ran <- sample(1:nrow(dados), 0.8 * nrow(dados))
treino <- dados[ran,] 
teste <- dados[-ran,] 
### Faz um grid com valores para K e 
### Executa o KNN
tuneGrid <- expand.grid(k = c(1,3,5,7,9))
set.seed(1912)
knn <- train(Class ~ ., data = treino, method = "knn",tuneGrid=tuneGrid)
knn

### Faz a predição e mostra a matriz de confusão
predict.knn <- predict(knn, teste)
confusionMatrix(predict.knn, as.factor(teste$Class))

### PREDIÇÕES DE NOVOS CASOS
dados_novos_casos <- read.csv("1 - Cancer de Mama - Dados - Novos Casos.csv")
dados_novos_casos$Id <- NULL
View(dados_novos_casos)
     
predict.knn <- predict(knn, dados_novos_casos)
resultado <- cbind(dados_novos_casos, predict.knn)
resultado$Class <- NULL
View(resultado)
     