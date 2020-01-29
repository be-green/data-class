# functions

# functions are contained operation
# if you have to copy something more than 2 times,
# make it a function

# create a function
# arguments go in the parentheses
add_three <- function(x) {
  x + 3 
}

add_three(2)

# note that the function does not care what x is
# when it looks for x, it will first look at 
# arguments passed into the function and then
# if it can't find it it will look in the global 
# environment
# THIS IS BAD PRACTICE, MAKE YOUR FUNCTIONS 
# SELF-CONTAINED

# GOOD
good_func <- function(y) paste0("The value of y is ",
                                y, ".")

good_func(3)

# HORRIBLE, for the love of god don't do this
y <- 3
bad_func <- function() paste0("The value of y is ",
                              y, ".")

# Notice that good_func doesn't care about y
# in the global environment

y <- 199

good_func(4)


# This means that some things you do in loops
# you can just do with functions

# Example (credit to Hadley Wickham):

# Imagine you’ve loaded a data file, 
# like the one below, that uses −99 to represent 
# missing values. 
# You want to replace all the −99s with NAs.
# sidenote: this is really all to common
# Ken French's data library, for example, uses this
# convention.

set.seed(1014)

# draw random numbers from 1:10 and -99 6 times
df <- data.frame(
  replicate(6, sample(c(1:10, -99), 6, rep = TRUE))
  )

# change the column names
names(df) <- letters[1:6]

df

# one approach is to do it one by one
df$a[df$a == -99] <- NA
df$b[df$b == -99] <- NA
df$c[df$c == -99] <- NA
df$d[df$d == -99] <- NA
df$e[df$e == -99] <- NA
df$f[df$g == -99] <- NA
# and so on

# or we could make a function do it
fix_missing <- function(x) {
  x[x == -99] <- NA
  x
}

# and apply it to the columns, remember data.frame is
# a list of columns!

df[] <- lapply(df, fix_missing)

# this is safer because you don't have to copy/paste
# and because you can test your function
# if you build code and share it with someone, they
# only have to check a single place to make sure it's
# correct.
