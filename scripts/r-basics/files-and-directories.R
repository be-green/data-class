# Files and working directory

# The Working Directory is where R looks for things
# you can check what that directory is with
getwd()

# if it has a ~/ in it and you aren't sure what that means
# run 
path.expand(getwd())

# That folder is where R is going to look for relevant
# files

# right now I'm in my intro-to-ro folder, and I 
# can check what files are there with 

list.files()

# If I want to see subfolders I go

list.files(recursive = T)

# If I want to source a file in my working directory
# I can run

source("R/basics-and-classes.R")

# If I want to read in a dataset
# I can just reference it relative to my
# working directory

read.csv("data/ticker_list.csv")
