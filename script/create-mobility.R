MOBILITY_RDA <- here::here("data/mobility.rda")
DATA_DIR <- dirname(MOBILITY_RDA)

if (!dir.exists(DATA_DIR)) {
  message("Creating data directory.")
  dir.create(DATA_DIR)
}

MOBILITY_CSV <- list.files(here::here("data-raw"), pattern = "*.csv", full.names = TRUE)

if (!file.exists(MOBILITY_RDA)) {
  message("Reading CSV files.")
  mobility <- readr::read_csv(MOBILITY_CSV, show_col_types = FALSE)
  message("Renaming columns.")
  mobility <- mobility %>%
    select(
      iso_3166_1 = country_region_code,
      iso_3166_2 = iso_3166_2_code,
      country = country_region,
      region = sub_region_1,
      sub_region = sub_region_2,
      metro = metro_area,
      census_fips = census_fips_code,
      everything(),
      -place_id
    ) %>%
    rename_at(
      vars(ends_with("from_baseline")),
      function(n) sub("_percent_change_from_baseline", "", n)
    )
  message("Updating ", MOBILITY_RDA, ".")
  save(mobility, file = MOBILITY_RDA)
}
