# Using ggplot2

# ggplot has a very specific data format
# data needs to be _long_
# so each column is a variable, each row an observation
# this is because it wants to split the data in the plot
# based on an indicator variable

# Examples

bad_df <- 
  data.frame(Bob = c(1:4),
            Alice = c(8:11),
            Carl = c(7:10),
            Date = c(0:3))

# ggplot doesn't like bad_df
# it has three columns of data with
# each person as a column
# instead it should have a name column and a separate
# values column like

good_df <- 
  data.frame(Name = c(rep("Bob",4),
                      rep("Alice",4),
                      rep("Carl",4)),
             Value = c(bad_df$Bob,
                       bad_df$Alice,
                       bad_df$Carl),
             Date = rep(bad_df$Date, 3))

print(good_df)


# you can do this faster with melt or gather
# e.g.
library(reshape2)

good_df2 <- melt(bad_df, id.vars = "Date")

# let's plot some stuff
## ggplot just creates the background
## geoms construct stacked geometric representations
## the + sign adds more and more layers to the plot

library(ggplot2)
# blank plot
# "aes" has aesthetic arguments like which variables
# control color, x axis, y axis, fill, shape, size
# to actually control colors and stuff you don't
# do it in the original call
g <- ggplot(data = good_df, 
            aes(x = Date, y = Value, color = Name))
g

ggplot(data = greenbuildings,
       aes(x = size, 
           y = Rent, 
           color = as.character(LEED))) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_x_log10() +
  scale_y_log10() + 
  facet_wrap(~LEED)

lm(Rent ~ size + LEED, data = greenbuildings) %>% 
  summary


# let's put some points on here
g <- g + geom_point()
g


# put some regression lines on there too

g <- g + geom_smooth(method = "lm")
g

# If you want to control the color, you can use
# scale_color_manual and provide a palette
# or use prebuilt palettes from ggplot2 or 
# ggthemes

# let's change the axes scale
g <- g + scale_y_continuous(labels = scales::dollar)
g

# and we can also add a title!
g <- g + ggtitle("Some title")

# edit legends with "guides"
# removes the color legend
g + guides(color = F) 


