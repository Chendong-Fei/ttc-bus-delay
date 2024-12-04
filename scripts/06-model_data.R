#### Preamble ####
# Purpose: Build a logistic model and Gradiant boosting model to prodict the delay
# Author: Chendong Fei
# Date: 23 November, 2024 
# Contact: chendong.fei@utoronto.ca 
# License: MIT


#### Read data ####
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

### Model data ####
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
  geom_point() +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high), height = 0.2) +
  labs(title = "",
       x = "Coefficient Estimate",
       y = "Predictor") +
  theme_minimal()

gbm_model <- gbm(
  formula = delay ~ Route + Time + Day + Incident + Direction,
  data = train_data,
  distribution = "bernoulli", # Binary classification
  n.trees = 100,             # Number of trees
  interaction.depth = 3,     # Depth of trees
  shrinkage = 0.01,          # Learning rate
  cv.folds = 5,              # Cross-validation folds
  verbose = FALSE
)

#### Save model ####
saveRDS(
  logit_model,
  file = "models/logit_model.rds"
)

saveRDS(
  gbm_model,
  file = "models/gbm_model.rds"
)



