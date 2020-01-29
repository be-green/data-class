# Data analysis with data.table

# data.table is the single greatest package ever created
# maybe besides ggplot2

library(data.table)
DT <- data.table(iris)

# Syntax: DT[logical, assignment, group_by]
# this massively extends the data.frame

# Examples:
# summary by species
DT[,.(mean(Petal.Width)), by = Species]

# even crazier stuff
DT[,lapply(.SD, mean), by = Species]

# This looks crazy but don't be intimidated
# the space before the first comma is a logical condition
# that subsets the rows of the data.table

# just get setosa observations
DT[Species == "setosa"]

# The space after that comma works with columns
## Create a new column
DT[,AngrySpecies := paste0(toupper(Species),"!!!")]
DT[]

## Grab columns of interest
DT[,list(AngrySpecies, Sepal.Length)]
### equivalently
DT[,.(AngrySpecies, Sepal.Length)]

## Create new columns in subset
DT[,.(AngrySpecies, NewCol = "test")]


# the third comma has lots of special stuff in it
# but group_by is most important.
# This lets you assign columns by group

# Ex: New column by group
DT[,PetalDifference := mean(Petal.Length - Petal.Width),
   by = Species]

# data.table is the fastest data parsing package in
# existence, not just R.

# paralellized file reader (and writer)
tickers <- fread("data/ticker_list.csv")
tickers[Company %like% "APPLE"]

