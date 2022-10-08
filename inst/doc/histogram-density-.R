## ----setup, include=FALSE, warning=FALSE--------------------------------------
knitr::opts_chunk$set(echo = TRUE, 
                      message = FALSE,  
                      warning = FALSE, 
                      fig.width = 4, 
                      fig.height = 3, 
                      fig.align = "center", 
                      out.width = "70%", 
                      collapse = TRUE,
                      comment = "#>",
                      tidy.opts = list(width.cutoff = 65),
                      tidy = FALSE)
library(knitr)
set.seed(12314159)
imageDirectory <- "./images/histogram-density-"
dataDirectory <- "./data/histogram-density-"
path_concat <- function(path1, ..., sep="/") {
  # The "/" is standard unix directory separator and so will
  # work on Macs and Linux.
  # In windows the separator might have to be sep = "\" or 
  # even sep = "\\" or possibly something else. 
  paste(path1, ..., sep = sep)
}
library(dplyr, quietly = TRUE)

## ----set data-----------------------------------------------------------------
mtcars2 <- mtcars %>% 
  mutate(
    cyl = factor(cyl),
    gear  = factor(gear)
  )

## ----geom_bar_graph-----------------------------------------------------------
library(ggmulti)
ggplot(mtcars2, 
       mapping = aes(x = cyl, y = gear)) + 
  geom_bar_(as.mix = TRUE) + 
  labs(caption = "Figure 1")

## ----geom_histogram_graph-----------------------------------------------------
g <- ggplot(mtcars2, 
            mapping = aes(x = cyl, 
                          y = mpg, 
                          fill = gear)) + 
  geom_histogram_(as.mix = TRUE) + 
  labs(caption = "Figure 2")
g

## ----geom_density_graph-------------------------------------------------------
g + 
  # parameter "positive" controls where the summaries face to
  geom_density_(as.mix = TRUE, 
                positive = FALSE, 
                alpha = 0.2) + 
  labs(caption = "Figure 3")

## ----geom_density_count-------------------------------------------------------
tab <- table(mtcars2$cyl)
knitr::kable(
  data.frame(
    cyl = names(tab),
    count = unclass(tab),
    row.names = NULL
  )
)

## ----geom_density, fig.width=10, fig.height=6---------------------------------
gd1 <- ggplot(mtcars2, 
              mapping = aes(x = mpg, fill = cyl)) + 
  # it is equivalent to call `geom_density()`
  geom_density_(alpha = 0.3) + 
  scale_fill_brewer(palette = "Set3") + 
  labs(caption = "Figure 4")
gd2 <- ggplot(mtcars2, 
              mapping = aes(x = mpg, fill = cyl)) + 
  geom_density_(as.mix = TRUE, alpha = 0.3) + 
  scale_fill_brewer(palette = "Set3") + 
  labs(caption = "Figure 5")
gridExtra::grid.arrange(gd1, gd2, nrow = 1)

## ----geom_density_graph scale.y-----------------------------------------------
g + 
  # parameter "positive" controls where the summaries face to
  geom_density_(positive = FALSE, 
                alpha = 0.2, 
                scale.y = "group") + 
  labs(caption = "Figure 6")

## ----arbitrary data-----------------------------------------------------------
data <- data.frame(x = c(rep("1", 900), rep("2", 100)), 
                   y = rnorm(1000),
                   z = c(rep("A", 100), rep("B", 800), 
                         rep("A", 10), rep("B", 90)))
data %>% 
  dplyr::group_by(x, z) %>% 
  summarise(count = n()) %>% 
  kable()

## ----overall comparison, fig.width=10, fig.height=8---------------------------
grobs <- list()
i <- 0
position <- "stack_"
prop <- 0.4

for(scale.y in c("data", "group")) {
  for(as.mix in c(TRUE, FALSE)) {
    i <- i + 1
    g <- ggplot(data, mapping = aes(x = x, y = y, fill = z)) + 
      geom_histogram_(scale.y = scale.y, 
                      as.mix = as.mix, 
                      position = position,
                      prop = prop) + 
      geom_density_(scale.y = scale.y, as.mix = as.mix,
                    positive = FALSE,
                    position = position,
                    alpha = 0.4, 
                    prop = prop) + 
      ggtitle(
        label = paste0("`scale.y` is ", scale.y, "\n",
                       "`as.mix` is ", as.mix)
      )
    if(i == 4)
      g <- g + labs(caption = "Figure 7")
    grobs <- c(grobs, list(g))
  }
}
gridExtra::grid.arrange(grobs = grobs, nrow = 2)

## ----set position stack-------------------------------------------------------
ggplot(mtcars, 
       mapping = aes(x = factor(am), y = mpg, fill = factor(cyl))) + 
  geom_density_(position = "stack_",
                prop = 0.75,
                as.mix = TRUE) + 
  labs(caption = "Figure 8")

## ----set position dodge-------------------------------------------------------
ggplot(mtcars, 
       mapping = aes(x = factor(am), y = mpg, fill = factor(cyl))) +
  # use more general function `geom_hist_`
  # `dodge2` works without a grouping variable in a layer
  geom_hist_(position = "dodge2_") + 
  labs(caption = "Figure 7")

