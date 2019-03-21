#install.packages("cluster")
#install.packages("mclust")
#install.packages("NbClust")
#install.packages("mvtnorm")

library(mclust)
library(cluster)
library(NbClust)
library(mvtnorm)

#data �б�
iris.data=read.csv("C:/Users/chs76/Desktop/kubig/iris.csv",header=T)
#�־��� �����Ϳ��� ���ڷ� ǥ�õ� �κ� scailing. clustering�� ������ �߿��ϴ�.
iris1=scale(iris.data[,-5]) 


#�������� ����: ��� 1
NbClust(iris1, min.nc = 2, max.nc = 15, method = "kmeans")
#���� �����, Conclusion���� ������ ������õ

#�������� ����: ��� 2
wssplot <- function(data, n = 15, seed = 1234) {
  wss <- (nrow(data) - 1) * sum(apply(data, 2, var))
  for (i in 2:n) {
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:n, wss, type="b", xlab = "Number of Clusters",
       ylab = "Within groups sum of squares")}

wssplot(iris1)
#����3���� ū ���̾��� ���� -> ���� 3���� ����

#heirarchical clustering
par(mfrow = c(1,1))
plot(hclust(dist(iris1,"euclidean"),method="complete"))


#kmeans clustering
iris.kmeans = kmeans(iris1, centers = 3, iter.max = 10000)
iris.kmeans$centers
iris.data$cluster = as.factor(iris.kmeans$cluster)

qplot(petal.width, petal.length, colour = cluster, data = iris.data)
table(iris.data$variety, iris.data$cluster)


#pca �̿��� clustering
pc = princomp(iris1)
plot(pc)
summary(pc) 
#cumulative proportion�� ���� comp1,2 �� 95�ۼ�Ʈ�� �������� ���°��� �� �� ����

pc2=prcomp(iris1)
comp=data.frame(pc2$x[,1:4])
k = kmeans(comp, 3, nstart=25, iter.max=10000)
library(RColorBrewer)
library(scales)
palette(alpha(brewer.pal(9,'Set1'), 0.5))
plot(comp[,1:2], col=k$clust, pch=16)

table(iris.data$variety,k$cluster) #ū ���̰� ����..


