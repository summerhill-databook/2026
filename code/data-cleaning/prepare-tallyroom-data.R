

# Polling places
polling_places <- read.csv(here::here("data/raw-data/tallyroom/polling_places.csv"))
save(polling_places, file = here::here("data/clean-data/tallyroom/polling_places.Rda"))

# NSW State Election Results by polling place 2023
nsw_la_2023 <- readxl::read_excel(here::here("data/raw-data/tallyroom/NSW-2023-LA-Primary-PollingPlace.xlsx"))
save(nsw_la_2023, file = here::here("data/clean-data/tallyroom/nsw_la_2023.Rda"))
