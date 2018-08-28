library("igraph")

# Creating Graph
links <- read.csv("./5000_simplified_dataframe.data", header=T, as.is=T, sep=",")
net <- graph_from_data_frame(d=links, directed=T)
E(net)$arrow.mode <- 0
E(net)$arrow.size <- .2
E(net)$color <- "gray50"

deg <- degree(net, mode="all")
V(net)$color <- "pink"
V(net)$degree <- degree(net, mode="all")
V(net)$label <- ifelse(V(net)$degree<5,NA,V(net)$name)
V(net)$label.font <- 2
V(net)$label.color <- "red"
V(net)$label.cex <- 0.5
l <- layout_with_fr(net)

# Hubs are nodes with more outgoing
hs <- hub_score(net, weights=NA)$vector
# Authorities are nodes with more incomming
as <- authority_score(net, weights=NA)$vector

png(filename="sample5000_hubs_authorities_layout_with_fr.png", width=1920, height=1080)
par(mfrow=c(1,2))
plot(net, vertex.size=hs*50, layout=l, main="Hubs") # Outgoing
plot(net, vertex.size=as*30, layout=l, main="Authorities") # Incomming
dev.off()