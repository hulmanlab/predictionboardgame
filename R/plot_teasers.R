# Script to print teasers for advertising the game ------------------------------------------------------------

name_pattern <- paste(data$name[1:10], collapse = "|")

# Filter polygons by checking if `id` contains any of the first 10 names in data$name
# Or among the first 7 with known outcomes,
# Or row 8-10 with unknown outcomes:

all_teaser_polygons <- polygons %>%
  filter(stringr::str_detect(id, paste(data$name[1:10], collapse = "|"))) %>% plot_polygons() + theme(legend.position = "none") +
  facet_wrap( ~ id, ncol = 4) + ggtitle("All Individuals:") + theme(plot.title = element_text(size = 14, face = "bold", hjust = 0.5))

teaser_complications_polygons <- polygons %>%
  filter(stringr::str_detect(id, paste(data$name[1:7], collapse = "|")) &
           outcome == "Complications") %>% plot_polygons() + theme(legend.position = "none") +
  facet_wrap( ~ id, ncol = 3) + ggtitle("Complications at follow-up:") + theme(plot.title = element_text(size = 14, face = "bold", hjust = 0.5))

teaser_obesity_polygons <- polygons %>%
  filter(stringr::str_detect(id, paste(data$name[1:7], collapse = "|")) &
           outcome == "Weight gain") %>% plot_polygons() + theme(legend.position = "none") +
  facet_wrap( ~ id, ncol = 3) + ggtitle("Weight gain at follow-up:") + theme(plot.title = element_text(size = 14, face = "bold", hjust = 0.5))

teaser_healthy_polygons <- polygons %>%
  filter(stringr::str_detect(id, paste(data$name[1:7], collapse = "|")) &
           outcome == "No complications/weight gain") %>% plot_polygons() + theme(legend.position = "none") +
  facet_wrap( ~ id, ncol = 3) + ggtitle("No complications/weight gain:") + theme(plot.title = element_text(size = 14, face = "bold", hjust = 0.5))

teaser_predict_polygons <- polygons %>%
  filter(stringr::str_detect(id, paste(data$name[8:10], collapse = "|"))) %>% plot_polygons() + theme(legend.position = "none") +
  facet_wrap( ~ id, ncol = 3) + ggtitle("Predict these:") + theme(plot.title = element_text(size = 14, face = "bold", hjust = 0.5)) +
  geom_rect(
    xmin = -Inf, xmax = -12 + 2,  # Adjust dimensions as needed
    ymin = -Inf, ymax = -13 + 2, # Adjust dimensions as needed
    fill = "white", color = NA
  ) +
  # Re-draw pseuso-test watermark for these
  geom_text(
    aes(
      label = "T"
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
  )


# Plot the teaser cards ---------------------------------------------------

ggsave(
  here::here("materials", "teaser_cards.png"),
  (
    teaser_healthy_polygons / teaser_obesity_polygons / teaser_complications_polygons / teaser_predict_polygons
  ),
  dpi = 600,
  create.dir = TRUE,
  device = "png",
  width = 18,
  height = 26,
  units = "cm"
)
