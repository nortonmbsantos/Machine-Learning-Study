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
### Treinar Random Forest com a base de Treino
set.seed(202695)
rf <- train(y~., data=treino, method="rf")
rf

### Aplicar modelos treinados na base de Teste
predict.rf <- predict(rf, teste)
confusionMatrix(predict.rf, as.factor(teste$y)) 

#### Cross-validation
ctrl <- trainControl(method = "cv", number = 10)
set.seed(202695)
rf <- train(y~., data=treino, method="rf", trControl=ctrl)
rf

### Matriz de confusão
predict.rf <- predict(rf, teste)
confusionMatrix(predict.rf, as.factor(teste$y))

#### Vários mtry
tuneGrid = expand.grid(mtry=c(2, 5, 7, 9))
set.seed(202695)
rf <- train(y~., data=treino, method="rf", trControl=ctrl, tuneGrid=tuneGrid)
rf

### Matriz de confusão 
predict.rf <- predict(rf, teste)
confusionMatrix(predict.rf, as.factor(teste$y))

### PREDIÇÕES DE NOVOS CASOS ◉ CLASSIFICAÇÃO - Banco
dados_novos_casos <- read.csv("4 – Banco -  Novos Casos.csv")
View(dados_novos_casos)
predict.rf <- predict(rf, dados_novos_casos)
dados_novos_casos$y <- NULL
resultado <- cbind(dados_novos_casos, predict.rf)
View(resultado)