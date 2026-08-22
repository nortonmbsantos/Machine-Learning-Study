### Instalação dos pacotes necessários
install.packages("klaR")
library(klaR)
### Leitura dos dados
setwd("C:/Users/norto/Documents/Machine Learning Study/databases")
dados <- read.csv("5 – Banco - Dados.csv")
View(dados)

### Instalação dos pacotes necessários
set.seed(202695)
cluster.results <- kmodes(dados, 5, iter.max = 10, weighted = FALSE ) 
cluster.results

### Cria um arquivo com todos os registros e mais os clusters de cada um
resultado <- cbind(dados, cluster.results$cluster)
resultado