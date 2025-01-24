# Check distributions -----------------------------------------------------

# View summary for each outcome

# Custom function to calculate the median and 80% percentile range
interpercentile_80_summary <- function(x) {
  quantiles <- quantile(x, probs = c(0.1, 0.9), na.rm = TRUE)
  median <- median(x, na.rm = TRUE)
  paste0(round(median, 2),
         " (",
         round(quantiles[1], 2),
         " - ",
         round(quantiles[2], 2),
         ")")
}

# Apply ff_summary_95 to each subset by outcome and summarise the continuous variables
summary_by_outcome <- data %>%
  group_by(outcome) %>%
  summarise(
    physical_activity_range = interpercentile_80_summary(physical_activity),
    diabetes_duration_range = interpercentile_80_summary(diabetes_duration),
    hba1c_level_range = interpercentile_80_summary(hba1c_level)
  ) %>%
  ungroup()

# Summaries of all :
summary(factor(data$gender))

predictors <- c("physical_activity",
                "diabetes_duration",
                "hba1c_level",
                "gender")

print("Summary of all variables (IQR)")
print(
  finalfit::summary_factorlist(
    data,
    "outcome",
    predictors,
    p = TRUE,
    cont = "median",
    add_col_totals = TRUE
  )
)

print("Summary of all continuous variables (80% interpercentile range) to inspect overlaps")
print(summary_by_outcome)
