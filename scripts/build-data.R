mobility <- read.csv(here::here("data-raw/mobility-global.csv"))

usethis::use_data(mobility, overwrite = TRUE)
