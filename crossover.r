# crossover.r
# Jack Margeson, Summer of 2019
# R script for analyzing the effect of crossover studies. Part of an internship project for Proctor & Gamble.

# Library inclusions
library(ggplot2) # Graphic generator
library(reshape2) # Melt data for plot
library(readxl) # Import dataset from Excel
library(nmle) # Mixed models in R

#--------------- Both Models ---------------#

# Normal distribution mean test
# The point of this test is to show visually the 
# Tests the rnorm() function with same paramaters going to be used in data generation.
model.df <- data.frame(Products = rnorm(10000, 2.883, 0.34))
model.df.melt <- melt(model.df)
model.plot <- ggplot(model.df.melt, aes(x = value, fill = variable)) + 
  geom_density(
    alpha = 0.25) +
  geom_vline(aes(xintercept=2.883),
             color="black", linetype="dashed", size=1)
model.plot + labs(
  title = "The Effect of Crossover Studies",
  subtitle="Normal distribution mean test, visual model",
  x = "Rating", 
  y = "Density of Probability", 
  fill = "")

#--------------- Model #1 ---------------#

# Model #1 - Data generation
# Each sequence 1-6 is assigned 3 subjects.
# Each subject undergoes 6 treatments in total, across 6 periods.
# 108 random data values are generated here from the normal model for use in data generation.
# Since we're looking for a baseline, all products (A-F) pull from the same normal distribution.
# model1.data <- rnorm(108, 2.883, 0.34)
model1.data <- read_excel("./model1_data.xlsx")
# Linear mixed model in R.
# Using package NLME, the lme function fits a linear mixed-effects model while allowing for nested random effects.
# We can use the following line to generate a lme model for us with subjects as our random effect.
# Noted: treatement and period added as fix effect covariates.
model1.lme <- lme(Plaque ~ Treatment + Period, random=~1|Subject, data=model1.data)
summary(model1.lme)
# Gets the baseline of overal treatment means.
model1.lme.baseline <- Reduce(`+`, model1.lme[["coefficients"]][["fixed"]]) / 6

#--------------- Model #2 ---------------#

# Model #2 - Data generation
# Each sequence 1-4 is assigned 3 subjects.
# Each subject undergoes 4 treatments in total, across 4 periods with washout periods.
# 48 random data values are generated here from the normal model for use in data generation.
# Since we're looking for a baseline, all products (A & B) pull from the same normal distribution.
# model2.data <- rnorm(48, 2.883, 0.34)
model2.data <- read_excel("./model2_data.xlsx")
