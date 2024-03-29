## ----setup, include=FALSE, warning=FALSE, message=FALSE-----------------------
knitr::opts_chunk$set(echo = TRUE, 
                      warning = FALSE,
                      message = FALSE,
                      fig.align = "center", 
                      fig.width = 7, 
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

## ----serialaxes---------------------------------------------------------------
library(ggmulti)
# parallel axes plot
ggplot(iris, 
       mapping = aes(
         Sepal.Length = Sepal.Length,
         Sepal.Width = Sepal.Width,
         Petal.Length = Petal.Length,
         Petal.Width = Petal.Width,
         colour = factor(Species))) +
  geom_path(alpha = 0.2)  + 
  coord_serialaxes() -> p
p

## ----serialaxes histogram-----------------------------------------------------
p + 
  geom_histogram(alpha = 0.3, 
                 mapping = aes(fill = factor(Species))) + 
  theme(axis.text.x = element_text(angle = 30, hjust = 0.7))

## ----serialaxes density-------------------------------------------------------
p + 
  geom_density(alpha = 0.3, 
               mapping = aes(fill = factor(Species)))

## ----radial, fig.width = 5----------------------------------------------------
p$coordinates$axes.layout <- "radial"
p

## ----andrews------------------------------------------------------------------
p <- ggplot(iris, 
            mapping = aes(Sepal.Length = Sepal.Length,
                          Sepal.Width = Sepal.Width,
                          Petal.Length = Petal.Length,
                          Petal.Width = Petal.Width,
                          colour = Species)) +
  geom_path(alpha = 0.2, 
            stat = "dotProduct")  + 
  coord_serialaxes()
p

## ----andrews with quantile----------------------------------------------------
p + 
 geom_quantiles(stat = "dotProduct",
                quantiles = c(0.25, 0.5, 0.75),
                linewidth = 2,
                linetype = 2) 

## ----tukey--------------------------------------------------------------------
tukey <- function(p = 4, k = 50 * (p - 1), ...) {
  t <- seq(0, p* base::pi, length.out = k)
  seq_k <- seq(p)
  values <- sapply(seq_k,
                   function(i) {
                     if(i == 1) return(cos(t))
                     if(i == 2) return(cos(sqrt(2) * t))
                     Fibonacci <- seq_k[i - 1] + seq_k[i - 2]
                     cos(sqrt(Fibonacci) * t)
                   })
  list(
    vector = t,
    matrix = matrix(values, nrow = p, byrow = TRUE)
  )
}
ggplot(iris, 
       mapping = aes(Sepal.Length = Sepal.Length,
                     Sepal.Width = Sepal.Width,
                     Petal.Length = Petal.Length,
                     Petal.Width = Petal.Width,
                     colour = Species)) +
  geom_path(alpha = 0.2, stat = "dotProduct", transform = tukey)  + 
  coord_serialaxes()

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

