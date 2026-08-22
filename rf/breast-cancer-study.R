### Pacotes necessários:
install.packages("e1071") 
install.packages("kernlab")
install.packages("caret")
library("caret")
install.packages("mice")
library(mice)


### Obter os dados
setwd("C:/Users/norto/Documents/Machine Learning Study/databases")
dados <- read.csv("1 - Cancer de Mama - Dados.csv")
### Retira o ID e preenche valores faltantes
dados$Id <- NULL
View(dados)
### Criar bases de Treino e Teste
set.seed(202695)
indices <- createDataPartition(dados$Class, p=0.80,list=FALSE)
treino <- dados[indices,] 
teste <- dados[-indices,]
### Treinar Random Forest com a base de Treino
set.seed(202695)
rf <- train(Class~., data=treino, method="rf")
rf

### Aplicar modelos treinados na base de Teste
predict.rf <- predict(rf, teste)
confusionMatrix(predict.rf, as.factor(teste$Class)) 

#### Cross-validation
ctrl <- trainControl(method = "cv", number = 10)
set.seed(202695)
rf <- train(Class~., data=treino, method="rf", trControl=ctrl)
rf

### Matriz de confusao
predict.rf <- predict(rf, teste)
confusionMatrix(predict.rf, as.factor(teste$Class))

#### Vários mtry
tuneGrid = expand.grid(mtry=c(2, 5, 7, 9))
set.seed(202695)
rf <- train(Class~., data=treino, method="rf", trControl=ctrl, tuneGrid=tuneGrid)
rf

### matriz de confusao
predict.rf <- predict(rf, teste)
confusionMatrix(predict.rf, as.factor(teste$Class))

### PREDIÇÕES DE NOVOS CASOS
dados_novos_casos <- read.csv("1 - Cancer de Mama - Dados - Novos Casos.csv")
dados_novos_casos$Id <- NULL
View(dados_novos_casos)
predict.rf <- predict(rf, dados_novos_casos)
dados_novos_casos$Class <- NULL
resultado <- cbind(dados_novos_casos, predict.rf)
View(resultado)