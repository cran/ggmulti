## ----setup, include=FALSE, warning=FALSE, message=FALSE-----------------------
knitr::opts_chunk$set(echo = TRUE, 
                      warning = FALSE,
                      message = FALSE,
                      fig.align = "center", 
                      fig.width = 6, 
                      fig.height = 5,
                      out.width = "60%", 
                      collapse = TRUE,
                      comment = "#>",
                      tidy.opts = list(width.cutoff = 65),
                      tidy = FALSE)
library(knitr)
set.seed(12314159)
imageDirectory <- "./images/highDim"
dataDirectory <- "./data/highDim"
path_concat <- function(path1, ..., sep="/") {
  # The "/" is standard unix directory separator and so will
  # work on Macs and Linux.
  # In windows the separator might have to be sep = "\" or 
  # even sep = "\\" or possibly something else. 
  paste(path1, ..., sep = sep)
}

library(ggplot2, quietly = TRUE)
library(dplyr, quietly = TRUE)

## ----serialaxes, message = FALSE, warning = FALSE, eval = FALSE, fig.width = 9, fig.height = 3, fig.align = "center", out.width = "70%"----
#  library(ggmulti)
#  # parallel axes plot
#  ggplot(iris,
#         mapping = aes(
#           Sepal.Length = Sepal.Length,
#           Sepal.Width = Sepal.Width,
#           Petal.Length = Petal.Length,
#           Petal.Width = Petal.Width,
#           colour = factor(Species))) +
#    geom_path(alpha = 0.2)  +
#    coord_serialaxes() -> p
#  p

## ----serialaxes_graph, echo = FALSE, message = FALSE,  warning = FALSE, fig.width = 9, fig.height = 4, fig.align = "center", out.width = "70%"----
include_graphics(path_concat(imageDirectory, "parallel.png"))

## ----serialaxes histogram, message = FALSE, warning = FALSE, eval = FALSE, fig.width = 9, fig.height = 3, fig.align = "center", out.width = "70%"----
#  p +
#    geom_histogram(alpha = 0.3,
#                   mapping = aes(fill = factor(Species))) +
#    theme(axis.text.x = element_text(angle = 30, hjust = 0.7))

## ----serialaxes histogram graph, echo = FALSE, message = FALSE,  warning = FALSE, fig.width = 9, fig.height = 4, fig.align = "center", out.width = "70%"----
include_graphics(path_concat(imageDirectory, "parallel_histogram.png"))

## ----serialaxes density, message = FALSE, warning = FALSE, eval = FALSE, fig.width = 9, fig.height = 3, fig.align = "center", out.width = "70%"----
#  p +
#    geom_density(alpha = 0.3,
#                 mapping = aes(fill = factor(Species)))

## ----serialaxes density graph, echo = FALSE, message = FALSE,  warning = FALSE, fig.width = 9, fig.height = 4, fig.align = "center", out.width = "70%"----
include_graphics(path_concat(imageDirectory, "parallel_density.png"))

## ----radial, message = FALSE, warning = FALSE, eval = FALSE, fig.width = 9, fig.height = 3, fig.align = "center", out.width = "70%"----
#  p$coordinates$axes.layout <- "radial"
#  p

## ----radial graph, echo = FALSE, message = FALSE,  warning = FALSE, fig.width = 9, fig.height = 4, fig.align = "center", out.width = "70%"----
include_graphics(path_concat(imageDirectory, "radial.png"))

## ----andrews, message = FALSE, warning = FALSE, eval = FALSE, fig.width = 6, fig.height = 4, fig.align = "center", out.width = "70%"----
#  p <- ggplot(iris,
#              mapping = aes(Sepal.Length = Sepal.Length,
#                            Sepal.Width = Sepal.Width,
#                            Petal.Length = Petal.Length,
#                            Petal.Width = Petal.Width,
#                            colour = Species)) +
#    geom_path(alpha = 0.2,
#              stat = "dotProduct")  +
#    coord_serialaxes()
#  p

