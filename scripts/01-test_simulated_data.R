#### Preamble ####
# Purpose: Tests the structure and validity of the simulated ttc bus delay dataset.
# Author: Chendong Fei
# Date: 23 November 2024
# Contact: chendong.fei@utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run


#### Workspace setup ####
library(tidyverse)

# Load the simulated data
simulated_data <- read.csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has 50,000 rows (or adjust based on your simulation settings)
if (nrow(simulated_data) == 50000) {
  message("Test Passed: The dataset has 50,000 rows.")
} else {
  stop("Test Failed: The dataset does not have 50,000 rows.")
}

# Check if the dataset has 9 columns
if (ncol(simulated_data) == 9) {
  message("Test Passed: The dataset has 9 columns.")
} else {
  stop("Test Failed: The dataset does not have 9 columns.")
}

# Check if all values in the 'Date' column are valid dates
if (all(!is.na(as.Date(simulated_data$Date, format = "%Y-%m-%d")))) {
  message("Test Passed: All values in 'Date' are valid dates.")
} else {
  stop("Test Failed: The 'Date' column contains invalid dates.")
}

# Check if the 'Day' column contains only valid day names
valid_days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")

if (all(simulated_data$Day %in% valid_days)) {
  message("Test Passed: The 'Day' column contains only valid day names.")
} else {
  stop("Test Failed: The 'Day' column contains invalid day names.")
}

# Check if the 'Route' column contains only positive integers
if (all(simulated_data$Route > 0 & simulated_data$Route == as.integer(simulated_data$Route))) {
  message("Test Passed: The 'Route' column contains only positive integers.")
} else {
  stop("Test Failed: The 'Route' column contains invalid values.")
}

# Check if the 'Time' column contains valid time formats
if (all(grepl("^\\d{2}:\\d{2}:\\d{2}$", simulated_data$Time))) {
  message("Test Passed: The 'Time' column contains valid time formats.")
} else {
  stop("Test Failed: The 'Time' column contains invalid time formats.")
}

# Check if the 'Incident' column contains only valid incident types
valid_incidents <- c("Mechanical", "Security", "Vision", "General Delay")

if (all(simulated_data$Incident %in% valid_incidents)) {
  message("Test Passed: The 'Incident' column contains only valid incident types.")
} else {
  stop("Test Failed: The 'Incident' column contains invalid incident types.")
}

# Check if the 'Direction' column contains only valid directions
valid_directions <- c("N", "S", "E", "W")

if (all(simulated_data$Direction %in% valid_directions)) {
  message("Test Passed: The 'Direction' column contains only valid directions.")
} else {
  stop("Test Failed: The 'Direction' column contains invalid directions.")
}

# Check if the 'Vehicle' column contains only positive integers
if (all(simulated_data$Vehicle > 0 & simulated_data$Vehicle == as.integer(simulated_data$Vehicle))) {
  message("Test Passed: The 'Vehicle' column contains only positive integers.")
} else {
  stop("Test Failed: The 'Vehicle' column contains invalid values.")
}

# Check if the 'Delay' column contains only 0s and 1s
if (all(simulated_data$Delay %in% c(0, 1))) {
  message("Test Passed: The 'Delay' column contains only 0s and 1s.")
} else {
  stop("Test Failed: The 'Delay' column contains invalid values.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(simulated_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if there are no empty strings in 'Location', 'Incident', and 'Direction' columns
if (all(simulated_data$Location != "" & simulated_data$Incident != "" & simulated_data$Direction != "")) {
  message("Test Passed: There are no empty strings in 'Location', 'Incident', or 'Direction'.")
} else {
  stop("Test Failed: There are empty strings in one or more columns.")
}

# Check if the 'Incident' column has at least two unique values
if (n_distinct(simulated_data$Incident) >= 2) {
  message("Test Passed: The 'Incident' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'Incident' column contains less than two unique values.")
}
