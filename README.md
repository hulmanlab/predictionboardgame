# Clinical Prediction Board Game

This project provides scripts to generate materials for the clinical prediction board game.
The scripts create synthetic data, visualizing it as polygons suitable for printing.

The game involves distributing these materials to the game's participants who are then tasked to develop a prediction model using only pen and paper based on visual patterns in the data.

## Table of Contents

-   [Overview](#overview)
-   [Features](#features)
-   [Installation](#installation)
-   [Usage](#usage)
-   [Game Rules](#game-rules)
-   [Contributing](#contributing)
-   [License](#license)

## Overview

The Clinical Prediction Board Game is designed to educate participants on clinical prediction methodologies.
By working with synthetic data visualized as polygons, players can engage in hands-on learning about data analysis and prediction model development in a clinical context.

It is heavily inspired by the D3A 2.0 workshop [Applied Chemometrics – an engaging 20-minute challenge on spectral data](https://d3aconference.dk/applied-chemometrics-an-engaging-20-minute-challenge-on-spectral-data/) by [Beatriz Quintanilla Casas](https://food.ku.dk/english/staff/?pure=en/persons/768954) & [Åsmund Rinnan](https://food.ku.dk/english/staff/?pure=en/persons/310780).

## Features

-   **Synthetic Data Generation**: Create realistic yet fictional clinical datasets.
-   **Polygon Visualization**: Transform data into polygonal plots optimized for printing and manual cutting.
-   **Training and Test Sets**: Distribute data sets as physical cards to participants for fun exercises.

## Installation

To set up the project locally:

**Clone the Repository**:

Using the graphical user interface in RStudio From the toolbar: `File -> New Project -> Version Control -> Git`

and copy the git url: `https://github.com/hulmanlab/predictionboardgame.git`

Or using *bash*:
``` bash
    git clone https://github.com/hulmanlab/predictionboardgame.git
    cd predictionboardgame
```

**Installation**: Make sure to have R installed.
Run `setup.R` to check, install, and load package dependencies.

## Usage

The `main.R` orchestrates the generation of game materials in several stages.
Each section of the script focuses on a specific task, as outlined below:

1.  **Setup**:

    If you have the `here` [package](https://cran.r-project.org/package=here) installed, you can run the setup directly from `main.R`:

    ``` r
    source(here::here("R", "setup.R"))
    ```

2.  **Create Clinical Data**:

    Synthetic clinical data is generated by sourcing the `create_clinical_data.R` script:

    ``` r
    source(here::here("R", "create_clinical_data.R"))
    ```

3.  **Convert the data to polygons**:

    The clinical data is transformed into polygon representations using the `data_to_polygons.R` script:

    ``` r
    source(here::here("R", "data_to_polygons.R"))
    ```

4.  **Inspect Data Distributions**:

    Data distributions are inspected for quality using the `inspect_data.R` script:

    ``` r
    source(here::here("R", "inspect_data.R"))
    ```

5.  **Plot Game Cards**:

    Polygon plots representing the game cards are created using the `plot_cards.R` script.

    ``` r
    source(here::here("R", "plot_cards.R"))
    ```

6.  **Plot Legends for the Game**:

    Legends that help participants interpret the game cards are generated using the `plot_legend_sheet.R` script: 
    
    ``` r
    source(here::here("R", "plot_legend_sheet.R"))
    ```

7.  **Plot Teasers for Advertising the Game:**:

    Teaser images for promotional purposes are created with the plot_teasers.R script:
    
    ``` r
    source(here::here("R", "plot_teasers.R"))
    ```

### Prepare Game Materials:

-   Print the image files `cards.png` and `legends.png` in the `materials` folder on at least A4 size paper, preferably thick printing paper or cardboard.
    -   Print one copy per participant group and a copy for your own use. A few additional copies are recommended as backups, as the cards are easily lost.
    -   For each copy, cut out each panel in `cards.png` and stack them into training sets (labelled "C", "W", and "N" depending on the outcome) and test sets (labelled "T").
-   Advertise the game to attract participants. You can use the teaser plots or the poster in the `materials` folder.
-   Bring pen and paper (and prizes, everybody loves prizes) to distribute to the participants.
-   Present the game setting and the rules to the participants. You can also use the slide show in the `materials` folder.

## Game Rules

**WIP**

First, the a training set is distributed and used for model development, and the participant's models are then validated on a held-out test set in order to declare the winner.
Each card corresponds to a unique dataset entry and is designed to be visually distinct, ensuring variety in the game..

## Contributing

Contributions to enhance the game and its materials are welcome.
To contribute:

1. Fork the repository.
2. Create a new branch.
3. Commit your changes.
4. Push to the branch.
5. Open a Pull Request.

## License

This project is licensed under the MIT License.
See the LICENSE file for details.
