### Leitura dos dados
data(iris)
dados <- iris
View(dados)

### Gráfico com os dados
library(ggplot2)
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()

### Executa o Kmeans
set.seed(202695)
irisCluster <- kmeans(iris[, 3:4], 3)
irisCluster
table(irisCluster$cluster, iris$Species)

### Cria um arquivo com todos os registros e mais os clusters de cada um
resultado <- cbind(dados, irisCluster$cluster)
resultado