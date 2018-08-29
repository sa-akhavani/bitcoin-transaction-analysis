# Libraries
library("igraph")
library("threejs")
library("htmlwidgets")


# Creating Graph
links <- read.csv("./5000_simplified_dataframe.data", header=T, as.is=T, sep=",")
net <- graph_from_data_frame(d=links, directed=F)

## Colorize and relative size
E(net)$arrow.mode <- 0
E(net)$arrow.size <- .2
E(net)$color <- "orange"
V(net)$color <- "gray50"

V(net)$degree <- degree(net, mode="all")
V(net)$size <- V(net)$degree
E(net)$width <- 1.5

V(net)$label <- V(net)$name
V(net)$color <- ifelse(V(net)$degree<10,"gray50",ifelse(V(net)$degree<20,"yellow", ifelse(V(net)$degree>=20,"red", "gray50")))

# l <- layout_with_fr(net)
# plot(net, vertex.label=NA, layout=l)

graph_attr(net, "layout") <- NULL
gjs <- graphjs(net, main="Bitcoin Transaction Network", bg="gray10", showLabels=T, stroke=FALSE,
  curvature=0.1, attraction=0.9, repulsion=0.8, opacity=0.9)
print(gjs)
saveWidget(gjs, file="Media-Network-gjs.html")
browseURL("Media-Network-gjs.html")

# Animated
gjs <- graphjs(net, main="Bitcoin Transaction Network", bg="gray10", showLabels=T, stroke=FALSE,
  curvature=0.1, attraction=0.9, repulsion=0.8, opacity=0.9,
  layout=list(layout_randomly(net, dim=3),
    layout_on_sphere(net),
    layout_with_fr(net, dim=3),
    layout_with_drl(net, dim=3)))
print(gjs)
saveWidget(gjs, file="Media-Network-gjs-animated.html")
browseURL("Media-Network-gjs-animated.html")