# Vectors
## vectors are a series of elements with a single type

## create a vector with c()
vec <- c(1,4,5,7)

## grab the 4th element
vec[4]

class(vec)

## vectors can also be strings (character vectors)

str_vec <- c("A","b","hello")
class(str_vec)

## vectors are "coerced" to the type that fits all of
## its elements. Check types if you are getting errors!

coerced_vec <- c("A",2:4)
class(coerced_vec)

# Lists
## Lists don't need a single type or
## the same length

## creating lists

l <- list(c(1,2,3),(c("A","b")),3)

# grab first element in list
num <- l[[1]]

# grab first number in that element
num[1]
class(num)

class(l)

# Data Frames/Data Tables/Tibbles

## These are all extensions of base R's data frame
## a data frame is a list of vectors when vectors
## have equal length

## create them with data.frame()
df <- data.frame(vec, coerced_vec)

## can't have different lengths
data.frame(coerced_vec, num)

colnames(df) <- c("Column1","Column2")

## columns have names that you can reference
## this is true for lists as well if you
## name the elements
df$vec

## new columns from old
df$newcol <- df$vec/2

## it goes df[rownumbers,columnnumbers]
df[1:2,2:3]

## you can also use subset() to subset based
## on a logical condition



