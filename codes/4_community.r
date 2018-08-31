library("igraph")

# Creating Graph
all_links <- read.csv("./au_graph.txt", header=T, as.is=T, sep="\t")
links <- all_links[sample(nrow(all_links), 500),]

net <- graph_from_data_frame(d=links, directed=F)
net <- simplify(net, remove.loops = T)

# Removing Vertices with degree==1
V(net)$degree = degree(net, mode="all")
net <- delete_vertices(net, V(net)[degree<1])


clusters <- cluster_edge_betweenness(net)

## Plot Community
E(net)$arrow.mode <- 0
E(net)$color <- "orange"
V(net)$size <- degree(net, mode="all")
E(net)$width <- 2
V(net)$label <- ifelse(V(net)$size<0,NA,V(net)$name)
V(net)$label.font <- 2
V(net)$label.color <-"black"
V(net)$label.cex <- 3

# l <- layout_with_fr(net)
l <- layout_randomly

png(filename="community_graph.png", width=4096, height=4096)
plot(clusters, net, layuot=l)
dev.off()