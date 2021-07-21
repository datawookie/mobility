MOBILITY_RDA <- here::here("data/mobility.rda")
DATA_DIR <- dirname(MOBILITY_RDA)

if (!dir.exists(DATA_DIR)) {
  message("Creating data directory.")
  dir.create(DATA_DIR)
}

MOBILITY_CSV <- list.files(here::here("data-raw"), pattern = "*.csv", full.names = TRUE)

if (!file.exists(MOBILITY_RDA)) {
  message("Reading CSV files.")
  mobility <- readr::read_csv(MOBILITY_CSV)
  message("Updating ", MOBILITY_RDA, ".")
  save(mobility, file = MOBILITY_RDA)
}
