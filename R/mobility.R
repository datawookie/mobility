#' @import dplyr
NULL

EXTDATA_DIR <- system.file("extdata/", package = "mobility")

#' Retrieve mobility data for a region
#'
#' @param region Two character country ISO code. If \code{NULL} then select all regions.
#'
#' @return
#' @export
#'
#' @examples
#' # Get mobility data for South Africa.
#' mobility("ZA")
#' # Get all mobility data.
#' mobility()
mobility <- function(region = NULL) {
  if (is.null(region)) {
    region = "??"
  } else {
    if (!(region %in% regions)) stop("Invalid region.", call. = FALSE)
  }

  PATHS <- paste0(EXTDATA_DIR, "*_", region, "_Region_Mobility_Report.csv")

  readr::read_csv(Sys.glob(PATHS), show_col_types = FALSE) %>%
    select(
      iso_country = country_region_code,
      iso_region = iso_3166_2_code,
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
}
