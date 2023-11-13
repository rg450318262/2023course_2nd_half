# ******************************************************** #
# Worksheet 1: Basics of R for data research               #
# ******************************************************** #

# You can execute commands in a script (like this one) by either typing
# them into the Console window below and pressing Enter, or by moving the cursor
# to the command in the script and pressing Ctrl+Enter (or Command+Enter).
#
# This script guides you through some basic usage and functionalities of R,
# such as
#   - packages
#   - inspecting data
#   - counting
#   - manipulating data
#   - reading data
#   - creating summaries
#   - statistical analyses
#   - visualising data.
#
# Read through the script, try out the commands, and experiment on your own.
# You can execute anything that is not preceded by a # sign.
# When a command is executed, the results are shown in the Console pane.
#
# In RStudio, you can view the section from the "outline" pane (top right
# corner of the code pane or Ctrl+Shift+O) or from the shortcut menu
# (below the code pane).
# ********************************************************

# Packages ------

# Packages (also called 'libraries') contain additional functions, commands,
# methods and data that can be called in your session.

# In these worksheets, we will often need packages from the 'tidyverse'
# collection. These can all be called with a single call:
install.packages("tidyverse")
library(tidyverse)

# If a package is not found, you can install it with 
# install.packages("tidyverse")
# or from the menu: Tools -> Install packages...

# Inspecting the data ---------------------------------

# The dataset 'iris' is included in R example materials and can be accessed directly.
# (Irises are a genus of flowers often found in gardens.)
data("iris")

# Find 'iris' in the Environment pane (you many need to click it).
# How many rows (observations) and how many columns (variables) does 'iris' contain?

# Click on 'iris' in the Environment pane or type View(iris) to examine the data.
View(iris)

# What variables does the iris data contain?
# Try executing the following commands. What can you see?
nrow(iris)
ncol(iris)
colnames(iris)
head(iris)
glimpse(iris)
summary(iris)

# You can access individual columns in a data frame using the $ sign, for example:
iris$Petal.Length

# Try accessing other columns.

# Try executing
length(iris$Petal.Length)
head(iris$Petal.Length)
glimpse(iris$Petal.Length)
summary(iris$Petal.Length)

# Can you find the same information in summary(iris) as in summary(iris$Petal.Length)?
# What about the other commands?

# You can also view information by plotting.
# Plots appear in the Plots pane where you can zoom and navigate to see earlier plots.
#
# What do the following plots show?
hist(iris$Petal.Length)
plot(iris$Petal.Width ~ iris$Petal.Length)
boxplot(iris$Petal.Length)
 
# Plots can be modified with extra options.
hist(iris$Petal.Length, breaks = c(0,2,4,6,8))
plot(iris$Petal.Width ~ iris$Petal.Length, col = "blue")

# An x-y scatter plot can be constructed in different ways:
plot(iris$Petal.Width ~ iris$Petal.Length)
plot(x=iris$Petal.Width, y=iris$Petal.Length)
plot(Petal.Width ~ Petal.Length, data=iris)

# The ~ sign is used in R to denote a 'formula', a dependence between variables.
# It is used a lot in statistical analyses.

# In the above scatter plots, certain points are grouped together.
# What do you think this might mean?
#
# Try to guess what the following code does before executing:
# GUESS FIRST: plot(Petal.Width ~ Petal.Length, data = iris, col=Species)

# Later we will learn to build more attractive plots.

# Saving the script ---------------------------------

# The simplest way to save your script is to press Ctrl+S. You can also use the menu
# File -> Save/Save As...
# It is important to save the script often, so you don't lose any work.
#
# In R, it is more important to save the script than the data or results, because
# the results can always be recreated from the script, but the script cannot be
# recreated from the results.

# Indexing -------------------------------------

# Instead of single columns, you can refer to any portion of data by indexing it
# with ranges.
iris[1:5, 2:3]

# You can also use single values or column names.
iris[123, "Petal.Length"]

# For more complicated indexing, you can use the 'c()' command.
# This creates a so-called "vector" of indices.
iris[c(2,3,5,7,11), c("Sepal.Width", "Petal.Width")]

# In addition to data frames, vectors are another important data type in R.
# In fact, a column in a data frame is a vector.

