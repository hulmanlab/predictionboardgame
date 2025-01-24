# Check dependencies ----------------------------------------------------

# Define the list of required packages
required_packages <- c(
  "ggplot2",
  "dplyr",
  "here",
  "randomNames",
  "cowplot",
  "ggplotify",
  "finalfit",
  "patchwork"
)

# Check if any are missing
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    print(paste("You need to install this packages: ", pkg))
  } else {
    print(paste("This package was successfully detected: ", pkg))
  }
}

# Install dependencies ----------------------------------------------------

# Check if each package is installed, and install if missing
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}


# Load packages into namespace -------------------------------------------------------
library(ggplot2)
library(dplyr)
library(patchwork)
