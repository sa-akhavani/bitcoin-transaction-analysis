library("igraph")
library("ggplot2")
library("plyr")

links <- read.csv("./au_graph.txt", header=F, as.is=T, sep="\t")

net <- graph_from_data_frame(d=links, directed=T)

indegree <- degree(net, mode="in")
outdegree <- degree(net, mode="out")

indegree.histogram <- count(indegree)
outdegree.histogram <- count(outdegree)

# Indegree
ggplot(indegree.histogram, aes(x = x, y = freq)) +
  geom_point(size=1, colour="red", shape="square") +
  scale_x_continuous("Indegree", trans = "log10") +
  scale_y_continuous("No. Of Nodes", trans = "log10") +
  ggtitle("InDegree Distribution")

# outdegree
ggplot(outdegree.histogram, aes(x = x, y = freq)) +
  geom_point(size=1, colour="red", shape="square") +
  scale_x_continuous("Outdegree", trans = "log10") +
  scale_y_continuous("No. Of Nodes", trans = "log10") +
  ggtitle("Outdegree Distribution")


# Correlation
cor <- cor(indegree, outdegree)
cor

corr.df <- data.frame(indegree, outdegree)
ggplot(corr.df, aes(x = indegree, y = outdegree)) +
  geom_point(size=2, colour="red", shape=19) +
  scale_x_continuous("InDegree", trans = "log10") +
  scale_y_continuous("OutDegree", trans = "log10") +
  geom_smooth(method=lm, se=FALSE)