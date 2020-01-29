# Packages!
# packages are extensions of "base R", the
# language you install when you download R

# install a new packages

pkgs <- c("magrittr", "ggplot2", "data.table")

install.packages(pkgs)

# loading packages
# loading packages allows you to access their code
# if you run 
search()
# in your console, it will tell you what packages
# are attached
# those are the places where R searches for the thing
# you are trying to use
# the order denotes the priority of the search

# check if package is installed and if yes then 
# load it

require("test")

# load package, if you don't have it then error
library(test)

# I heavily prefer library because of this behavior
# otherwise if someone runs a script without the 
# relevant packages then they won't be able to
# tell where it went wrong as easily

# Accessing something in package without attaching or
# loading it

# you can use :: to access something in a package
# without attaching it
mosaic::bargraph(~mpg, data = mtcars)

# Installing packages from github
# run install.packages("devtools")
devtools::install_github("person/repo")

