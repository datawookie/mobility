#' @import dplyr
#' @import tidyr
#' @import purrr
NULL

EXTDATA_DIR <- system.file("extdata/", package = "mobility")

#' Helper function for retrieving mobility data for a specific region
#'
#' @param region
#'
#' @return
mobility_region <- function(region) {
  PATHS <- paste0(EXTDATA_DIR, "*_", region, "_Region_Mobility_Report.csv")

  readr::read_csv(
    Sys.glob(PATHS),
    show_col_types = FALSE,
    progress = FALSE
  ) %>%
    mutate(
      iso = coalesce(iso_3166_2_code, country_region_code)
    ) %>%
    select(
      iso,
      country = country_region,
      region = sub_region_1,
      sub_region = sub_region_2,
      metro = metro_area,
      everything(),
      -place_id, -census_fips_code, -ends_with("_code")
    ) %>%
    rename_at(
      vars(ends_with("from_baseline")),
      function(n) sub("_percent_change_from_baseline", "", n)
    ) %>%
    nest(data = date:last_col())
}
mobility_region <- memoise::memoise(mobility_region)

#' Retrieve mobility data
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
    map_dfr(regions, mobility_region)
  } else {
    if (!(region %in% regions)) stop("Invalid region.", call. = FALSE)

    mobility_region(region)
  }

}
