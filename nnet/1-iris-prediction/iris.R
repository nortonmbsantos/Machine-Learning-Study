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
### Treinamento do modelo com o conjunto de treino
set.seed(202695)
rna <- train(Species~., data=treino, method="nnet",trace=FALSE)
rna

### Predições dos valores do conjunto de teste
predicoes.rna <- predict(rna, teste)
### Matriz de confusão
confusionMatrix(predicoes.rna, teste$Species)

### Salvamento e Carga dos modelos para uso posterior
getwd()
save(rna, file="rna.RData") 
load("rna.RData")