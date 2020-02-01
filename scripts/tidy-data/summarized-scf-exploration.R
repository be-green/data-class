# working with summary scf data

library(tidyr)
library(readr)
library(dplyr)

scf <- read_csv("data/tidy-data/scf-combined-waves.csv")

# let's grab mean & median income by year!

scf %>% 
  group_by(Year) %>% 
  summarise(
    mean(income),
    median(income)
  )

# oops, this is weighted data, how would we do this with weights?
scf %>% 
  group_by(Year) %>% 
  summarise(
    # this is for you!
    # hint: "wgt" is the weight column
  )

# let's try this by gender!
# the gender column is "hhsex"
scf %>% 
  grouping_code %>% 
  summarizing_code




