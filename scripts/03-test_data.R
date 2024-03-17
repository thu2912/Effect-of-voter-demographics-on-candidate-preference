#### Preamble ####
# Purpose: Tests... [...UPDATE THIS...]
# Author: Thu Dong
# Date: 11 March 2024
# Contact: thu.dong@mail.utoronto.ca
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
#### Test data ####
# check if gender is type character 
simulated_data$gender |> class() == "character"
# check if education is type character 
simulated_data$education |> class() == "character"
# check if vote_for is type character 
simulated_data$vote_for |> class() == "character"
# 

