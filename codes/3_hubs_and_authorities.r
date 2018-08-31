library("igraph")

# Creating Graph
all_links <- read.csv("./au_graph.txt", header=T, as.is=T, sep="\t")
links <- all_links[sample(nrow(all_links), 7000),]
links$weight = 1

net <- graph_from_data_frame(d=links, directed=T)
net <- simplify(net, remove.multiple = T, remove.loops = T, edge.attr.comb="sum")


V(net)$indegree <- degree(net, mode="in")
V(net)$outdegree <- degree(net, mode="out")

# Hubs are nodes with more outgoing
hs <- hub_score(net)$vector
# Authorities are nodes with more incomming
as <- authority_score(net)$vector

# Visualization
E(net)$arrow.mode <- 0
E(net)$width <- sqrt(E(net)$weight)
E(net)$color <- "gray50"
l <- layout_with_fr(net)
V(net)$label.font <- 2
V(net)$label.color <- "black"
V(net)$label.cex <- 1


png(filename="sample5000_hubs_authorities_layout_with_fr.png", width=3840, height=2160)
par(mfrow=c(1,2))
V(net)$color <- ifelse(V(net)$indegree<=3,"gray50",ifelse(V(net)$indegree<20,"yellow", ifelse(V(net)$indegree>=20,"red", "gray50")))
V(net)$size <- sqrt(V(net)$outdegree) * 3
V(net)$label <- ifelse(V(net)$outdegree< 5 ,NA,V(net)$name)
plot(net, layout=l, main="Hubs") # Outgoing

V(net)$color <- ifelse(V(net)$outdegree<=3,"gray50",ifelse(V(net)$outdegree<20,"yellow", ifelse(V(net)$outdegree>=20,"red", "gray50")))
V(net)$size <- sqrt(V(net)$indegree) * 3
V(net)$label <- ifelse(V(net)$indegree< 5 ,NA,V(net)$name)
plot(net, layout=l, main="Authorities") # Incomming
dev.off()
