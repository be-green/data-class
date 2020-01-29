# loops!
# loops let you do something iteratively
# the main type of loop folks use is the for loop
# it keeps executing until it runs out of items that
# it's given

# this loops over each element in a vector or list
for(i in 1:100) {
  # if there is no remainder for division by 10
  if(i %% 10 == 0) {
    # print the number
    print(i)
  }
}

# There are also while loops, but we can basically
# ignore those they aren't as useful

# APPLY, REDUCE, etc.
# R is a functional programming language
# this means that there are great tools for doing
# things with functions instead of loops
# I highly recommend this

# lapply
# this function takes a function as an argument
# and applies it to all elements in the list
# and then returns the process elements back
# in the same order

divide_by_3 <- function(x) {
  x/3
}

x_hat <- vector()

for(i in 1:10){
  x_hat[10] <- i/3
}

lapply(1:10, divide_by_3)

# sapply
# this is the same as lapply but it returns a vector
sapply(1:10, divide_by_3)

# Reduce
# this is a little more advanced, but very useful
# it takes in a set of elements and takes the output
# of a function and takes the next element
# as an argument

# cumulative product function
Reduce(`+`, 1:10)
cumsum(1:10)

# I know this is confusing, look at the documentation
# or experiment if you think this is something
# you would like to do