## ----andrews graph, echo = FALSE, message = FALSE,  warning = FALSE, fig.width = 9, fig.height = 4, fig.align = "center", out.width = "70%"----
include_graphics(path_concat(imageDirectory, "andrews.png"))

## ----andrews with quantile, message = FALSE, warning = FALSE, eval = FALSE, fig.width = 9, fig.height = 3, fig.align = "center", out.width = "70%"----
#  p +
#   geom_quantiles(stat = "dotProduct",
#                  quantiles = c(0.25, 0.5, 0.75),
#                  size = 2,
#                  linetype = 2)

## ----andrews with quantile graph, echo = FALSE, message = FALSE,  warning = FALSE, fig.width = 9, fig.height = 4, fig.align = "center", out.width = "70%"----
include_graphics(path_concat(imageDirectory, "andrews_quantile.png"))

## ----tukey, message = FALSE, warning = FALSE, eval = FALSE, fig.width = 9, fig.height = 3, fig.align = "center", out.width = "70%"----
#  tukey <- function(p = 4, k = 50 * (p - 1), ...) {
#    t <- seq(0, p* base::pi, length.out = k)
#    seq_k <- seq(p)
#    values <- sapply(seq_k,
#                     function(i) {
#                       if(i == 1) return(cos(t))
#                       if(i == 2) return(cos(sqrt(2) * t))
#                       Fibonacci <- seq_k[i - 1] + seq_k[i - 2]
#                       cos(sqrt(Fibonacci) * t)
#                     })
#    list(
#      vector = t,
#      matrix = matrix(values, nrow = p, byrow = TRUE)
#    )
#  }
#  ggplot(iris,
#         mapping = aes(Sepal.Length = Sepal.Length,
#                       Sepal.Width = Sepal.Width,
#                       Petal.Length = Petal.Length,
#                       Petal.Width = Petal.Width,
#                       colour = Species)) +
#    geom_path(alpha = 0.2, stat = "dotProduct", transform = tukey)  +
#    coord_serialaxes()

## ----tukey graph, echo = FALSE, message = FALSE,  warning = FALSE, fig.width = 9, fig.height = 4, fig.align = "center", out.width = "70%"----
include_graphics(path_concat(imageDirectory, "tukey.png"))

## ----geom_serialaxes_ objects, eval = FALSE-----------------------------------
#  g <- ggplot(iris,
#              mapping = aes(Sepal.Length = Sepal.Length,
#                            Sepal.Width = Sepal.Width,
#                            Petal.Length = Petal.Length,
#                            Petal.Width = Petal.Width,
#                            colour = Species))
#  g + geom_serialaxes(alpha = 0.2)
#  g +
#    geom_serialaxes(alpha = 0.2) +
#    geom_serialaxes_hist(mapping = aes(fill = Species), alpha = 0.2)
#  g +
#    geom_serialaxes(alpha = 0.2) +
#    geom_serialaxes_density(mapping = aes(fill = Species), alpha = 0.2)
#  # radial axes can be created by
#  # calling `coord_radial()`
#  # this is slightly different, check it out!
#  g +
#    geom_serialaxes(alpha = 0.2) +
#    geom_serialaxes(alpha = 0.2) +
#    coord_radial()

## ----benefits of coord_serialaxes, eval=FALSE---------------------------------
#  # The serial axes is `Sepal.Length`, `Sepal.Width`, `Sepal.Length`
#  # With meaningful labels
#  ggplot(iris,
#         mapping = aes(Sepal.Length = Sepal.Length,
#                       Sepal.Width = Sepal.Width,
#                       Sepal.Length = Sepal.Length)) +
#    geom_path() +
#    coord_serialaxes()
#  
#  # The serial axes is `Sepal.Length`, `Sepal.Length`
#  # No meaningful labels
#  ggplot(iris,
#         mapping = aes(Sepal.Length = Sepal.Length,
#                       Sepal.Width = Sepal.Width,
#                       Sepal.Length = Sepal.Length)) +
#    geom_serialaxes()

## ----axes.sequence, eval=FALSE------------------------------------------------
#  ggplot(iris) +
#    geom_path() +
#    coord_serialaxes(axes.sequence = colnames(iris)[-5])

