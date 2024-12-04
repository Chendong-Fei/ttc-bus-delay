#### Preamble ####
# Purpose: Downloads and saves the data from opentoronto as a parquet
# Author: Chendong Fei
# Date: 21 November 2024
# Contact: chendong.fei@mail.utoronto.ca 
# License: MIT
# data from https://open.toronto.ca/ 


#### Workspace setup ####
library(opendatatoronto)
library(readxl)
library(dplyr)
library(janitor)
library(arrow)

#### Download data ####
the_raw_data <- read_excel("data/01-raw_data/ttc-bus-delay-data-2024.xlsx", sheet = 1,guess_max = 10000)


#### Save data ####
write.csv(the_raw_data,"data/01-raw_data/ttc-bus-delay-data-2024.csv",row.names = FALSE)
write_parquet(the_raw_data, "data/01-raw_data/ttc-bus-delay-data-2024.parquet") 

         
