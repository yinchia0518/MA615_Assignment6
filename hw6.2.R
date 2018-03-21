#References: 
# https://www.cornwall-beaches.co.uk/north-cornwall/bude-town
# https://www.gps-coordinates.net/
# http://budecc.play-cricket.com/

library(ggmap)
library(tidyverse)


#Bude
gc_Bude <- geocode("Bude, England, UK")
data_Bude <- as.data.frame(gc_Bude)
map_Bude_road <- get_map(data_Bude, maptype = "roadmap", zoom=13)
map_Bude_water <- get_map(data_Bude, maptype = "watercolor",zoom=13)

#Bude_Road Map
Bude_RoadMap <- ggmap(map_Bude_road) +
  geom_point(
    aes(x = lon, y = lat),
    data = data_Bude, color = "red", size = 3
  )

#Bude_Water Map
Bude_WaterMap <- ggmap(map_Bude_water) +
  geom_point(
    aes(x = lon, y = lat),
    data = data_Bude, color = "red", size = 3
  )


#Cricket ground: Bude North Cornwall Cricket Club
gc_NorthCornwall <- geocode("Bude North Cornwall Cricket Club")
data_cricket <- as.data.frame(gc_NorthCornwall)
map_NorthCornwall <- get_map(data_cricket)

Cricket_RoadMap <- ggmap(map_NorthCornwall) +
  geom_point(
    aes(x = lon, y = lat),
    data = data_cricket, color = "yellow", size = 3
  )

#Route from Cricket ground to nearby pub 
#Nearby Pub : Bar 35, Belle Vue Ln, Bude EX23 8BR, UK
gc_Bar35 <- geocode("Bar 35, Belle Vue Ln, Bude EX23 8BR, UK")
data_pub <- as.data.frame(gc_Bar35)

from <- "Bar 35, Belle Vue Ln, Bude EX23 8BR, UK"
to <- "Bude North Cornwall Cricket Club"
route_df <- route(from, to, structure = "route")

route_data <- data.frame(x = route_df$lon, y= route_df$lat)

map_Bude_road <- get_map(data_Bude, maptype = "roadmap", zoom=16)

Route_CricketBar <- ggmap(map_Bude_road) +  
    geom_path(
    aes(x = lon, y = lat), colour = "red", size = 1.5,
    data = route_df, lineend = "round"
  )

#Beach1: Sandy Mouth Beach
gc_SandyMouth <- geocode("Kilkhampton, Bude EX23 9EG, UK")
data_beach1 <- as.data.frame(gc_SandyMouth)
map_SandyMouth <- get_map(data_beach1, zoom=16)

SandyMouth_RoadMap <- ggmap(map_SandyMouth) +
  geom_point(
    aes(x = lon, y = lat),
    data = data_beach1, color = "green", size = 4
  )

#Beach2:Summerleaze Beach

gc_Summerleaze <- geocode("Summerleaze Cres, Bude EX23 8HN, UK")
data_beach2 <- as.data.frame(gc_Summerleaze)
map_Summerleaze <- get_map(data_beach2)

Summerleaze_RoadMap <- ggmap(map_Summerleaze) +
  geom_point(
    aes(x = lon, y = lat),
    data = data_beach2, color = "green", size = 3
  )


#create a data frame containing all locations
lon_all <- as.numeric(c(data_Bude[1], data_cricket[1], data_beach1[1],data_beach2[1],data_pub[1]))
lat_all <- as.numeric(c(data_Bude[2], data_cricket[2],data_beach1[2],data_beach2[2], data_pub[2]))
allData <- data.frame(lon=lon_all, lat=lat_all)


all_spots_Roadmap <- ggmap(map_Bude_road) +
  geom_point(aes(x = lon, y = lat), data = data_Bude, color = "Brown", size = 3)+
  geom_point(aes(x = lon, y = lat), data = data_cricket, color = "Red", size = 3)+
  geom_point(aes(x = lon, y = lat), data = data_beach1, color = "yellow" , size = 3)+
  geom_point(aes(x = lon, y = lat), data = data_beach2,color = "Green" , size = 3)+
  geom_point(aes(x = lon, y = lat), data = data_pub, color = "Blue" , size = 3)+
  geom_text(aes(x = lon, y = lat, label="Bude"), data = data_Bude, vjust=1, hjust=1,size=3)+
  geom_text(aes(x = lon, y = lat, label="Cricket Club"), data_cricket, vjust=1, hjust=1,size=3)+
  geom_text(aes(x = lon, y = lat, label="Sandy Mouth Beach"), data = data_beach1, vjust=1, hjust=1,size=3)+
  geom_text(aes(x = lon, y = lat, label="Summerleaze Beach"), data = data_beach2, vjust=1, hjust=1,size=3)+
  geom_text(aes(x = lon, y = lat, label="Bar 35"), data = data_pub, vjust=0, hjust=0,size=3)+
  geom_path(aes(x = lon, y = lat), colour = "red", size = 1,data = route_df, lineend = "round")

 
all_spots_Watermap <- ggmap(map_Bude_water) +
  geom_point(aes(x = lon, y = lat), data = data_Bude, color = "Brown", size = 3)+
  geom_point(aes(x = lon, y = lat), data = data_cricket, color = "Red", size = 3)+
  geom_point(aes(x = lon, y = lat), data = data_beach1, color = "yellow" , size = 3)+
  geom_point(aes(x = lon, y = lat), data = data_beach2,color = "Green" , size = 3)+
  geom_point(aes(x = lon, y = lat), data = data_pub, color = "Blue" , size = 3)+
  geom_text(aes(x = lon, y = lat, label="Bude"), data = data_Bude, vjust=1, hjust=1,size=3)+
  geom_text(aes(x = lon, y = lat, label="Cricket Club"), data_cricket, vjust=1, hjust=1,size=3)+
  geom_text(aes(x = lon, y = lat, label="Sandy Mouth Beach"), data = data_beach1, vjust=1, hjust=1,size=3)+
  geom_text(aes(x = lon, y = lat, label="Summerleaze Beach"), data = data_beach2, vjust=1, hjust=1,size=3)+
  geom_text(aes(x = lon, y = lat, label="Bar 35"), data = data_pub, vjust=0, hjust=0,size=3)+
  geom_path(aes(x = lon, y = lat), colour = "red", size = 1,data = route_df, lineend = "round")



