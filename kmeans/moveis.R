### Instalação dos pacotes necessários
install.packages("klaR")
library(klaR)
### Leitura dos dados
setwd("C:/Users/norto/Documents/Machine Learning Study/databases")
dados <- read.csv("2 - Moveis - Dados.csv")
View(dados) #multidata pode não deixar visualizar

### Instalação dos pacotes necessários
set.seed(202695)
cluster.results <- kmodes(dados, 10, iter.max = 10, weighted = FALSE ) 
cluster.results

### Cria um arquivo com todos os registros e mais os clusters de cada um
resultado <- cbind(dados, cluster.results$cluster)
resultado