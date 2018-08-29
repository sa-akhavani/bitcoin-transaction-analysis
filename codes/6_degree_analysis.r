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
png(filename="in_degree_distribution.png", width=2048, height=2048)
ggplot(indegree.histogram, aes(x = x, y = freq)) +
  geom_point(size=2.5, colour="red", shape=20) +
  scale_x_continuous("In-Degree", trans = "log10") +
  scale_y_continuous("No. Of Nodes", trans = "log10") +
  ggtitle("In-Degree Distribution") +
  theme(text = element_text(size=40))
dev.off()

# outdegree
png(filename="out_degree_distribution.png", width=2048, height=2048)
ggplot(outdegree.histogram, aes(x = x, y = freq)) +
  geom_point(size=2.5, colour="red", shape=20) +
  scale_x_continuous("Out-Degree", trans = "log10") +
  scale_y_continuous("No. Of Nodes", trans = "log10") +
  ggtitle("Out-Degree Distribution") +
  theme(text = element_text(size=40))
dev.off()

# Correlation
cor <- cor(indegree, outdegree)
cor

png(filename="in_out_degree_correlation_distribution.png", width=2048, height=2048)
corr.df <- data.frame(indegree, outdegree)
ggplot(corr.df, aes(x = indegree, y = outdegree)) +
  geom_point(size=2, colour="red", shape=19) +
  scale_x_continuous("InDegree", trans = "log10") +
  scale_y_continuous("OutDegree", trans = "log10") +
  geom_smooth(method=lm, se=FALSE) + 
  ggtitle("In-Degree/Out-Degree Correlation") +
  theme(text = element_text(size=40))
dev.off()
