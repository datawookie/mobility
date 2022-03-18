# Google Mobility Data

<!-- badges: start -->
[![R-CMD-check](https://github.com/datawookie/mobility/workflows/R-CMD-check/badge.svg)](https://github.com/datawookie/mobility/actions)
<!-- badges: end -->

R package with [Google Mobility data](https://www.google.com/covid19/mobility/).

The data are updated daily. To get the most recent data, simply reinstall the package.

## Install

```
remotes::install_github("datawookie/mobility")
```

## Use

```
library(mobility)

head(mobility)
```

All values represent percentage change relative to a baseline.
