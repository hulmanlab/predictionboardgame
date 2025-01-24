# Plot polygons -----------------------------------------------------------

# Fixed colour scale:
global_fill_range <- range(polygons$colour, na.rm = TRUE)

plot_polygons <- function(polygon_data, evaluation = "FALSE") {
  ggplot(polygon_data, aes(x, y, group = id, fill = colour)) +
    geom_polygon() +
    coord_fixed(xlim = c(-14, 14), ylim = c(-14, 14)) +
    scale_fill_gradientn(colors = c("green", "yellow", "red"),
                         limits = global_fill_range) + # Color gradient for HbA1c level
    labs(fill = "HbA1c [mmol/mol]") +
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
      strip.placement = "outside",
      # Ensure labels are placed outside the plot panels
      plot.margin = margin(10, 10, 10, 10) # Add margin for better visibility
    ) +
    facet_wrap( ~ id, nrow = 8) +
    # Add gender symbols as text overlay
    geom_text(
      aes(label = symbol),
      x = 0,
      y = 0,
      size = 4,
      color = "black"
    ) +
    # Add watermark showing facet group
    geom_text(
      aes(
        label = ifelse(id %in% unique(id)[1:10], substr(outcome, 1, 1), "T")
      ),
      x = -12,
      # Center along the x-axis
      y = -13,
      # Position it near the bottom of the y-axis range
      size = 3,
      # Adjust size
      angle = 45,
      color = "gray70",
      # Light color for watermark effect
      hjust = 0.5,
      # Center horizontally
      vjust = 0 # Bottom alignment
    ) +
    theme(strip.text = element_text(face = "bold", size = 8)) # Bold and increase font size)
}

# Plot the polygons with color gradient and overlay gender symbols as text
all_polygons <- plot_polygons(polygons)

complications_polygons <- polygons %>%  filter(outcome == "Complications") %>% plot_polygons() + theme(legend.position = "none") +
  facet_wrap(~ id, nrow = 8) + ggtitle("Complications at follow-up \n +/- Weight gain") + theme(plot.title = element_text(size = 10, face = "bold", hjust = 0.5))

obesity_polygons <- polygons %>%  filter(outcome == "Weight gain") %>% plot_polygons() + theme(legend.position = "none") +
  facet_wrap(~ id, nrow = 8) + ggtitle("Weight gain at follow-up \n No complications") + theme(plot.title = element_text(size = 10, face = "bold", hjust = 0.5))

healthy_polygons <- polygons %>%  filter(outcome == "No complications/weight gain") %>% plot_polygons() + theme(legend.position = "none") +
  facet_wrap(~ id, nrow = 8) + ggtitle("No complications \n No weight gain") + theme(plot.title = element_text(size = 10, face = "bold", hjust = 0.5))


# Plot cards  ------------------------------------------------------


ggsave(
  here::here("materials","cards.png"),
  (complications_polygons | obesity_polygons | healthy_polygons),
  dpi = 600,
  create.dir = TRUE,
  device = "png",
  width = 18,
  height = 26,
  units = "cm"
)
