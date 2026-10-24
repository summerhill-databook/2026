# Load libraries
library(dplyr)
library(tidyr)
library(readr)

# Read table builder data
tb_age5m <- read_delim(here::here("data/raw-data/tablebuilder/summerhill_sa1_age5_sex.csv"),
                        delim = ",", skip = 11, n_max = 61844) |>
  filter(Total !=0) |>
  select(-`...24`) |>
  rename(sa1_code_2021 = `AGE5P Age in Five Year Groups`) |>
  mutate(
    across(
      -sa1_code_2021,
      as.numeric
    )) |>
  rename_with(
    ~ paste0("m_", .x),
    -sa1_code_2021
  )


tb_age5f <- read_delim(here::here("data/raw-data/tablebuilder/summerhill_sa1_age5_sex.csv"),
                              delim = ",", skip = 61861, n_max = 61844) |>
  filter(Total !=0) |>
  select(-`...24`) |>
  rename(sa1_code_2021 = `AGE5P Age in Five Year Groups`)  |>
  mutate(
    across(
      -sa1_code_2021,
      as.numeric
    )) |>
  rename_with(
    ~ paste0("f_", .x),
    -sa1_code_2021
  )

tb_age5 <- left_join(tb_age5m, tb_age5f, by = "sa1_code_2021") |>
  mutate(
    Total = f_Total + m_Total,
    Y15to24 = `m_15-19 years` + `m_20-24 years` + `f_15-19 years` + `f_20-24 years`,
    Y60plus =
      `m_60-64 years` + `m_65-69 years` +`m_70-74 years` + `m_75-79 years` +
      `m_80-84 years` + `m_85-89 years` + `m_90-94 years` + `m_95-99 years` + `m_100 years and over` +
      `f_60-64 years` + `f_65-69 years` +`f_70-74 years` + `f_75-79 years` +
      `f_80-84 years` + `f_85-89 years` + `f_90-94 years` + `f_95-99 years` + `f_100 years and over`)

save(tb_age5, file = here::here("data/clean-data/tablebuilder/tb_age5.Rda"))


