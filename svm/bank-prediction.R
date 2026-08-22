### Instalação dos pacotes necessários
install.packages("caret") 
install.packages("e1071") 
library(caret) 
install.packages("mlbench") 
install.packages("mice")
library(mlbench) 
library(mice)

### Leitura dos dados
setwd("C:/Users/norto/Documents/Machine Learning Study/databases")
dados <- read.csv("4 – Banco - Dados.csv")
View(dados)

### Criar bases de Treino e Teste
set.seed(202695)
indices <- createDataPartition(dados$y, p=0.80,list=FALSE)
treino <- dados[indices,] 
teste <- dados[-indices,]
### Treinar SVM com a base de Treino 
set.seed(202695)
svm <- train(y~., data=treino, method="svmRadial") 
svm

### Aplicar modelos treinados na base de Teste
predict.svm <- predict(svm, teste)
confusionMatrix(predict.svm, as.factor(teste$y))

#### Cross-validation SVM
ctrl <- trainControl(method = "cv", number = 10)
set.seed(202695)
svm <- train(y~., data=treino, method="svmRadial", trControl=ctrl)
svm

### Matriz de confusao com todos os dados
predict.svm <- predict(svm, teste)
confusionMatrix(predict.svm, as.factor(teste$y))

#### Vários C e sigma
tuneGrid = expand.grid(C=c(1, 2, 10, 50, 100), sigma=c(.01, .015, 0.2))
set.seed(202695)
svm <- train(y~., data=treino, method="svmRadial", trControl=ctrl, tuneGrid=tuneGrid)
svm

### Matriz de confusao com todos os dados
predict.svm <- predict(svm, teste)
confusionMatrix(predict.svm, as.factor(teste$y))

### PREDIÇÕES DE NOVOS CASOS
dados_novos_casos <- read.csv("4 – Banco -  Novos Casos.csv") 
View(dados_novos_casos)
predict.svm <- predict(svm, dados_novos_casos)
resultado <- cbind(dados_novos_casos, predict.svm)
resultado$y <- NULL
View(resultado)