library("igraph")
library("ggplot2")
library("plyr")

links <- read.csv("./au_graph.txt", header=F, as.is=T, sep="\t")

# Simplify Graph
net <- graph_from_data_frame(d=links, directed=F)
net <- simplify(net, remove.multiple = T, remove.loops = T, edge.attr.comb="sum")
net <- as.undirected(net, mode= "collapse", edge.attr.comb=list(weight="sum", "ignore"))


length(largest_cliques(net))
length(cq)

# Count maximal cliques
sizes <- c(3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
for (clique_size in sizes) {
  cq <- max_cliques(net, min=clique_size, max=clique_size)
  cat("[Maximal] clique size:", clique_size, "-", "Count:", length(cq), "\n")
}

### Output
# [Maximal] clique size: 3 - Count: 1022 
# [Maximal] clique size: 4 - Count: 698 
# [Maximal] clique size: 5 - Count: 455 
# [Maximal] clique size: 6 - Count: 336 
# [Maximal] clique size: 7 - Count: 318 
# [Maximal] clique size: 8 - Count: 208 
# [Maximal] clique size: 9 - Count: 132 
# [Maximal] clique size: 10 - Count: 73 
# [Maximal] clique size: 11 - Count: 36 
# [Maximal] clique size: 12 - Count: 7

x <- c(3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
y <- c(1022, 698, 455, 336, 318, 208, 132, 73, 36, 7)
df <- data.frame(x, y)

png(filename="maximal_clique_distribution.png", width=2048, height=2048)
ggplot(df, aes(x = x, y = y)) +
  geom_point(size=10, colour="red", shape=20) +
  scale_x_continuous("Clique Size", breaks=x) +
  scale_y_continuous("Frequency", breaks=y) +
  ggtitle("Maximal Cliques Distribution") +
  theme(text = element_text(size=40))
dev.off()