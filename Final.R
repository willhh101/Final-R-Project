install.packages(c("maps", "mapdata"))
install.packages(c("ggplot2", "devtools", "dplyr", "stringr"))
install.packages('ggmap')
install.packages('Rtools')
install.packages('officer')
install.packages('magrittr')
install.packages("RColorBrewer")
library(Rtools)
library(officer)
library(magrittr)
library(ggmap)
library(maps)
library(mapdata)
library(dplyr)
library(RColorBrewer)


read.csv("E:\\SJU MS Analytics\\DSS 665 - R Statistical Language\\Week 3\\evals.csv",header=TRUE)
attach(evals)
evals

evalsLocation <- read.csv("E:\\SJU MS Analytics\\DSS 665 - R Statistical Language\\Week 3\\evalsLocation.csv",header=TRUE)
attach(evalsLocation)
evalsLocation

evalsPlayer <- read.csv("E:\\SJU MS Analytics\\DSS 665 - R Statistical Language\\Week 3\\evalsPlayer.csv",header=TRUE)
attach(evalsPlayer)
evalsPLayer

evalsPosition <- read.csv("E:\\SJU MS Analytics\\DSS 665 - R Statistical Language\\Week 3\\evalsPosition.csv",header=TRUE)
attach(evalsPosition)
evalsPLayer

evalsTeam <- read.csv("E:\\SJU MS Analytics\\DSS 665 - R Statistical Language\\Week 3\\evalsTeam.csv",header=TRUE)
attach(evalsTeam)
evalsTeam

#Plot Map Verify
state <- map_data("state")

map("state", fill = TRUE, col = "grey", namesonly = TRUE)
title("NFL Franchises")

#Team Stadiums

map("state", fill = TRUE, col = "white", namesonly = TRUE)
title("NFL Franchises")

for(i in 1:32){
  points(longitude[i],latitude[i],pch=20)
}

#Highlight Playoff Teams

playoffmap = map("state", fill = FALSE, col = "GREY", namesonly = TRUE)
title("NFL Franchises")

for(i in 1:32){
  if(PlayOffs[i]==1)points(longitude[i],latitude[i],pch=20,cex=1.5,col="Gold")
  if(PlayOffs[i]==2)points(longitude[i],latitude[i],pch=20,cex=1.5,col="black")
}


#plot of average fantasy points per team

library(ggplot2)
ggplot(evalsTeam, aes(x = DKS.Team.Average, y = DKP.Team.Average)) +
  geom_point() +
  labs(x = "Teams Players Average Cost", y = "Teams Players Average Point Value",
       title = "Relationship between a teams players average cost and average performance") +
  geom_smooth(method = "lm", se = FALSE)

#bar chart

ggplot(evalsPosition, aes(x=Position, y=DKP.DKS.POS.Average)) + geom_bar(stat = "identity") +
  labs(x = "Position", y = "Points per Dollar Average",
       title = "Points per salry dollar spent per position in 2018")

#Create Word Presentation
install.packages("tidyverse")
install.packages("officer")
install.packages("rvg")
install.packages("gdtools")
library("tidyverse")
library("officer")
library("rvg")
library("gdtools")


read_docx()
my_doc <- read_docx()
styles_info(my_doc)

src <- tempfile(fileext = ".png")
png(filename = src, width = 5, height = 4, units = 'in', res = 300)
playoffmap = map("state", fill = FALSE, col = "GREY", namesonly = TRUE)
title("NFL Franchises")

for(i in 1:32){
  if(PlayOffs[i]==1)points(longitude[i],latitude[i],pch=20,cex=1.5,col="Gold")
  if(PlayOffs[i]==2)points(longitude[i],latitude[i],pch=20,cex=1.5,col="black")
}
dev.off()

my_doc <- my_doc %>% 
  body_add_img(src = src, width = 5, height = 3, style = "centered") %>% 
  body_add_par("William Howard", style = "Normal") %>%
  body_add_par("DSS 665 R Statistical Programming", style = "Normal") %>% 
  body_add_par("Marcus Ellis", style = "Normal") %>% 
  body_add_par("April 25, 2019", style = "Normal") %>% 
  body_add_par("", style = "Normal") %>% 
  body_add_par("Final Project", style = "centered") %>% 
  body_add_par("", style = "Normal") %>% 
  body_add_par("Introduction/Proposal", style = "Normal") %>% 
  body_add_par("", style = "Normal") %>% 
  body_add_par("     The National Football League is United States based professional sports league consisting of 32 teams.
  The teams are dividied into two conferences containg four divisions each. PLayoff teams are selected by
  taking the eight conference champions and two additional wild card teams. The wildcard teams are slected by taking 
  the taking the two remaing teams with the best record. Over the last decade fantasy football has also taken off in both
  popularity among fans and as a true marketable business segment. With organizations such as draft kings and fan duel to name a few.
  Leading the way in online sports betting, based on individual player fantasy points totals. What I set out to do was determine a few questions regarding
  the effects on geography and fantasy points have on a teams chances of being apart of the playoffs at the end of the year.") %>%    
  body_add_par("", style = "Normal") %>%                
  body_add_par("Data Sets", style = "Normal") %>%
  body_add_par("", style = "Normal") %>%    
  body_add_par("I was able to create a few different data sets for this project. The first was to google search the longitude and latitude
  values of each of the thirty two teams stadiums. I will use this to map each stadiums geographical location on map. The next data set is called evalsPlayers
  A data set that provides average draft king slaries and points for the 2018 season. The third data sets is the evalsPosition data set.
  This data set compares salary ankd point average for 2018 based on their associated position. My final data set is evalsTeam. This data
  set provides much of the same information of salaries and point averages for the 2018 at the team leve.", style = "Normal") %>% 
  body_add_par("", style = "Normal") %>% # blank paragraph




print(my_doc, target = "E:\\SJU MS Analytics\\DSS 665 - R Statistical Language\\final Project\\final SJU 665.docx")