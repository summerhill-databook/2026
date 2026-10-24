# Prepare SA1 mapping data
library(dplyr)
library(osmdata)
library(sf)

# Load constants
source(here::here("data/clean-data/constants.R"))


## SED District boundary for Summer Hill
sed_2022 <- strayr::read_absmap("sed2022") |>
  filter(sed_name_2022 == "Summer Hill")

save(sed_2022, file = here::here("data/clean-data/maps/sed_2022_geometries.Rda"))



## SA1 boundaries within Summer Hill SED
sa1_maps <- strayr::read_absmap("sa12021")
sa1_maps_sh <- sa1_maps |>
  filter(sa1_code_2021 %in% sa1_summerhill)

save(sa1_maps_sh, file = here::here("data/clean-data/maps/sa1_maps_sh_geometries.Rda"))

## SA1 boundaries within Summer Hill SED
sa2_maps <- strayr::read_absmap("sa22021")
sa2_maps_sh <- sa2_maps |>
  filter(sa2_code_2021 %in% sa2_code_summerhill)

save(sa2_maps_sh, file = here::here("data/clean-data/maps/sa2_maps_sh_geometries.Rda"))




# Goolayari/Cooks River
# cooks <- opq("Sydney, Australia") |>
#   add_osm_feature(
#     key = "waterway",
#     value = "river"
#   ) |>
#   osmdata_sf()
#
# cooks_river <- cooks$osm_lines |>
#   dplyr::filter(name == "Cooks River")




