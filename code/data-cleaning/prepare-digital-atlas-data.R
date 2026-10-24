# https://digital.atlas.gov.au/datasets/62bcc02b4fa0445594ec13c7b82d480f_0/explore?location=-26.441330%2C132.407495%2C3S


# Data and resources
source(here::here("data/clean-data/constants.R")) # Constants

# Load libraries
library(readr)
library(dplyr)

da_housing_sa1 <- read_csv(here::here("data/raw-data/digital-atlas/ABS_2021_Census_G37_SA1_-5794947349380632747.csv")) |>
  rename(
    "sa1_code_2021" = "Statistical Areas Level 1 2021 code",
    "sa2_code_2021" = "Statistical Areas Level 2 2021 code",
    "sa2_name_2021" = "Statistical Areas Level 2 2021 name") |>
  filter(sa1_code_2021 %in% sa1_summerhill) |>
  mutate(
    owned_percent = `Owned: outright: Total` / `Total: Total`,
    mortgage_percent = `Owned: with a mortgage: Total` / `Total: Total`,
    rent_percent = `Rented: Total: Total` / `Total: Total`,
  )

save(da_housing_sa1, file = here::here("data/clean-data/digital-atlas/da_housing_sa1.Rda"))
