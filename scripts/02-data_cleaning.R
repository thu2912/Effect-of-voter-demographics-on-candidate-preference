#### Preamble ####
# Purpose: Cleans the raw plane data downloaded directly online
# Author: Thu Dong
# Date: 11 March 2024
# Contact: thu.dong@mail.utoronto.ca
# License: MIT
# Pre-requisites:Install all packages needed


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(forcats)
library(dataverse)

#### Clean data ####
ces2020 <-
  get_dataframe_by_name(
    filename = "CES20_Common_OUTPUT_vv.csv",
    dataset = "10.7910/DVN/E9N6PH",
    server = "dataverse.harvard.edu",
    .f = read_csv
  )  |>
  select(votereg, CC20_410, gender, educ)


### clean and rename variables: 

ces2020_1 <-
  ces2020 |>
  filter(votereg == 1,
         CC20_410 %in% c(1, 2)) |>
  mutate(
    voted_for = if_else(CC20_410 == 1, "Biden", "Trump"),
    voted_for = as_factor(voted_for),
    gender = if_else(gender == 1, "Male", "Female"),
    gender = as_factor(gender),
    education = case_when(
      educ == 1 ~ "No HS",
      educ == 2 ~ "High school graduate",
      educ == 3 ~ "Some college",
      educ == 4 ~ "2-year",
      educ == 5 ~ "4-year",
      educ == 6 ~ "Post-grad"
    ),
    education = factor(
      education,
      levels = c(
        "No HS",
        "High school graduate",
        "Some college",
        "2-year",
        "4-year",
        "Post-grad"
      )
    )
    
  ) |>
  select(voted_for, gender, education)

### drop NA values 

cleaned_data <-na.omit(ces2020_1)

#### Save data ####
write.csv(cleaned_data,"~/Effect-of-voter-demographics-on-candidate-preference/data/analysis_data/analysis_data.csv")
