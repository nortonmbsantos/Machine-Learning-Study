### Pacotes necessários:
install.packages("e1071") 
install.packages("kernlab")
install.packages("caret")
library("caret")
install.packages("mice")
library(mice)

### Obter os dados
setwd("C:/Users/norto/Documents/Machine Learning Study/svm/2-breast-cancer-prediction")
dados <- read.csv("1 - Cancer de Mama - Dados.csv")
### Retira o ID e preenche valores faltantes
dados$Id <- NULL
View(dados)

### Criar bases de Treino e Teste
set.seed(202695)
indices <- createDataPartition(dados$Class, p=0.80,list=FALSE)
treino <- dados[indices,] 
teste <- dados[-indices,]
### Treinar SVM com a base de Treino 
set.seed(202695)
svm <- train(Class~., data=treino, method="svmRadial") 
svm


### 6. Aplicar modelos treinados na base de Teste
predict.svm <- predict(svm, teste)
confusionMatrix(predict.svm, as.factor(teste$Class))


#### Cross-validation SVM
ctrl <- trainControl(method = "cv", number = 10)
set.seed(202695)
svm <- train(Class~., data=treino, method="svmRadial", trControl=ctrl)
svm

### Matriz de confusão
predict.svm <- predict(svm, teste)
confusionMatrix(predict.svm, as.factor(teste$Class))


#### Vários C e sigma
tuneGrid = expand.grid(C=c(1, 2, 10, 50, 100), sigma=c(.01, .015, 0.2))
set.seed(202695)
svm <- train(Class~., data=treino, method="svmRadial", trControl=ctrl, tuneGrid=tuneGrid)
svm

### Matriz de confusão
predict.svm <- predict(svm, teste)
confusionMatrix(predict.svm, as.factor(teste$Class))

### PREDIÇÕES DE NOVOS CASOS
dados_novos_casos <- read.csv("1 - Cancer de Mama - Dados - Novos Casos.csv")
dados_novos_casos$Id <- NULL
View(dados_novos_casos)
predict.svm <- predict(svm, dados_novos_casos)
resultado <- cbind(dados_novos_casos, predict.svm)
resultado$Class <- NULL
View(resultado)