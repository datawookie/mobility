library(dplyr)
library(tidyr)

DATA_DIR <- "data"
if (!dir.exists(DATA_DIR)) {
  message("Creating data directory.")
  dir.create(DATA_DIR)
}

REGIONS_RDA <- here::here(DATA_DIR, "regions.rda")

MOBILITY_CSV <- list.files(here::here("inst", "extdata"), pattern = "*.csv", full.names = TRUE)

# Extract list of region ISO codes.
#
regions <- basename(MOBILITY_CSV) %>%
  gsub("^[0-9]{4}_|_Region_Mobility_Report.csv", "", .) %>%
  unique()

save(regions, file = REGIONS_RDA)
