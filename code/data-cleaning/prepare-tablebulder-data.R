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


## Language data

# Read table builder data
tb_language <- read_delim(here::here("data/raw-data/tablebuilder/summerhill_sa1_language.csv"),
                       delim = ",", skip = 10, n_max = 61844) |>
  filter(Total !=0) |>
  filter(`ENGLP Proficiency in Spoken English` != "SA1 (EN)") |>
  select(-`...11`) |>
  rename(sa1_code_2021 = `ENGLP Proficiency in Spoken English`) |>
  mutate(
    count = rowSums(across(starts_with("Uses other language")), na.rm = TRUE),
    pct = count / Total
    )

save(tb_language, file = here::here("data/clean-data/tablebuilder/tb_language.Rda"))


## Birthplace data

# Read table builder data
tb_birthplace <- read_delim(here::here("data/raw-data/tablebuilder/summerhill_sa1_birthplace.csv"),
                          delim = ",", skip = 10, n_max = 61844) |>
  filter(Total !=0) |>
  filter(`2-digit level BPLP Country of Birth of Person` != "SA1 (EN)") |>
  select(-`...42`) |>
  rename(sa1_code_2021 = `2-digit level BPLP Country of Birth of Person`) |>
  mutate(
    count = Total - `Australia (includes External Territories)`,
    pct = count / Total
  )

save(tb_birthplace, file = here::here("data/clean-data/tablebuilder/tb_birthplace.Rda"))


## Birthplace data

# Religion data
tb_religion <- read_delim(here::here("data/raw-data/tablebuilder/summerhill_sa1_religion.csv"),
                            delim = ",", skip = 10, n_max = 61844) |>
  filter(Total !=0) |>
  filter(`1-digit level RELP Religious Affiliation` != "SA1 (EN)") |>
  select(-`...13`) |>
  rename(sa1_code_2021 = `1-digit level RELP Religious Affiliation`) |>
  mutate(
    secular_pct = `Secular Beliefs and Other Spiritual Beliefs and No Religious Affiliation` / Total,
    christian_pct = Christianity / Total,
    islam_pct = Islam / Total,
    hindu_pct = Hinduism / Total
  )

save(tb_religion, file = here::here("data/clean-data/tablebuilder/tb_religion.Rda"))



