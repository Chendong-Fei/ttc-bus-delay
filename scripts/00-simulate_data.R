#### Preamble ####
# Purpose: Simulates a dataset of  TTC bus delay
# Author: Chendong Fei
# Date: 21 November 2024
# Contact: chendong.fei@utoronto.ca
# License: MIT


# Load required libraries
library(dplyr)
library(lubridate)

# Set seed for reproducibility
set.seed(123)

# Simulate data
n <- 50000  # Number of records to simulate

# Generate Date: Randomly sampled from the range in the dataset
start_date <- as.Date("2024-01-01")
end_date <- as.Date("2024-12-31")
Date <- sample(seq(start_date, end_date, by = "day"), n, replace = TRUE)

# Generate Day: Based on Date
Day <- weekdays(Date)

# Simulate Route: Assuming similar distribution to the dataset
Route <- sample(c(1:59097), n, replace = TRUE, prob = dpois(1:59097, lambda = 100))

# Simulate Time: Uniformly distributed across a 24-hour period
Time <- sprintf("%02d:%02d:%02d",
                sample(0:23, n, replace = TRUE),  # Hours
                sample(0:59, n, replace = TRUE),  # Minutes
                sample(0:59, n, replace = TRUE))  # Seconds

# Simulate Location: Randomly sampled from unique locations
unique_locations <- c("KEELE AND GLENLAKE", "FINCH STATION", "BLOOR AND MANNING", "PARLIAMENT AND BLOOR", "MAIN STATION")
Location <- sample(unique_locations, n, replace = TRUE)

# Simulate Incident: Based on frequency in the dataset
unique_incidents <- c("Mechanical", "Security", "Vision", "General Delay")
Incident <- sample(unique_incidents, n, replace = TRUE, prob = c(0.3, 0.3, 0.2, 0.2))

# Simulate Direction: Randomly distributed among N, S, E, W with probabilities
Direction <- sample(c("N", "S", "E", "W"), n, replace = TRUE, prob = c(0.4, 0.3, 0.2, 0.1))

# Simulate Vehicle: Numeric, normally distributed with realistic bounds
Vehicle <- round(rnorm(n, mean = 7000, sd = 1000))
Vehicle <- ifelse(Vehicle < 1000, 1000, Vehicle)  # Ensure realistic range

# Simulate Delay: Interaction between Incident and Route
Delay <- ifelse(Incident == "Mechanical" & Route <= 200, 1, rbinom(n, 1, 0.1))

# Combine into a data frame
simulated_data <- data.frame(Date, Day, Route, Time, Location, Incident, Direction, Vehicle, Delay)

# Save or view the data
write.csv(simulated_data, "data/00-simulated_data/simulated_data.csv", row.names = FALSE)