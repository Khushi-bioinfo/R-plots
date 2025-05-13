getwd()
movie<-read.csv("Movie ratings.csv")
head(movie)
colnames(movie)
str(movie)
summary(movie)
factor(movie$Year)
movie$Year<-factor(movie$Year)
str(movie)
#---------------Aesthetics
library(ggplot2)
ggplot(data=movie,aes(x=Rotten.Tomatoes.Ratings..,y=Audience.Ratings..))+
  geom_point()

colnames(movie)
        
# add colour------------------
ggplot(data=movie,aes(x=Rotten.Tomatoes.Ratings..,y=Audience.Ratings..,colour=Genre))+
  geom_point()
# size------------------------
ggplot(data=movie,aes(x=Rotten.Tomatoes.Ratings..,y=Audience.Ratings..,colour=Genre,size=Budget..million...))+
  geom_point()
# Override aesthetics
q <-ggplot(data=movie,aes(x=Rotten.Tomatoes.Ratings..,y=Audience.Ratings..,colour=Genre,size=Budget..million...))
q+geom_point(aes(size=Rotten.Tomatoes.Ratings..))# save this for image 1
# reduce ine size
q+geom_line(size=1)
#override aesthetics colour
r<-ggplot(data=movie,aes(x=Rotten.Tomatoes.Ratings..,y=Audience.Ratings..))
  r+ geom_point()
r+geom_point(aes(colour=Genre))
r+geom_point(colour="Dark Green")

# Histograms and density Charts,no Y axis required for Histogram, control size using binwidth
s<-ggplot(data=movie,aes(x=Budget..million...))
s+geom_histogram()
s+geom_histogram(binwidth=10)

#add color to histogram <- will improve this chart for later
s<-ggplot(data=movie,aes(x=Budget..million...,))
s+geom_histogram(binwidth=10,aes(fill=Genre))
s+geom_histogram(binwidth=10,aes(fill=Genre),colour="Black")#adds border to histogram

#create density chart
s+geom_density(aes(fill=Genre))# they overlap so you have to add stack
s+geom_density(aes(fill=Genre),position = "stack")

#starting layer tips
t<-ggplot(data=movie,aes(x=Rotten.Tomatoes.Ratings..))
t+geom_histogram(binwidth=10,fill="White",colour="Blue")

#to smoothen the plot
u<-ggplot(data = movie,aes(x=Rotten.Tomatoes.Ratings..,y=Audience.Ratings..,colour=Genre))
u+geom_point() +geom_smooth(fill=NA)

#boxplots
v<-ggplot(data = movie,aes(x=Genre,y=Audience.Ratings..,colour=Genre))
v+geom_boxplot(size=1.2) #increases border size
v+geom_boxplot(size=1.2) + geom_point()
#tip- to make it look better geom_jitter
v+geom_boxplot(size=1.2) + geom_jitter()
# to change the layering you change the order of layering
u+geom_point()+geom_boxplot(size=1.2) #looks shabby
u+geom_jitter()+geom_boxplot(size=1.2,alpha=0.5) #aplha adds transparency

#another boxplot for Criric Rating
z<-ggplot(data=movie,aes(x=Genre,y=Rotten.Tomatoes.Ratings..,colour=Genre))
z+geom_jitter()+geom_boxplot(size=1.2)

#using facets
w<-ggplot(data=movie,aes(x=Budget..million...))
w+geom_histogram(binwidth=10,aes(fill=Genre),colour="Black")

#facets
w<-ggplot(data=movie,aes(x=Budget..million...))
w+geom_histogram(binwidth=10,aes(fill=Genre),colour="Black")+
  facet_grid(Genre~.,scales="free") #inside the bracket you can specify the row or the column you want
#to make scales uniform, use scales function

#using facets in scatterplots
x<-ggplot(data=movie,aes(x=Rotten.Tomatoes.Ratings..,y=Audience.Ratings..,colour=Genre))
x+geom_point(size=3)
x+geom_point(size=3)+facet_grid(Genre~Year)

x<-ggplot(data=movie,aes(x=Rotten.Tomatoes.Ratings..,y=Audience.Ratings..,colour=Genre)) +
  geom_point(size=3) +
  facet_grid(Genre~Year)