# Counting -------------------------------------

# Frequencies (number of occurrences of a value) can be counted
# in two basic ways:
table(iris$Species)
count(iris, Species)

# Counts can be illustrated with a bar plot, if 'table()' is used.
barplot(table(iris$Species))

# Manipulating data ----------------------------

# The 'dpyr' package (included in tidyverse) contains many functions
# that are useful for manipulating data.
# Here, we will look at 'select', 'filter' and 'mutate'.

# When manipulating data, we use the "pipe", written as |>
# The pipe lets us insert the result of a previous command directly into the next.
# This makes it possible to do several actions on a dataset in one go.
# A piping sequence looks something like this:
#
# data |>
#  command1() |>
#  command2() |>
#   ...

# 'select' lets you select columns from the dataset
iris |>
  select(Species, Petal.Length)

# 'filter' lets you select rows that satisfy a condition
iris |>
  filter(Species == "setosa")

iris |>
  filter(Petal.Length > 6)

iris |>
  filter(Petal.Length > 4 & Petal.Width < 1.5)

iris |>
  filter(Petal.Length > 6.5 | Petal.Length == min(Petal.Length))  # | means 'or'

# Note that in R, equality is marked with == 

# In the previous commands, the results are printed into the console and then lost.
# If we want to save the modified data in a new named dataset,
# we use the assignment operator <-
iris_setosa_long_petals <- iris |>
  select(Petal.Length, Petal.Width, Species) |>
  filter(Species == "setosa",
         Petal.Length >= 1.5)

# 'mutate' lets you change the values in a column or create a new column.
iris_versicolor_mm <- iris |>
  filter(Species == "versicolor") |>
  mutate(petal_mm = 10 * Petal.Length)

# Note the difference between '==' and '='.
# The first means "equals" and is used when comparing values,
# the second means "will be" and is used when making changes to data.

# Inspect the new dataset iris_setosa_mm.

# When creating the new column above, the operation '10 * ...' was applied
# to every value in the column automatically.
# This is called "vector arithmetic", meaning that whole vectors (such as columns)
# can be manipulated in the same operation.
# Below are more examples:
iris$Petal.Length * 10
iris$Petal.Length + iris$Petal.Width
iris$Petal.Length - mean(iris$Petal.Length)  # Can you guess what this does?

# About pipes ----------------------------------

# Historically, R did not have a pipe operation, and data manipulation was
# very cumbersome. The 'magrittr' package introduced a pipe written as %>%
# (art connoisseurs will get the joke). This pipe became part of tidyverse
# and was in such widespread use that RStudio introduced a shorthand
# keyboard command Ctrl+Shift+M for it.
#
# In version 4.1.0, the "native" pipe |> was introduced to R.
# This pipe works without loading any packages. The two pipes have
# subtle differences, but the basic functionality is the same. In RStudio, 
# you can change the Ctrl+Shift+M shorthand to refer to the native pipe
# in the menu Tools -> Global Options -> Code -> Use native pipe operator.

# Reading data ---------------------------------

# To read data into R, you need the correct function for the file type.
# You also need to know the package where the function can be found.
# Typical functions are:
#
#   package readr
#     read_csv() for comma-separated values
#     read_csv2() for semicolon-separated values
#
#   package readxl
#     read_excel() for Excel files
#
#   package haven
#     read_sav() for SPSS files
#     read_sas() for SAS files
#     read_dta() for Stat files

# Comma (or semicolon) separated values are useful because they can be
# opened with any programme and even edited with a text editor.
# On the other hand, their file size can be quite large for big datasets.

# Let us read hypothetical student aptitude data from a file called
# "tobit.csv".
# We assign it to a dataset called 'tobit' using the assigment operator.
tobit <- read_csv("tobit.csv")

# Files can also be read by clicking them in the Files pane,
# but in that case the operation is not saved in the script.

# Summaries and grouping -----------------------

# The function 'summary()' gives basic information of all the columns
# of a dataset.
# We can create our own summaries with 'summarise()'.
tobit |>
  summarise(mean(read), mean(math))
  
# Summaries can be named using =
tobit |>
  summarise("mean of read" = mean(read),
            "s.d. of read" = sd(read))

