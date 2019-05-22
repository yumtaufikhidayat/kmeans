#K-Means 550 data

#impor dataset (1)
impor.dataset <- read.csv(file.choose(), header = TRUE)
View(impor.dataset)

#menghapus nilai yang hilang pada data dan menghapus kolom berisi string (2)
ds<-impor.dataset
df<-na.omit(ds)
x<-df[-1]
View(x)

#standarisasi data (3)
sd<-scale(x)
View(sd)

#proses k-means dengan k=3 (4)
kmeans.proc <- kmeans(sd, centers = 3)
kmeans.proc
kmeans.proc$iter
#-kmeans = fungsi
#-sd = data yang akan diproses dengan k-means
#-centers = jumlah cluster (k)

#menambahkan kolom cluster ke data asli
dd<-cbind(impor.dataset, cluster = kmeans.proc$cluster)
View(dd)

#plot/visualisasi (5)
library(factoextra)
library(ggplot2)
fviz_cluster(kmeans.proc, data = sd)

#validasi dengan DBI (Davies-Bouldin Index) (6)
library(NbClust)
DBIKMeans<-NbClust(sd, distance = "euclidean",
                    min.nc = 2, max.nc = 5,
                    index = "db", method = "complete")
DBIKMeans$Best.nc #rekomendasi jumlah kluster terbaik dan nilai validasinya
DBIKMeans$All.index #banyaknya jumlah kluster dan nilai validasinya masing-masing

#validasi dengan SI (Silhouette Index) (6)
library(NbClust)
SIKMeans<-NbClust(sd, distance = "euclidean",
                    min.nc = 2, max.nc = 5,
                    index = "silhouette", method = "complete")
SIKMeans$Best.nc #rekomendasi jumlah kluster terbaik dan nilai validasinya
SIKMeans$All.index #banyaknya jumlah kluster dan nilai validasinya masing-masing
