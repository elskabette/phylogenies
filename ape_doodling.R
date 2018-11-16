install.packages("ape")
install.packages("phytools")
library(ape)
library(phytools)
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ggtree", version = "3.8")
library(ggtree)
library(ggplot2)

tree <- read.nexus("non-Euteleostei families")

##Labeling nodes using ape
plot(tree)
#to show numbers at each node:
nodelabels() 
nodelabels(text="Holostei", node=20, adj = c(1.0, 1.0), frame = "rect", col = "black", bg = "lightblue") 


##Labeling clades using phytools (see http://blog.phytools.org/2014/03/new-function-cladelabels.html)
plotTree(tree, xlim=c(0,2))    #adjust xlim to make space for labels
nodelabels()
cladelabels(tree,node=20,"Holostei")    #I keep getting an error. not sure why. "Error in res[edge[i, 2]] <- res[edge[i, 1]] + el[i] : replacement has length zero"


##Labeling clades using ggtree (see https://guangchuangyu.github.io/presentation/2016-ggtree-chinar/)
#to show numbers at each node:
ggtree(tree) + geom_text2(aes(subset=!isTip, label=node), hjust=-.3) + geom_tiplab(size=3) + xlim(NA, 15) 
tree <- groupClade(tree, .node=c(17,19,21))

p <- ggtree(tree, aes(color=group))
p + xlim(NA, 23) + geom_tiplab(size=3, color="black") +
  scale_color_manual(values=c("black", "cyan3", "mediumslateblue", "chartreuse4")) + 
  geom_cladelabel(node=20, label="Holostei", angle=90, hjust='center', fontsize = 2.5,
                  offset=4.5, offset.text=.2, barsiz=1.5) + 
  geom_cladelabel(22, "Elopomorpha", angle=90, hjust='center', fontsize = 2.5,
                  offset=5, offset.text=.2, barsiz=1.5) + 
  geom_cladelabel(17, "Actinopterygii", angle=90, hjust='center', fontsize = 2.5,
                  offset=10, offset.text=.2, barsiz=1.5, color="cyan3") + 
  geom_cladelabel(19, "Neopterygii", angle=90, hjust='center', fontsize = 2.5,
                  offset=9, offset.text=.2, barsiz=1.5, color="mediumslateblue") + 
  geom_cladelabel(21, "Teleostei", angle=90, hjust='center', fontsize = 2.5,
                  offset=8, offset.text=.2, barsiz=1.5, color="chartreuse4") + 
  geom_cladelabel(23, "Osteoglossocephala", angle=90, hjust='center', fontsize = 2.5,
                  offset=7, offset.text=.2, barsiz=1.5) + 
  geom_cladelabel(24, "Clupeocephala", angle=90, hjust='center', fontsize = 2.5,
                  offset=6, offset.text=.2, barsiz=1.5) + 
  geom_cladelabel(27, "Otophysa", angle=90, hjust='center', fontsize = 2.5,
                  offset=5, offset.text=.2, barsiz=1.5)
#I know that ggtree allows you to rotate and flip nodes, and I want to flip node 24 so euteleosti is at the top of the tree, but it's not working when I try
