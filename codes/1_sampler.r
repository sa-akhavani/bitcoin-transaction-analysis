library("igraph")

links <- read.csv("./au_graph.txt", header=F, as.is=T, sep="\t")
links$weight = 1
links <- links[sample(nrow(links), 5000),]

net <- graph_from_data_frame(d=links, directed=F)
net <- simplify(net, remove.multiple = T, remove.loops = T, edge.attr.comb="sum")

simplified_data_frame <- as_data_frame(net, what="edges")
write.csv(simplified_data_frame, file="simplified_df", row.names=F)