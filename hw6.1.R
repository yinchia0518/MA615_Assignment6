library(ggmap)
library(mapproj)

gc <- geocode(location = 'Boston')
map <- get_map(gc)
map <- get_map(gc, zoom = 7,
               language = "zh-TW")
ggmap(map)

map <- get_map(location = c(lon = 120.233937, lat = 22.993013),
               zoom = 10, language = "zh-TW")
ggmap(map)


library(ggmap)
library(ggplot2)

d <- data.frame(lat=c(50.659631, 50.607213, 50.608129),
                lon=c(3.09319, 3.011473, 3.031529))

Lille <- get_map("Lille,France", zoom=12)

p <- ggmap(Lille)
p <- p + geom_point(data=d, aes(lat, lon))
p

p + geom_point(data=d, aes(x=lon, y=lat), color="red", size=30, alpha=0.5)