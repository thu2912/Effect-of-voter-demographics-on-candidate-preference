#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(boot)
library(broom.mixed)
library(collapse)
library(dataverse)
library(gutenbergr)
library(janitor)
library(knitr)
library(marginaleffects)
library(modelsummary)
library(rstanarm)
library(tidybayes)
library(tidyverse)

#### Read data ####
analysis_data <- read.csv("~/Effect-of-voter-demographics-on-candidate-preference/data/analysis_data/analysis_data.csv")


vote_for_data <- analysis_data |> 
  mutate(
    voted_for = if_else(voted_for == "Biden",1, 0))
### Model data ####
set.seed(853)

ces2020_reduced <- 
  vote_for_data |> 
  slice_sample(n = 1000)

political_preferences <-
  stan_glm(
    voted_for ~ gender * education,
    data = ces2020_reduced,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = 
      normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )

political_preferences_genders <-
  stan_glm(
    voted_for ~ gender,
    data = ces2020_reduced,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = 
      normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 300
  )

#### Save model ####
saveRDS(
  political_preferences_genders,
  file = "~/Effect-of-voter-demographics-on-candidate-preference/models/political_preferences_genders.rds"
)

saveRDS(
  political_preferences,
  file = "~/Effect-of-voter-demographics-on-candidate-preference/models/political_preferences.rds"
)



