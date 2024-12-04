#### Preamble ####
# Purpose: clean dataset of TTC bus delay
# Author: Chendong Fei
# Date: 21 November 2024
# Contact: chendong.fei@utoronto.ca 
# License: MIT

# Load necessary libraries
library(tidyverse)
library(dplyr)
library(readr)

# Load the dataset as a data frame
data <- read_csv("data/01-raw_data/ttc-bus-delay-data-2024.csv", show_col_types = FALSE)

# Convert 'Min Delay' and 'Min Gap' to numeric
data <- data %>%
  mutate(
    `Min Delay` = as.numeric(`Min Delay`),
    `Min Gap` = as.numeric(`Min Gap`)
  )

# Create the target variable 'delay' (1 if delay > 0, else 0)
data <- data %>%
  mutate(
    delay = ifelse(`Min Delay` > 0, 1, 0)
  )

data <- data %>%
  dplyr::select(-`Min Delay`, -`Min Gap`,-Location)

data <- data %>%
  mutate(
    Direction = ifelse(Direction %in% c("N", "S", "W", "E"), Direction, NA)  # Keep only valid values
)


# Save the cleaned data in both CSV and Parquet formats
write.csv(data, "data/02-analysis_data/analysis_data.csv", row.names = FALSE)
write_parquet(data, "data/02-analysis_data/analysis_data.parquet")



