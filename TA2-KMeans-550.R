#K-Means 550 data

#impor dataset (1)
impor.dataset5 <- read.csv(file.choose(), header = TRUE)
View(impor.dataset5)

#menghapus nilai yang hilang pada data dan menghapus kolom berisi string (2)
ds5<-impor.dataset5
df5<-na.omit(ds5)
x5<-df5[-1]
View(x5)

#standarisasi data (3)
sd5<-scale(x5)
View(sd5)

#proses k-means dengan k=3 (4)
kmeans.proc5 <- kmeans(sd5, centers = 3)
kmeans.proc5
kmeans.proc5$iter
#-kmeans = fungsi
#-sd = data yang akan diproses dengan k-means
#-centers = jumlah cluster (k)

#menambahkan kolom cluster ke data asli
dd5<-cbind(impor.dataset5, cluster = kmeans.proc5$cluster)
View(dd5)

#plot/visualisasi (5)
library(factoextra)
library(ggplot2)
fviz_cluster(kmeans.proc5, data = sd5)

#validasi dengan DBI (Davies-Bouldin Index) (6)
library(NbClust)
DBIKMeans5<-NbClust(sd5, distance = "euclidean",
                    min.nc = 3, max.nc = 3,
                    index = "db", method = "complete")
DBIKMeans5$Best.nc #rekomendasi jumlah kluster terbaik dan nilai validasinya
DBIKMeans5$All.index #banyaknya jumlah kluster dan nilai validasinya masing-masing

#validasi dengan SI (Silhouette Index) (6)
library(NbClust)
SIKMeans5<-NbClust(sd5, distance = "euclidean",
                    min.nc = 3, max.nc = 3,
                    index = "silhouette", method = "complete")
SIKMeans5$Best.nc #rekomendasi jumlah kluster terbaik dan nilai validasinya
SIKMeans5$All.index #banyaknya jumlah kluster dan nilai validasinya masing-masing
