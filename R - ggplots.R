ggplot(data=iris,aes(x=Sepal.Length,y=Petal.Length))+geom_point() # Scatter plot
ggplot(data=iris,aes(x=Sepal.Length,y=Petal.Length,color=Species))+geom_point() # Scatter plot with color
ggplot(data=iris,aes(x=Sepal.Length,y=Petal.Length,color=Species))+geom_point()+geom_smooth()# Scatter plot with trendline
key <- ggplot(data = iris, aes(x = Sepal.Length, y = Petal.Length, color = Species))
key + geom_point(size=4, shape=15, color="red3")
ggplot(data = iris, aes(x = Sepal.Length, y = Petal.Length,color = Sepal.Length, size = Sepal.Length)) + geom_point()
ggplot(data = iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) + geom_boxplot()
ggplot(data=iris,aes(x=Sepal.Length)) + geom_bar()
ggplot(data=iris,aes(x=Sepal.Length, y = Petal.Length)) +geom_density_2d_filled()
ggplot(data=iris, aes(x=Sepal.Length,fill=Species)) + geom_histogram()
ggplot(data=iris,aes(x=Sepal.Length,fill=Species))+geom_histogram(binwidth = 0.05)
