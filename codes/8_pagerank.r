library("igraph")
library("ggplot2")
library("plyr")

links <- read.csv("./au_graph.txt", header=F, as.is=T, sep="\t")

net <- graph_from_data_frame(d=links, directed=T)

indegree <- degree(net, mode="in")
outdegree <- degree(net, mode="out")

ranks <- page_rank(net)
ranks <- ranks$vector
df <- data.frame(indegree, ranks)

cor <- cor(indegree, ranks)
cor

png(filename="page_rank_in_degree_correlation_distribution.png", width=2048, height=2048)
ggplot(df, aes(x = indegree, y = ranks)) +
  geom_point(size=10, colour="red", shape=20) +
  scale_x_continuous("In-Degree", trans="log10") +
  scale_y_continuous("Page Rank", trans="log10") +
  geom_smooth(method=lm, se=FALSE) + 
  ggtitle("Page Rank and In-Degree Correlation") +
  theme(text = element_text(size=50))
dev.off()