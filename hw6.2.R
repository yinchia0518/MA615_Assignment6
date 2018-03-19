#References: 
# https://www.cornwall-beaches.co.uk/north-cornwall/bude-town
# https://www.gps-coordinates.net/
# http://budecc.play-cricket.com/

library(ggmap)
library(tidyverse)


#Bude
gc_Bude <- geocode("Bude, England, UK")
map_Bude_road <- get_map(gc_Bude, maptype = "roadmap", zoom=15)
map_Bude_water <- get_map(gc_Bude, maptype = "watercolor",zoom=15)

bb_Bude <- attr(map_Bude, "bb")
bbox_Bude <- bb2bbox(bb_Bude)

data_Bude <- gc_Bude

#Bude_Road Map
ggmap(map_Bude_road) +
  geom_point(
    aes(x = lon, y = lat),
    data = gc_Bude, color = "red", size = 3
  )

#Bude_Water Map
ggmap(map_Bude_water) +
  geom_point(
    aes(x = lon, y = lat),
    data = gc_Bude, color = "red", size = 3
  )


#Cricket ground: Bude North Cornwall Cricket Club
gc_NorthCornwall <- geocode("Bude North Cornwall Cricket Club")
map_NorthCornwall <- get_map(gc_NorthCornwall)

bb_NorthCornwall <- attr(map_NorthCornwall, "bb")
bbox_NorthCornwall <- bb2bbox(bb_NorthCornwall)

ggmap(map_NorthCornwall) +
  geom_point(
    aes(x = lon, y = lat),
    data = gc_NorthCornwall, color = "yellow", size = 3
  )

data_cricket <- gc_NorthCornwall

#Route from Cricket ground to nearby pub 
#Nearby Pub : Bar 35, Belle Vue Ln, Bude EX23 8BR, UK
from <- "Bar 35, Belle Vue Ln, Bude EX23 8BR, UK"
to <- "Bude North Cornwall Cricket Club"
route_df <- route(from, to, structure = "route")

map_Bude_road <- get_map(gc_Bude, maptype = "roadmap", zoom=16)
ggmap(map_Bude_road) +  
  geom_path(
    aes(x = lon, y = lat), colour = "red", size = 1.5,
    data = route_df, lineend = "round"
  )

gc_Bar35 <- geocode("16 Erdiston Ct, Bude EX23, UK")
data_pub <- gc_Bar35

#Beach1: Sandy Mouth Beach
gc_SandyMouth <- geocode("S W Coast Path, Bude EX23, UK")
map_SandyMouth <- get_map(gc_SandyMouth, zoom=16)

bb_SandyMouth <- attr(map_SandyMouth, "bb")
bbox_SandyMouth <- bb2bbox(bb_SandyMouth)

ggmap(map_SandyMouth) +
  geom_point(
    aes(x = lon, y = lat),
    data = gc_SandyMouth, color = "green", size = 4
  )

data_beach1<-gc_SandyMouth

#Beach2:Summerleaze Beach

gc_Summerleaze <- geocode("Summerleaze Cres, Bude EX23 8HN, UK")
map_Summerleaze <- get_map(gc_Summerleaze)

bb_Summerleaze <- attr(map_Summerleaze, "bb")
bbox_Summerleaze <- bb2bbox(bb_Summerleaze)

ggmap(map_Summerleaze) +
  geom_point(
    aes(x = lon, y = lat),
    data = gc_Summerleaze, color = "green", size = 3
  )

data_beach2 <- gc_Summerleaze


#create a data frame containing all locations
lon_all <- as.numeric(c( data_cricket[1], data_beach1[1],data_beach2[1],data_pub[1]))
lat_all <- as.numeric(c( data_cricket[2],data_beach1[2],data_beach2[2], data_pub[2]))
allData <- data.frame(lon=lon_all, lat=lat_all)

# 
# gc_England <- geocode("England, UK")
# map_England <- get_map(gc_Bude, maptype = "roadmap", zoom=15)

ggmap(map_Bude_road) +
  geom_point(aes(x = lon, y = lat), data = data_cricket, color = "Red", size = 3)+
  geom_point(aes(x = lon, y = lat), data = data_beach1, color = "yellow" , size = 3)+
  geom_point(aes(x = lon, y = lat), data = data_beach2,color = "Green" , size = 3)+
  geom_point(aes(x = lon, y = lat), data = data_pub, color = "Blue" , size = 3)
 
ggmap(map_Bude_water) +
  geom_point(aes(x = lon, y = lat), data = data_cricket, color = "Red", size = 3)+
  geom_point(aes(x = lon, y = lat), data = data_beach1, color = "yellow" , size = 3)+
  geom_point(aes(x = lon, y = lat), data = data_beach2,color = "Green" , size = 3)+
  geom_point(aes(x = lon, y = lat), data = data_pub, color = "Blue" , size = 3)
