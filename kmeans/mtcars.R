### Leitura dos dados
data("mtcars")
dados=scale(mtcars)
View(dados)

### Executa o Kmeans
set.seed(202695)
km.res=kmeans(dados, 4, nstart=25)
print(km.res)

### Cria um arquivo com todos os registros e mais os clusters de cada um
resultado <- cbind(dados, km.res$cluster)
resultado