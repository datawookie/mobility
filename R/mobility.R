#' @import dplyr
#' @import tidyr
#' @import purrr
NULL

EXTDATA_DIR <- system.file("extdata", package = "mobility")

mobility_region <- function(region) {
  PATHS <- file.path(EXTDATA_DIR, paste0("*_", region, "_Region_Mobility_Report.csv"))

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
    nest(data = date:last_col()) %>%
    mutate(
      data = map(
        data,
        function(df) {
          df %>%
            pivot_longer(
              cols = -date,
              names_to = "place",
              values_to = "change"
            ) %>%
            mutate(
              place = sub("and", "&", gsub("_", " ", place)),
              place = factor(place)
            )
        }
      )
    ) %>%
    identity()
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
    message("Hang tight... reading lots of data.")
    map_dfr(regions, mobility_region)
  } else {
    if (!(region %in% regions)) stop("Invalid region.", call. = FALSE)

    mobility_region(region)
  }
}
