library("igraph")
library("ggplot2")

# Creating Graph
links <- read.csv("./au_graph.txt", header=F, as.is=T, sep="\t")
net <- graph_from_data_frame(d=links, directed=T)
net <- simplify(net, remove.loops = T)

dg <- degree(net, mode="all")
sorted <- sort(dg, decreasing = TRUE)
which(sorted == sorted["514"])
# Rank of 514: 4th

# 64     999 6624293     861 6761495     941 
# 460     387     267     216     210     203 



cl <- closeness(net, mode="all", weights=NA)
cl_sorted <- sort(cl, decreasing = TRUE)
which(cl_sorted == cl_sorted["514"])
# Rank of 514: 2nd
# 64          999          861      6624293        14954          299 
# 7.320644e-06 7.315985e-06 7.306577e-06 7.303375e-06 7.301135e-06 7.300016e-06


btw <- betweenness(net, directed=T, weights=NA)
btw_sorted <- sort(btw, decreasing = TRUE)
which(btw_sorted == btw_sorted["514"])
# Rank of 514: 311nd

# 64       999       941  13469820   6556075   6624293 
# 239315.05 181614.81 127557.19 110223.75 105019.92  90848.77

# edge_betweenness(net, directed=T, weights=NA)
# centr_betw(net, directed=T, normalized=T)$centralization