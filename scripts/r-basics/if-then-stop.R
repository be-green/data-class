# Control flow, using if statements

## Often you want to only do a certain thing
## if something else is true
## to do this we have if/else if/else
## or ifelse()

vec <- 1:10
print(vec)
vec <- as.character(vec)


if (class(vec) != "numeric") {
  # this throws an error
  stop("vector must be numeric")
  # check if max is greater than 10
} else if(max(vec) > 10) {
  # this prints yay
  print("YAY")
  # check if max is <= 10
} else if (max(vec) <= 10) {
  print("oh no...")
  # otherwise do something else
} else {
  "what did you even do..."
}

# if-else checks a logical condition
# this is a condition that returns TRUE or FALSE
class(TRUE)
class(FALSE)
class(F)
class(T)
TRUE == T
FALSE == F

# == checks equality
# != checks not equal to
# < checks less than
# > checks greater than
class(TRUE) == "numeric"
