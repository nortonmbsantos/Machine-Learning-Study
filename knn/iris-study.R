### Pacotes necessários:
#install.packages("e1071") 
#install.packages("caret")
library("caret")
### Leitura dos dados
data(iris)
dados <- iris
View(dados)

### Cria um arquivo com 80% das linhas para treino e 20% para teste
set.seed(1912)
ran <- sample(1:nrow(dados), 0.8 * nrow(dados))
treino <- dados[ran,] 
teste <- dados[-ran,] 

### Cria um grid com vários valores para K e faz o 
### treinamento
tuneGrid <- expand.grid(k = c(1,3,5,7,9))

set.seed(1912)
knn <- train(Species ~ ., data = treino, method = "knn",tuneGrid=tuneGrid)
knn

### Faz a predição e mostra a matriz de confusão
predict.knn <- predict(knn, teste)
confusionMatrix(predict.knn, as.factor(teste$Species))



