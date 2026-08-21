### Pacotes necessários:
install.packages("e1071") 
install.packages("caret")
library("caret")
### Leitura dos dados
data(iris)
dados <- iris
View(dados)


### Particionar a bases em treino (80%) e teste (20%)
set.seed(202695)
indices <- createDataPartition(dados$Species, p=0.80, list=FALSE) 
treino <- dados[indices,]
teste <- dados[-indices,]
### Gerar um novo modelo usando SVM, predições e matriz de confusão
set.seed(202695)
svm <- train(Species~., data=treino, method="svmRadial") 
svm

### Predições com o arquivo de teste
predicoes.svm <- predict(svm, teste)
confusionMatrix(predicoes.svm, teste$Species)