# crossover.r
# Jack Margeson, Summer of 2019
# R script for analyzing the effect of crossover studies. Part of an internship project for Proctor & Gamble.

# Library inclusions
library(ggplot2)
library(reshape2)

#--------------- Model #1 ---------------#

# Model #1 - Normal distribution mean test
# The point of this test is to show difference in product means for Model #1 (the incorrect way)
# Tests the rnorm() function with same paramaters going to be used in data generation.
model1.df <- data.frame(A = rnorm(10000, 0), B = rnorm(10000, 3), C = rnorm(10000, 6), D = rnorm(10000, 9), E = rnorm(10000, 12), F = rnorm(10000, 15))
model1.df.melt <- melt(model1.df)
model1.plot <- ggplot(model1.df.melt, aes(x = value, fill = variable)) + 
  geom_density(alpha = 0.25)
model1.plot + labs(
  title = "The Effect of Crossover Studies",
  subtitle="Normal distribution mean test—Model #1 (the incorrect way)",
  x = "Rating", 
  y = "Density of Probability", 
  fill = "Product")

# Model #1 - Data generation
# Each vector in the list repersents a sequence.
# While there are only 6 products, each sequence contains 12 data points, as there are 2 subjects per sequence.
# Seperating subjects does not matter in Model #1, as all subjects will contribute to the same mean.
model1.data <- list()
for(i in 1:6) { # for each sequence
  model1.data[[i]] = c(rnorm(1, 0), rnorm(1, 3), rnorm(1, 6), rnorm(1, 9),  rnorm(1, 12), rnorm(1, 15), # subject 1
                       rnorm(1, 0), rnorm(1, 3), rnorm(1, 6), rnorm(1, 9),  rnorm(1, 12), rnorm(1, 15)) # subject 2
}

#--------------- Model #2 ---------------#

# Model #2 - Normal distribution mean test
# The point of this test is to show difference in product means for Model #2 (the correct way)
# Tests the rnorm() function with same paramaters going to be used in data generation.
# This test only uses two products, as Model #2 only uses 2 products.
model2.df <- data.frame(A = rnorm(10000, 0), B = rnorm(10000, 3))
model2.df.melt <- melt(model2.df)
model2.plot <- ggplot(model2.df.melt, aes(x = value, fill = variable)) + 
  geom_density(alpha = 0.25)
model2.plot + labs(
  title = "The Effect of Crossover Studies",
  subtitle="Normal distribution mean test—Model #2 (the correct way)",
  x = "Rating", 
  y = "Density of Probability", 
  fill = "Product")

# Model #2 - Data generation
# In this model, subjects are seperated into their own lists.
# This is so when processed, their A and B product values can be independently meaned before coming together.
# Each vector in these list repersents a sequence.
model2.data.subject1 <- list()
model2.data.subject2 <- list()
for(i in 1:4) { # for each product
  model2.data.subject1[[i]] = c(rnorm(1, 0), rnorm(1, 3), rnorm(1, 3), rnorm(1, 0)) # A B B A
  model2.data.subject2[[i]] = c(rnorm(1, 0), rnorm(1, 3), rnorm(1, 3), rnorm(1, 0)) # A B B A
}