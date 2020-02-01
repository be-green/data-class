library(tidyr)
library(dplyr)
library(ggplot2)

# Let's write some of our own functions
# to use in this pipeline
# you can write any operation as a function

get_resid <- function(data, form, model = 'lm') {
  # do a regression model
  lm(data = data,
     formula = form) %>% 
  resid() %>% 
  as.numeric
}

# visualize distribution of residuals
# by species
# we can see that virginica looks 
# mis-modeled by petal width
# maybe the species shouldn't be pooled together
iris %>% 
  # get residuals from a linear regression model
  mutate(
    Residuals = get_resid(
      data = .,
      form = Petal.Length ~ Petal.Width
      )
  ) %>% 
  # plot the residuals in a histogram
  ggplot(
    aes(x = Residuals)
  ) + 
  geom_histogram() +
  # create small multiples by species
  facet_wrap(~Species, ncol = 1)

