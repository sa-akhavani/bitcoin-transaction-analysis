library("igraph")

# Creating Graph
all_links <- read.csv("./lt_graph.txt", header=T, as.is=T, sep="\t")
links <- all_links
links$weight = 1

net <- graph_from_data_frame(d=links, directed=T)
full_net <- simplify(net, remove.multiple = T, remove.loops = T, edge.attr.comb="sum")

# Find wiki Egos and Subgraph wiki and its egos from full_net
wiki_ego <- make_ego_graph(full_net, order=2, nodes=V(full_net)$name[514], mode="in", mindist=0)
wiki_ego <- wiki_ego[[1]]
ego_vlist <- V(wiki_ego)$name
wiki_and_ego <- append(ego_vlist, "514")
net <- induced_subgraph(full_net, wiki_and_ego, impl="auto")


V(net)$degree <- degree(net, mode="all")
V(net)$indegree <- degree(net, mode="in")
V(net)$outdegree <- degree(net, mode="out")

# Labeling and Colorizing Wiki Node
vcol <- ifelse(V(net)$outdegree<=3,"gray50",ifelse(V(net)$outdegree<20,"pink", ifelse(V(net)$outdegree>=20,"tomato", "gray50")))
vcol[V(net)$name=="514"] <- "gold"
V(net)$label <- ifelse(V(net)$name=="514", "wikileaks", NA)

# Visualization
E(net)$arrow.mode <- 0
E(net)$width <- sqrt(E(net)$weight) / 50
E(net)$color <- "gray50"
V(net)$label.font <- 2
V(net)$label.color <- "black"
V(net)$label.cex <- 1
l <- layout_with_fr(net)

V(net)$size <- V(net)$indegree

# tkid <- tkplot(net, vertex.color=vcol, layout=layout_randomly)

# l <- tkplot.getcoords(tkid) # grab the coordinates from tkplot

# tk_close(tkid, window.close = T)

# plot(net, layout=l)


plot(net, vertex.color=vcol, layout=layout_randomly)