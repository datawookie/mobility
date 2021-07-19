MOBILITY_CSV <- here::here("data-raw/mobility-global.csv")
MOBILITY_RDA <- here::here("data/mobility.rda")

if (!file.exists(MOBILITY_RDA)) {
  message("Updating ", MOBILITY_RDA, ".")
  mobility <- read.csv(MOBILITY_CSV)
  save(mobility, file = MOBILITY_RDA)
}

print(file.info(MOBILITY_CSV))
print(file.info(MOBILITY_RDA))
