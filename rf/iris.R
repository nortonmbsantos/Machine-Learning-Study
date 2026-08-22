### Pacotes necessários:
install.packages("e1071") 
install.packages("caret")
library("caret")
### Leitura dos dados
data(iris)
dados <- iris
View(dados)


### ◉ Particionar a bases em treino (80%) e teste (20%) CLASSIFICAÇÃO - Íris
set.seed(202695)
indices <- createDataPartition(dados$Species, p=0.80, list=FALSE) 
treino <- dados[indices,]
teste <- dados[-indices,]
### Gerar um novo modelo usando RandonForest, predições e matriz de confusão
set.seed(202695)
rf <- train(Species~., data=treino, method="rf")
rf



### Predições com o arquivo de teste
predicoes.rf <- predict(rf, teste)
confusionMatrix(predicoes.rf, teste$Species)