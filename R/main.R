# Install and load dependencies -------------------------------------------
source(here::here("R", "setup.R"))


# Create clinical data ----------------------------------------------------
source(here::here("R", "create_clinical_data.R"))


# Convert it to polygons --------------------------------------------------
source(here::here("R", "data_to_polygons.R"))


# Inspect data distributions ----------------------------------------------
source(here::here("R", "inspect_data.R"))


# Plot game cards ---------------------------------------------------------
source(here::here("R", "plot_cards.R"))


# Plot legends for the game -----------------------------------------------
source(here::here("R", "plot_legend_sheet.R"))


# Plot teasers for advertising the game -----------------------------------
source(here::here("R", "plot_teasers.R"))
