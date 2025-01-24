# Legends: Set up separate plots of legends ----------------------------------------

# Quick-and-dirty correction factor to make polygon size of legends similar to card sizes

legend_correction_factor <- 0.8


## Shapes  ---------------------------------------------------------------

shape_legend_data <- data.frame(
  physical_activity = 3:10,
  # Range of shapes (number of sides)
  diabetes_duration = 5,
  # Fixed size for demonstration
  hba1c_level = 70,
  # Arbitrary color value for uniform color
  x = rep(0, 8),
  # x-position for polygons
  y = rep(0, 8),
  # y-position for polygons
  shape = as.factor(3:10)             # Unique ID for each shape
)

# Function to generate polygon points
generate_polygon_points <- function(sides, radius) {
  angles <- seq(0, 2 * pi, length.out = sides + 1)
  data.frame(x = radius * cos(angles),
             y = radius * sin(angles),
             Shape = sides)
}

# Create polygons data frame with points for each shape (from 3 to 10 sides)
polygons_shapes <- do.call(rbind, lapply(3:10, function(sides) {
  polygon <- generate_polygon_points(sides, radius = 5)
  polygon$Shape <- sides
  polygon
}))

# Plot shape legend with facet wrap by 'id'
shape_legend_plot <- ggplot(polygons_shapes, aes(x, y, group = Shape)) +
  geom_polygon(fill = "gray70", color = "black") +
  facet_wrap( ~ Shape, labeller = label_both, ncol = 1) +  # Display the number of sides in each facet
  labs(title = "Shape: Physical activity") +
  coord_fixed(
    xlim = c(-14, 14) * legend_correction_factor,
    ylim = c(-14, 14) * legend_correction_factor
  ) +
  theme_void() +
  theme(
    panel.border = element_rect(
      color = "black",
      fill = NA,
      linewidth = 0.1
    ),
    # Border around panels
    strip.background = element_rect(
      color = "black",
      fill = "lightgray",
      linewidth = 0.1
    ),
    # Border and background for facet labels
    strip.placement = "outside"#, # Ensure labels are placed outside the plot panels
  ) +
  theme(strip.text = element_text(face = "bold", size = 12),
        plot.title = element_text(hjust = 0.5))  # Bold facet labels for clarity

## Size ------------------------------------------------------------------

# Create data for size legend with a fixed shape (5 sides) and sizes ranging from 2 to 12
size_legend_data <- data.frame(
  physical_activity = 5,
  # Fixed shape (5 sides)
  diabetes_duration = round(seq(2, 12, , 8), 0),
  # Range of sizes for demonstration
  hba1c_level = 70,
  # Arbitrary color value for uniform color
  x = rep(0, 8),
  # x-position for polygons
  y = rep(0, 8),
  # y-position for polygons
  id = as.factor(round(seq(2, 12, , 8), 0))             # Unique ID for each size
)

# Function to generate polygon points for a given size
generate_polygon_points <- function(sides, radius) {
  angles <- seq(0, 2 * pi, length.out = sides + 1)
  data.frame(x = radius * cos(angles),
             y = radius * sin(angles),
             size = radius)
}

# Create polygons data frame with points for each size from 2 to 12, with fixed shape of 5 sides
polygons_sizes <- do.call(rbind, lapply(round(seq(2, 12, , 8), 0), function(size) {
  polygon <- generate_polygon_points(sides = 5, radius = size)
  polygon$Size <- size
  polygon
}))

# Plot size legend with facet wrap by 'id'
size_legend_plot <- ggplot(polygons_sizes, aes(x, y, group = Size)) +
  geom_polygon(fill = "gray70", color = "black") +
  facet_wrap( ~ Size, labeller = label_both, ncol = 1) +  # Display the size in each facet
  coord_fixed(
    xlim = c(-14, 14) * legend_correction_factor,
    ylim = c(-14, 14) * legend_correction_factor
  ) +
  labs(title = "Size: Diabetes duration") +
  theme_void() +
  theme(
    panel.border = element_rect(
      color = "black",
      fill = NA,
      linewidth = 0.1
    ),
    # Border around panels
    strip.background = element_rect(
      color = "black",
      fill = "lightgray",
      linewidth = 0.1
    ),
    # Border and background for facet labels
    strip.placement = "outside"#, # Ensure labels are placed outside the plot panels
  ) +
  theme(strip.text = element_text(face = "bold", size = 12),
        plot.title = element_text(hjust = 0.5))  # Bold facet labels for clarity


## HbA1c -----------------------------------------------------------------

suppressWarnings(hba1c_legend_grob <- cowplot::get_legend(
  all_polygons + labs(fill = "HbA1c [mmol/mol]") + theme(
    legend.key.height = unit(2, "cm"),
    legend.title = element_text(face = "bold", size = 12, hjust = 0.5)
  )
))


# Plot legends --------------------------------------------------------


hba1c_legend_plot <- ggplotify::as.ggplot(hba1c_legend_grob)

ggsave(
  here::here("materials","legends.png"),
  (shape_legend_plot | hba1c_legend_plot | size_legend_plot),
  dpi = 600,
  create.dir = TRUE,
  device = "png",
  width = 18,
  height = 26,
  units = "cm"
)
