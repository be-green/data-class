library(tidyr)
library(dplyr)

# see first  10 rows of iris dataset
# built-in to R, so we don't need to 
# read anything in
head(iris, 10)

iris <- iris

# pivot_longer takes a data.frame/data.table/tibble
# and melts it down it into tidy data
# grouping all the columns into a single column
# with names given by "key" and "value"
# and all specified columns
# you can also ignore specific columns
# via -col_name
tidy_iris <- pivot_longer(iris,
                          cols = -Species,
                          names_to = "Variable",
                          values_to = "Measurement"
                          )

View(tidy_iris)

# what if we want our old data back?
# that's what pivot_wider is for!
# But pivot_wider means that we need
# a unique identifier for each observation
# otherwise it doesn't know how to order them!

# create row observation identifier

untidied_iris <- tidy_iris %>% 
  # create row observation identifier
  group_by(Species, Variable) %>% 
  mutate(ObsNum = 1:length(Measurement)) %>% 
  # pivot out back to original format
  pivot_wider(
    id_cols = c("Species","ObsNum"),
    names_from = "Variable",
    values_from = "Measurement"
  )

untidied_iris %>% 
  View

# Let's practice some basic operations

# Get summary stats of each variable 
# by each species
# of iris
tidy_iris %>% 
  group_by(Species, Variable) %>% 
  summarise(Avg = mean(Measurement),
            SD = sd(Measurement),
            Max = max(Measurement),
            Min = min(Measurement))

# Just look at petal length
tidy_iris %>% 
  filter(Variable == "Petal.Length")

# Let's add a new column w/ log of measurements
tidy_iris %>% 
  mutate(LogMeasure = log(Measurement))


# Practice:
# Add a log measurement
# and generate summary stats
# I've added in structure to help guide
tidy_iris %>% 
  code_that_groups %>% 
  code_that_adds_log %>% 
  code_that_summarises
  
# Practice:
# Get 95% and 5% measurements
# of each measurement
# by species
# hint, lookup function with
# ?quantile
tidy_iris %>% 
  code_that_groups %>% 
  code_that_quantiles