# Often, summaries are combined with grouping.
# This creates summaries for each group.
tobit |>
  group_by(prog) |>
  summarise("mean of read" = mean(read),
            "s.d. of read" = sd(read))

# Try it yourself! Create the mean, median, min and max of the 'apt' column,
# grouped by programme.

# tobit |> [ YOUR CODE HERE ]

# Statistical analyses --------------------------

# All the basic tests and analyses are implemented in native (base) R, and
# by loading extra packages, almost every imaginable analysis is available.

# The aptitudes of two programmes can be compared using a t-test.
# First we need a filtered dataset 'tobit_acvoc' with only the
# academic and vocational programmes.
# You now have the skills to do it yourself, so go ahead!

# tobit_acvoc [ YOUR CODE HERE ] 

# Then we can run the t-test
t.test(apt ~ prog, data = tobit_acvoc)

# We can also compare all programmes using an analysis of variance.
aov(apt ~ prog, data = tobit)

# To get the F-value, we use summary() on the result:
aov(apt ~ prog, data = tobit) |>
  summary()

# Correlation tables are produced with 'cor()'.
tobit |>
  select(read, math, apt) |>
  cor()

# A simple linear regression is fitted with 'lm()'.
# Again, we need to use summary() on the result to see the t value.
lm(apt ~ math, data = tobit) |>
  summary()

# We can also compare high aptitude across programmes using a chi-squared test.
# First, we create a new dataset from tobit by adding a column 'pass'
# to indicate whether the aptitude is above 600.
tobit_pass <- tobit |>
  mutate(pass = (apt >= 600))

# Inspect the new column in the tobit_pass dataset.

# Then we can cross-tabulate passing aptitudes across programmes and
# conduct the chi-squared test.
table(tobit_pass$prog, tobit_pass$pass)
chisq.test(tobit_pass$prog, tobit_pass$pass)

# TASK -----------------------------------------

# 1. Using the irit dataset, investigate the linear relationship between
# the lengths and widths of petals of the species Iris virginica.
library(tidyverse)

iris |> 
  dplyr::select(
    length = Petal.Length,
    width = Petal.Width,
    species = Species
  ) |> 
  filter(
    species == "virginica"
  ) |> 
  ggplot2::ggplot(
    aes(x = length, y = width)
  ) +
  geom_point(shape = 1, size = 5) +
  labs(title = "Figure.Linear relationship of petal width and length of virginica")+
  theme_bw()+
  theme(
    axis.title = element_text(size = 15),
    plot.title = element_text(size = 16)
  )
  
  

# 2. Using the iris dataset, create an indicator variable for petal lengths
# longer than 1.5cm. Then use a chi-squared test to test the distribution
# of long-petalled flowers across different iris species.

iris.chi <- iris |> 
  mutate(
    petal.length.long = (Petal.Length> 1.5)
  ) 

table(iris.chi$Species, iris.chi$petal.length.long)

chisq.test(iris.chi$Species, iris.chi$petal.length.long)

# Plotting -------------------------------------

# In the beginning of this worksheet, we learned some "quick and dirty"
# plotting commands.
# They are useful for quickly inspecting the data.
# For reporting-quality figures, the package 'ggplot2' (part of tidyverse)
# becomes useful.

tobit |>
  ggplot(aes(x = read, y = math)) +
  geom_point() 

# The ggplot() function works by first defining the 'aesthetics',
# i.e., what x and y represent in the figure,
# and then adding different 'geometries', such as points, lines, bars etc.

# A trend line is added as a 'smooth' geometry:
tobit |>
  ggplot(aes(x = read, y = math)) +
  geom_point() +
  geom_smooth(method = "lm")

# Note that ggplot does not use the pipe symbol but '+' instead.

# Different groups can be separated using colour.
tobit |>
  ggplot(aes(x = read, y = math, colour = prog)) +
  geom_point() +
  geom_smooth(method = "lm")

# For points, also shape can be used:
tobit |>
  ggplot(aes(x = read, y = math, colour = prog)) +
  geom_point(aes(pch = prog)) +
  geom_smooth(method = "lm")

# Another option is to separate the plots.
tobit |>
  ggplot(aes(x = read, y = math)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(vars(prog))

# End of worksheet ....................................