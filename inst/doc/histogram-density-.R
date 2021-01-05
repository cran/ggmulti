## ----setup, include=FALSE, warning=FALSE--------------------------------------
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
imageDirectory <- "./images/histogram-density-"
dataDirectory <- "./images/histogram-density-"
path_concat <- function(path1, ..., sep="/") {
  # The "/" is standard unix directory separator and so will
  # work on Macs and Linux.
  # In windows the separator might have to be sep = "\" or 
  # even sep = "\\" or possibly something else. 
  paste(path1, ..., sep = sep)
}

library(ggplot2, quietly = TRUE)
library(dplyr, quietly = TRUE)

## ----geom_bar_, echo = TRUE, eval = FALSE, message = FALSE,  warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "70%"----
#  ggplot(mtcars,
#              mapping = aes(x = factor(cyl), y = factor(gear))) +
#    geom_bar_() +
#    labs(caption = "Figure 1")

## ----geom_bar_graph, echo = FALSE, message = FALSE,  warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "70%"----
include_graphics(path_concat(imageDirectory, "barplot.png"))

## ----geom_histogram_, echo = TRUE, eval = FALSE, message = FALSE,  warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "70%"----
#  g <- ggplot(mtcars,
#              mapping = aes(x = factor(cyl), y = mpg, fill = factor(gear))) +
#    geom_histogram_() +
#    labs(caption = "Figure 2")
#  g

## ----geom_histogram_graph, echo = FALSE, message = FALSE,  warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "70%"----
include_graphics(path_concat(imageDirectory, "histogram.png"))

## ----geom_density_, echo = TRUE, eval = FALSE, message = FALSE,  warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "70%"----
#  g +
#    # parameter "positive" controls where the summaries face to
#    geom_density_(positive = FALSE, alpha = 0.2) +
#    labs(caption = "Figure 3")

## ----geom_density_graph, echo = FALSE, message = FALSE,  warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "70%"----
include_graphics(path_concat(imageDirectory, "histogram_density.png"))

## ----geom_density_ count, echo = FALSE, message = FALSE,  warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "70%"----
tab <- table(mtcars$cyl)
knitr::kable(
  data.frame(
    cyl = names(tab),
    count = unclass(tab),
    row.names = NULL
  )
)

## ----geom_density_ one var, echo = TRUE, eval = FALSE, message = FALSE,  warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "70%"----
#  ggplot(mtcars,
#         mapping = aes(x = mpg, fill = factor(cyl))) +
#    geom_density_(alpha = 0.3) +
#    labs(caption = "Figure 4")

## ----geom_density_ asOne FALSE graph, echo = FALSE, message = FALSE,  warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "70%"----
include_graphics(path_concat(imageDirectory, "density_asOne_FALSE.png"))

## ----geom_density_ asOne TRUE, echo = TRUE, eval = FALSE, message = FALSE,  warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "70%"----
#  ggplot(mtcars,
#         mapping = aes(x = mpg, fill = factor(cyl))) +
#    geom_density_(as.mix = TRUE, alpha = 0.3) +
#    labs(caption = "Figure 5")

## ----geom_density_ asOne TRUE graph, echo = FALSE, message = FALSE,  warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "70%"----
include_graphics(path_concat(imageDirectory, "density_asOne_TRUE.png"))

## ----set position stack, echo = TRUE, eval = FALSE, message = FALSE,  warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "70%"----
#  ggplot(mtcars,
#         mapping = aes(x = factor(am), y = mpg, fill = factor(cyl))) +
#    geom_density_(position = "stack_",
#                  adjust = 0.75,
#                  as.mix = TRUE) +
#    labs(caption = "Figure 6")

## ----set position stack graph, echo = FALSE, message = FALSE,  warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "70%"----
include_graphics(path_concat(imageDirectory, "stack_density.png"))

## ----set position dodge, echo = TRUE, eval = FALSE, message = FALSE,  warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "70%"----
#  ggplot(mtcars,
#         mapping = aes(x = factor(am), y = mpg, fill = factor(cyl))) +
#    # use more general function `geom_hist_`
#    # `dodge2` works without a grouping variable in a layer
#    geom_hist_(position = "dodge2_") +
#    labs(caption = "Figure 7")

## ----set position dodge graph, echo = FALSE, message = FALSE,  warning = FALSE, fig.width = 5, fig.height = 4, fig.align = "center", out.width = "70%"----
include_graphics(path_concat(imageDirectory, "dodge2_histogram.png"))

