# this is an example of a pretty complete
# data exploration
# if you don't understand everything here
# that's ok!

library(haven) # read .dta files in R
library(dplyr)
library(tidyr)
library(readr)
library(stringr) # working with strings

# download the file into our local folder
file <- "https://www.federalreserve.gov/econres/files/scf2016s.zip"
download.file(file, destfile = "data/tidy-data/consumer-survey-of-finances.zip")
unzip("data/tidy-data/consumer-survey-of-finances.zip",
      exdir = "data/tidy-data")

# read in the survey of consumer finances
# taken from here: 
# https://www.federalreserve.gov/econres/scfindex.htm
scf <- read_dta("data/tidy-data/p16i6.dta")

# oof these column names look ugly
scf %>% 
  colnames %>% 
  head(10)

# column descriptions are in ASCII on the
# federal reserve website
# it is tab-delimited
# let's read it in to help with exploration
col_desc <- read_tsv(
    "https://www.federalreserve.gov/econres/files/2016map.txt",
    col_names = F
  ) %>% 
  # first column doesn't use a tab separator,
  # we need to separate column names and
  # descriptions
  separate(col = X1,
           into = c("Variable","Description"),
           sep = "    ") %>% 
  # trim the whitespace after separation
  mutate(
    Description = str_trim(Description)
  )

# which variables actually have descriptions?
filter(col_desc, !is.na(Description))

# what does this one column look like
filter(col_desc, Variable == "X7559") %>% View

# hmm... so it seems like we may be able to 
# further split up our description files
# to find useful variables
# based on looking at some of the output
col_desc <- separate(col_desc,
           col = Description,
           into = c("Question", 
                    "Category",
                    "SubCategory",
                    "FurtherInfo"),
           sep = ": ", # separated by :
           # merge if there are more values 
           # than fit in 4 columns
           extra = "merge") 

# now let's look at it
col_desc %>% 
  filter(Variable == "X7559") %>% 
  View

# ok so it's category is financial literacy
# what else is in that category?
col_desc %>% 
  filter(Category == "FIN LIT") %>% 
  View

# see all unique categories
unique(col_desc$Category)

# see all questions that have 
# "HAVE" in them
filter(col_desc,
       str_detect(Category, "HAVE")) %>% 
  View

## Let's zoom in on financial literacy
# what are the typical rates of financial
# literacy?

# get a vector of variables
literacy_vars <- col_desc %>% 
  filter(Category == "FIN LIT") %>%
  # pull out the variables we want
  select("Variable", "SubCategory") %>% 
  mutate(SubCategory = 
           str_replace_all(SubCategory,
                           " ",
                           "_")
  )

rename_all_columns <- function(tbl, new_names) {
  if(length(new_names) != length(tbl)) {
    stop("There must be the same number of ",
         "names as columns in the dataset")
  }
  colnames(tbl) <- new_names
  tbl
}

# just grab those variables
fin_literacy <- 
  scf %>% 
  select(literacy_vars$Variable) %>% 
  # rename them
  rename_all_columns(literacy_vars$SubCategory) %>% 
  # create id for responses
  mutate(ResponseID = 1:length(STOCK_RISK)) %>% 
  # create our own variables based on
  # whether the responses are correct
  mutate(
    STOCK_RISK = ifelse(
      STOCK_RISK == 5,
      "Right", "Wrong"
      ),
     INTEREST_RATES = ifelse(
       INTEREST_RATES == 1,
       "Right", "Wrong"
       ),
    INFLATION = ifelse(
      INFLATION == 5,
      "Right", "Wrong"
    )
  ) %>% 
  # pivot them long
  # so that we have tidy data again
  pivot_longer(cols = -ResponseID)


fin_literacy %>% 
  # make the names pretty for graphing
  mutate(
    name = name %>% 
      str_replace_all("_"," ") %>% 
      str_to_title,
  ) %>% 
  # create weighting because we want to see
  # percent responses instead of counts
  group_by(name) %>% 
  mutate(weight = 1/length(name)) %>% 
  # graph the counts by name
  ggplot(aes(x = name, fill = value,
             weight = weight)) +
  geom_bar() +
  labs(fill = "", y = "") +
  scale_y_continuous(labels = scales::percent) +
  ggtitle("Responses to Financial Literacy Questions",
          subtitle = "Based on the Survey of Consumer Finance")
