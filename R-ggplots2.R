install.packages("ggsci")
library(ggsci)
key<-ggplot(data=iris,aes(x=Sepal.Length,y=Petal.Length,color=Species))
key+geom_point()+geom_smooth(se=FALSE)+facet_wrap(~Species) # organises scatter plot with trendline of different species
key + geom_point() + geom_smooth(se=FALSE) + facet_wrap(~Species, scale='free_y')# every group can have its own y axis
key + geom_point() + geom_smooth(se=FALSE) + facet_wrap(~Species, scale='free_y') + scale_x_continuous(limits = c(1, 10)) # limits the scale of x xaxis from 1 to 10
key + geom_point() + geom_smooth(se=FALSE) + facet_wrap(~Species, scale='free_y') + scale_x_reverse() # to reverse x axis
key + geom_point() + geom_smooth(se=FALSE) + facet_wrap(~Species, scale='free_y') + scale_shape_manual(values=c(3, 16, 17)) +scale_size_manual(values=c(2,3,4)) + scale_color_manual(values=c('#669999','#a3c2c2', '#b30059')) # customising scales in greater detail with respect to size and color
key + geom_point() + geom_smooth(se=FALSE) + facet_wrap(~Species, scale='free_y') + scale_color_brewer(palette="RdYlBu") # for getting a color gradient


