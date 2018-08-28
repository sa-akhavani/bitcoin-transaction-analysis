library("igraph")

# Creating Graph
links <- read.csv("./5000_simplified_dataframe.data", header=T, as.is=T, sep=",")
net <- graph_from_data_frame(d=links, directed=F)

# Plotting Graph
## Only Show Labels
plot(net, vertex.shape="none", vertex.label=V(net)$name, 
     vertex.label.font=2, vertex.label.color="gray40",
     vertex.label.cex=.7, edge.color="gray85")

## Colorize and Relative size
E(net)$arrow.mode <- 0
E(net)$arrow.size <- .2
E(net)$color <- "orange"

deg <- degree(net, mode="all")
V(net)$color <- "gray50"
V(net)$size <- degree(net, mode="all")
V(net)$label <- ifelse(V(net)$size<10,NA,V(net)$name)
V(net)$label.font <- 5
V(net)$label.color <- "white"
V(net)$label.cex <- 1

# FR
V(net)$size <- deg / 2
E(net)$width <- sqrt(E(net)$weight)
graph_attr(net, "layout") <- layout_with_fr(net)
# plot(net)
png(filename="sample5000_raw_layout_with_fr.png", width=1920, height=1080)
plot(net)
dev.off()


# Random
V(net)$size <- deg / 2
E(net)$width <- E(net)$weight / 50
plot(net, vertex.label=NA, layout=layout_randomly)

############

# Removing Vertices with degree==1
V(net)$degree = degree(net, mode="all")
mean(V(net)$degree)
cut.off <- mean(V(net)$degree) 
net.sp <- delete_vertices(net, V(net)[degree<1.5])

# Removing Edges with weight<cutoff
hist(E(net.sp)$weight)
mean(E(net.sp)$weight)
sd(E(net.sp)$weight)
cut.off <- mean(E(net.sp)$weight) 
net.sp <- delete_edges(net.sp, E(net.sp)[weight<cut.off])