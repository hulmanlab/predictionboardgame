# Create polygon data -----------------------------------------------------

# Function to generate polygons with property names in the returned data frame
generate_polygon <- function(shape, size, colour, symbol, id, outcome) {
  # Create points for the polygon
  angles <- seq(0, 2 * pi, length.out = shape + 1)
  radius <- size + 2 # Scale size based on diabetes duration
  x <- radius * cos(angles)
  y <- radius * sin(angles)

  # Return as a data frame with polygon properties
  data.frame(
    x = x,
    y = y,
    shape = shape,
    size = size,
    colour = colour,
    symbol = symbol,
    id = id,
    outcome = outcome
  )
}

# Use lapply to create polygons for each row
polygons <- do.call(rbind, lapply(1:nrow(data), function(i) {
  row <- data[i, ]
  generate_polygon(
    shape = row$physical_activity,
    size = row$diabetes_duration,
    colour = row$hba1c_level,
    symbol = ifelse(row$gender == "Male", "\u2642", "\u2640"),
    id = ifelse(
      row$gender == "Male",
      paste(
        stringr::str_pad(
          string = i,
          width = 2,
          side = "left",
          pad = "0"
        ),
        male_names[i],
        sep = ". "
      ),
      paste(
        stringr::str_pad(
          string = i,
          width = 2,
          side = "left",
          pad = "0"
        ),
        female_names[i],
        sep = ". "
      )
    ),
    outcome = row$outcome
  )
}))
