#### Preamble ####
# Purpose: Tests the analysis data of TTC bus delay
# Author: Chendong Fei
# Date: 23 November 2024 
# Contact: chendong.fei@utoronto.ca 
# License: MIT


# Load necessary libraries
library(testthat)
library(dplyr)
library(arrow)

# load data
analysis_data <- read_parquet("../data/02-analysis_data/analysis_data.parquet")


#### Test Data ####

# Test 1: Ensure 'delay' column contains only 0 or 1
test_that("'delay' column contains only 0 and 1", {
  expect_true(all(analysis_data$delay %in% c(0, 1)))
})

# Test: Ensure 'Direction' column contains only valid values (S, W, N, E, or NA)
test_that("'Direction' column contains only S, W, N, E, or NA", {
  valid_directions <- c("S", "W", "N", "E", NA)  # Define valid values including NA
  invalid_directions <- analysis_data %>%
    filter(!(Direction %in% valid_directions))  # Identify invalid values
  
  expect_true(nrow(invalid_directions) == 0, 
              info = paste("Invalid values found in 'Direction':", 
                           paste(unique(invalid_directions$Direction), collapse = ", ")))
})

# Test 3: Ensure there are no NA values in the 'Incident' column
test_that("No NA values in 'Incident' column", {
  expect_true(all(!is.na(analysis_data$Incident)))
})


