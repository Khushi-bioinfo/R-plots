ggplot(data=iris,aes(x=Sepal.Length,y=Petal.Length))+geom_point() # Scatter plot
ggplot(data=iris,aes(x=Sepal.Length,y=Petal.Length,color=Species))+geom_point() # Scatter plot with color
ggplot(data=iris,aes(x=Sepal.Length,y=Petal.Length,color=Species))+geom_point()+geom_smooth()# Scatter plot with trendline
key <- ggplot(data = iris, aes(x = Sepal.Length, y = Petal.Length, color = Species))  # Scatter plot with different size,shape and red color
key + geom_point(size=4, shape=15, color="red3")  # Scatter plot with different size,shape and red color
ggplot(data = iris, aes(x = Sepal.Length, y = Petal.Length,color = Sepal.Length, size = Sepal.Length)) + geom_point()  # Scatter plot based on x axis
ggplot(data = iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) + geom_boxplot()  # Boxplot
ggplot(data=iris,aes(x=Sepal.Length)) + geom_bar()  # Bar Graph
ggplot(data=iris,aes(x=Sepal.Length, y = Petal.Length)) +geom_density_2d_filled()  # Density Gradient Graph
ggplot(data=iris, aes(x=Sepal.Length,fill=Species)) + geom_histogram()  # Colorful Histogram 
ggplot(data=iris,aes(x=Sepal.Length,fill=Species))+geom_histogram(binwidth = 0.05) # Colorful Histogram with different size
