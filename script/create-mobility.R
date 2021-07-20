MOBILITY_RDA <- here::here("data/mobility.rda")
dir.create(dirname(MOBILITY_RDA))

if (!file.exists(MOBILITY_RDA)) {
  message("Updating ", MOBILITY_RDA, ".")
  mobility <- purrr::map_dfr(
    list.files(here::here("data-raw"), pattern = "*.csv", full.names = TRUE),
    function(path) {
      read.csv(path)
    }
  )
  save(mobility, file = MOBILITY_RDA)
}
