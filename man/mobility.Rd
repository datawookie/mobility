% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mobility.R
\name{mobility}
\alias{mobility}
\title{Retrieve mobility data}
\usage{
mobility(region = NULL)
}
\arguments{
\item{region}{Two character country ISO code. If \code{NULL} then select all regions.}
}
\value{

}
\description{
Retrieve mobility data
}
\examples{
# Get mobility data for South Africa.
mobility("ZA")
# Get all mobility data.
mobility()
}
