# Script to create clinical data ----------------------------------------------------------


# Set seed for reproducibility and distribution fine-tuning
set.seed(12345)

# Generate random names:
male_names <- randomNames::randomNames(
  48,
  gender = 0,
  which = "first",
  sample.with.replacement = FALSE,
  ethnicity = "White"
)
female_names <- randomNames::randomNames(
  48,
  gender = 1,
  which = "first",
  sample.with.replacement = FALSE,
  ethnicity = "White"
)

# Create initial data frame with clinical feature names for variables
data <- data.frame(
  physical_activity = sample(3:8, 48, replace = TRUE),
  # Number of sides, representing physical activity
  diabetes_duration = runif(48, 2, 9),
  # Duration of diabetes in years, used for polygon size
  hba1c_level = runif(48, 43, 98),
  # Continuous variable for HbA1c level, for color gradient
  gender = sample(c("Male", "Female"), 48, replace = TRUE),
  # Binary variable for gender
  outcome = factor(rep(
    c("No complications/weight gain", "Complications", "Weight gain"),
    ,
    48
  )),
  male_name = male_names,
  female_name = female_names
)

# Adjust each variable based on outcome group
data <- data %>%
  group_by(outcome) %>%
  mutate(
    # Physical activity adjustments
    physical_activity = case_when(
      outcome == "No complications/weight gain" ~ sample(5:8, n(), replace = TRUE),
      # Higher activity levels
      outcome == "Weight gain" ~ sample(4:7, n(), replace = TRUE),
      # Moderate levels
      outcome == "Complications" ~ sample(3:6, n(), replace = TRUE)             # Lower activity levels
    ),

    # Diabetes duration adjustments
    diabetes_duration = round(
      case_when(
        outcome == "No complications/weight gain" ~ runif(n(), 2, 6),
        # Shorter duration
        outcome == "Weight gain" ~ runif(n(), 3, 8),
        # Slightly longer duration
        outcome == "Complications" ~ runif(n(), 4, 10)                  # Longer duration
      ),
      1
    ),

    # HbA1c level adjustments
    hba1c_level = round(
      case_when(
        outcome == "No complications/weight gain" ~ runif(n(), 43, 63),
        # Lower HbA1c range
        outcome == "Weight gain" ~ runif(n(), 48, 78),
        # Moderate HbA1c levels
        outcome == "Complications" ~ runif(n(), 53, 83)                 # Higher HbA1c levels
      ),
      1
    ),

    # Gender adjustments
    gender = case_when(
      outcome == "No complications/weight gain" ~ sample(
        c("Male", "Female"),
        n(),
        replace = TRUE,
        prob = c(0.5, 0.5)
      ),
      outcome == "Weight gain" ~ sample(
        c("Male", "Female"),
        n(),
        replace = TRUE,
        prob = c(0.3, 0.7)
      ),
      # Higher proportion of females
      outcome == "Complications" ~ sample(
        c("Male", "Female"),
        n(),
        replace = TRUE,
        prob = c(0.7, 0.3)
      ) # Higher proportion of males
    )
  ) %>%
  ungroup() %>%  # Remove grouping to revert to a standard data frame
  mutate(name = ifelse(gender == "Female", female_name, male_name)) %>%
  select(c(
    name,
    gender,
    diabetes_duration,
    hba1c_level,
    physical_activity,
    outcome
  ))
