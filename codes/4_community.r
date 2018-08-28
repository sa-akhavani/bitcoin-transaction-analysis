library("igraph")

# Creating Graph
links <- read.csv("./5000_simplified_dataframe.data", header=T, as.is=T, sep=",")
links <- links[sample(nrow(links), 150),]
net <- graph_from_data_frame(d=links, directed=F)

# clusters <- cluster_fast_greedy(net)
clusters <- cluster_label_prop(net)

## Plot Community
E(net)$arrow.mode <- 0
E(net)$color <- "orange"
V(net)$size <- degree(net, mode="all")
E(net)$width <- sqrt(E(net)$weight)
V(net)$label <- ifelse(V(net)$size<0,NA,V(net)$name)
V(net)$label.font <- 2
V(net)$label.color <-"black"
V(net)$label.cex <- 0.5

# graph_attr(net, "layout") <- layout_with_fr(net)
l <- layout_with_fr(net)
# l <- layout_randomly

plot(clusters, net, layuot=l)

# Another Coloring
# V(net)$community <- clusters$membership
# colrs <- adjustcolor( c("gray50", "tomato", "gold", "yellowgreen"), alpha=.6)
# plot(net, vertex.color=colrs[V(net)$community])