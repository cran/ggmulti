## ----setup, include=FALSE, warning=FALSE, message=FALSE-----------------------
knitr::opts_chunk$set(echo = TRUE, 
                      warning = FALSE,
                      message = FALSE,
                      fig.align = "center", 
                      fig.width = 7, 
                      fig.height = 6,
                      out.width = "60%", 
                      collapse = TRUE,
                      comment = "#>",
                      tidy.opts = list(width.cutoff = 65),
                      tidy = FALSE)
library(knitr)
set.seed(12314159)
imageDirectory <- "./images/glyph"
dataDirectory <- "./data/glyph"
path_concat <- function(path1, ..., sep="/") {
  # The "/" is standard unix directory separator and so will
  # work on Macs and Linux.
  # In windows the separator might have to be sep = "\" or 
  # even sep = "\\" or possibly something else. 
  paste(path1, ..., sep = sep)
}
library(ggplot2, quietly = TRUE)
library(dplyr, quietly = TRUE)

## ----glyph_ggplot-------------------------------------------------------------
library(ggmulti)
library(nycflights13)
library(maps)

# Flight destinations
destinations <- nycflights13::airports %>% 
  dplyr::rename(dest = faa) %>% 
  dplyr::semi_join(nycflights13::flights, by = "dest") %>% 
  dplyr::mutate(tzone = gsub("America/", "", tzone)) %>% 
  dplyr::filter(lon > -151, 
                lat < 55)

# New York City coordinates
NY <- data.frame(
  lon = -73.935242,
  lat = 40.730610
)
US <- map_data("state")  %>% 
  ggplot(aes(long, lat)) +
  geom_polygon(mapping = aes(group = group), 
               color="black", fill="cornsilk") 
NYflightDestinationMap <- US + 
  geom_polygon_glyph(data = destinations,
                     mapping = aes(x = lon, y = lat),
                     fill = "pink",
                     # negate x to have each plane face west
                     polygon_x = -x_airplane, 
                     polygon_y = y_airplane,
                     alpha = 0.75) + 
  geom_polygon_glyph(data = NY,
                     mapping = aes(x = lon, y = lat),
                     polygon_x = x_star,
                     polygon_y = y_star, 
                     alpha = 0.75, 
                     fill = "blue")
NYflightDestinationMap

## ----download images----------------------------------------------------------
library(png)
img_path <- list.files(file.path(find.package(package = 'ggmulti'),
                                 "images"),
                       full.names = TRUE)
Raptors <- png::readPNG(img_path[grepl("Raptors", img_path)])
Warriors <- png::readPNG(img_path[grepl("Warriors", img_path)])

## ----image glyph NBA 2020-----------------------------------------------------
# Golden State Coordinate
GoldenState <- data.frame(
  lon = -119.4179,
  lat = 36.7783
)

Toronto <- data.frame(
  lon = -79.3832,
  lat = 43.6532
)

# Get the Canada lakes
cdn.lakes <-  maps::map("lakes",
                        plot=FALSE,
                        fill=TRUE)$names[c(7,8,27,22, 25,
                                           68:73, 82, 85
                        )]

US + 
  geom_polygon(
    data = maps::map("world",  "Canada", fill=TRUE, plot=FALSE),
    mapping = aes(long, lat, group = group), 
    fill="#ffcccb", colour = "black"
  ) + 
  geom_polygon(
    # lakes in Canada
    data =  maps::map("lakes", cdn.lakes, plot=FALSE, fill=TRUE),
    mapping = aes(long, lat, group = group), 
    fill="lightblue", colour = "black"
  ) + 
  geom_image_glyph(data = GoldenState,
                   mapping = aes(x = lon, y = lat), 
                   images = Warriors,
                   imagewidth = 1, 
                   imageheight = 1, 
                   colour = NA,
                   size = 3) + 
  geom_image_glyph(data = Toronto,
                   mapping = aes(x = lon, y = lat), 
                   imagewidth = 1, 
                   imageheight = 1, 
                   colour = NA,
                   size = 3,
                   images = Raptors) + 
  ggtitle("2019 NBA Finals")

## ----serialaxes glyph---------------------------------------------------------
ggplot(iris) +
  geom_serialaxes_glyph(
    mapping = aes(Sepal.Length, Sepal.Width, colour = Species),
     # set serial axes data set (could be different from the original data)
    serialaxes.data = iris,
    # parallel or radial axes
    axes.layout = "radial", 
     # sequence of serial axes
    axes.sequence = colnames(iris)[-5]
  )

