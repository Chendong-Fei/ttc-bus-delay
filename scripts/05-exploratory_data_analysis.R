#### Preamble ####
# Purpose:Performs exploratory data analysis on the analysis dataset.
# Author: Chendong Fei
# Date: 23 November 2024 
# Contact: chendong.fei@utoronto.ca 
# License: MIT

#### Workspace setup ####
library(tidyverse)
# Fit a logistic regression model
logit_model <- glm(delay ~ Day + Incident + Direction, 
                   data = data, 
                   family = "binomial")

# Extract coefficients and confidence intervals
coefficients_df <- tidy(logit_model, conf.int = TRUE)

# Exclude intercept for cleaner visualization
coefficients_df <- coefficients_df %>% filter(term != "(Intercept)")

# Plot coefficients with confidence intervals
ggplot(coefficients_df, aes(x = estimate, y = term)) +
  geom_point(size = 3) +  # Adjust point size for better visibility
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0.3, size = 0.7) +  # Adjust error bar height and size
  labs(
    title = "",
    x = "Coefficient Estimate",
    y = "Predictor"
  ) +
  theme_minimal() +
  theme(
    axis.text.y = element_text(size = 6),  # Adjust y-axis text size
    axis.title.y = element_text(size = 8),  # Adjust y-axis label size
    axis.title.x = element_text(size = 8),  # Adjust x-axis label size
    axis.text.x = element_text(size = 10),  # Adjust x-axis text size
    plot.title = element_text(size = 16, face = "bold"),  # Adjust title font size and style
    plot.margin = margin(10, 10, 10, 10, "pt")  # Add consistent margins for spacing

  ) 
    


