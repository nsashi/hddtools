#' hddtools: Hydrological Data Discovery Tools
#'
#' @name hddtools
#' @docType package
#'
#' @description Many governmental bodies and institutions are currently committed to publish open data as the result of a trend of increasing transparency, based on which a wide variety of information produced at public expense is now becoming open and freely available to improve public involvement in the process of decision and policy making. Discovery, access and retrieval of information is, however, not always a simple task. Especially when access to data APIs is not allowed, downloading a metadata catalogue, selecting the information needed, requesting datasets, de-compression, conversion, manual filtering and parsing can become rather tedious. The R package hddtools is an open source project, designed to make all the above operations more efficient by means of reusable functions.
#'
#' The package facilitate access to various online data sources such as:
#' \itemize{
#'  \item{\strong{KGClimateClass} (\url{http://koeppen-geiger.vu-wien.ac.at/}): The Koppen Climate Classification map is used for classifying the world's climates based on the annual and monthly averages of temperature and precipitation}
#'  \item{\strong{GRDC} (\url{http://www.bafg.de/GRDC/EN/Home/homepage_node.html}): The Global Runoff Data Centre (GRDC) provides datasets for all the major rivers in the world}
#'  \item{\strong{Data60UK} (\url{http://tdwg.catchment.org/datasets.html}): The Data60UK initiative collated datasets of areal precipitation and streamflow discharge across 61 gauging sites in England and Wales (UK).}
#'  \item{\strong{MOPEX} (\url{http://tdwg.catchment.org/datasets.html}): This dataset contains historical hydrometeorological data and river basin characteristics for hundreds of river basins in the US.}
#'  \item{\strong{SEPA} (\url{http://apps.sepa.org.uk/waterlevels/}): The Scottish Environment Protection Agency (SEPA) provides river level data for hundreds of gauging stations in the UK.}}
#' This package complements R's growing functionality in environmental web technologies by bridging the gap between data providers and data consumers. It is designed to be an initial building block of scientific workflows for linking data and models in a seamless fashion.
#'
#' @references
#' Vitolo C, Buytaert W, 2014, HDDTOOLS: an R package serving Hydrological Data
#' Discovery Tools, AGU Fall Meeting, 15-19 December 2014, San Francisco, USA.
#'
#' @import rgdal
#' @importFrom graphics axis legend lines plot polygon
#' @importFrom stats window
#' @importFrom utils download.file head read.csv read.fwf read.table tail untar unzip
#' @importFrom zoo zoo merge.zoo
#' @importFrom sp CRS SpatialPolygons Polygon Polygons
#' @importFrom RCurl url.exists getURL
#' @importFrom XML readHTMLTable
#' @importFrom rnrfa catalogue
#' @importFrom Hmisc monthDays
#' @importFrom raster raster extract brick flip extent crop writeRaster extent
#' @importFrom stringr str_pad
#' @importFrom gdata read.xls
#' @importFrom utils read.table
#' @importFrom tibble as_tibble
#'
NULL

#' Data set: The SEPA Catalogue
#'
#' @description The SEPA catalogue
#'
#' @usage data("SEPAcatalogue")
#'
#' @format A data frame with 830 observations on the following 8 variables.
#' \describe{
#'   \item{\code{idNRFA}}{National River Flow Archive id number.}
#'   \item{\code{aspxpage}}{Environment Agency gauges id.}
#'   \item{\code{stationId}}{SEPA station id.}
#'   \item{\code{River}}{String describing the river's name.}
#'   \item{\code{Location}}{String describing the location.}
#'   \item{\code{GridRef}}{British National Grid Reference.}
#'   \item{\code{Operator}}{The operator's name.}
#'   \item{\code{CatchmentAreaKm2}}{Area of the catchment.}
#' }
#'
#' @keywords datasets
#'
#' @source \url{http://pennine.ddns.me.uk/riverlevels/ConciseList.html}
#'
"SEPAcatalogue"

#' Data set: The Data60UK Catalogue
#'
#' @description The Data60UK catalogue
#'
#' @usage data("Data60UKcatalogue")
#'
#' @format A data frame with 61 stations (rows) and 6 metadata fields (columns).
#' \describe{
#'   \item{\code{stationID}}{Station id number.}
#'   \item{\code{River}}{String describing the river's name.}
#'   \item{\code{Location}}{String describing the location.}
#'   \item{\code{gridReference}}{British National Grid Reference.}
#'   \item{\code{Latitude}}{}
#'   \item{\code{Longitude}}{}
#' }
#'
#' @keywords datasets
#'
#' @source \url{http://nrfaapps.ceh.ac.uk/datauk60/data.html}
"Data60UKcatalogue"

#' Data set: The MOPEX Catalogue
#'
#' @description The MOPEX catalogue
#'
#' @usage data("MOPEXcatalogue")
#'
#' @format A data frame with 431 stations (rows) and 12 metadata fields (columns).
#' \describe{
#'   \item{\code{stationID}}{Station id number.}
#'   \item{\code{longitude}}{}
#'   \item{\code{latitude}}{}
#'   \item{\code{elevation}}{}
#'   \item{\code{V5}}{}
#'   \item{\code{datestart}}{}
#'   \item{\code{dateend}}{}
#'   \item{\code{V8}}{}
#'   \item{\code{V9}}{}
#'   \item{\code{state}}{}
#'   \item{\code{V11}}{}
#'   \item{\code{basin}}{String describing the river's name.}
#' }
#'
#' @keywords datasets
#'
#' @source \url{ftp://hydrology.nws.noaa.gov/pub/gcip/mopex/US_Data/}
"MOPEXcatalogue"

#' Data set: The grdcLTMMD look-up table
#'
#' @description The grdcLTMMD look-up table
#'
#' @usage data("grdcLTMMD")
#'
#' @format A data frame with 6 rows and 4 columns.
#' \describe{
#'   \item{\code{WMO_Region}}{an integer between 1 and 6}
#'   \item{\code{Coverage}}{}
#'   \item{\code{Number_of_stations}}{}
#'   \item{\code{Archive}}{url to spreadsheet}
#' }
#'
#' @keywords datasets
#'
#' @source \url{http://www.bafg.de/GRDC}
"grdcLTMMD"

#' Data set: The GRDC Catalogue
#'
#' @description The GRDC catalogue
#'
#' @usage data("GRDCcatalogue")
#'
#' @format A data frame with 9252 stations (rows) and 46 metadata fields.
#' \describe{
#'   \item{\code{grdc_no}}{: GRDC station number}
#'   \item{\code{wmo_reg}}{: WMO region}
#'   \item{\code{sub_reg}}{: WMO subregion}
#'   \item{\code{nat_id}}{: national station ID}
#'   \item{\code{river}}{: river name}
#'   \item{\code{station}}{: station name}
#'   \item{\code{country}}{: country code (ISO 3166)}
#'   \item{\code{lat}}{: latitude, decimal degree}
#'   \item{\code{long}}{: longitude, decimal degree}
#'   \item{\code{area}}{: catchment size, km2}
#'   \item{\code{altitude}}{: height of gauge zero, m above sea level}
#'   \item{\code{ds_stat_no}}{: GRDC station number of next downstream GRDC station}
#'   \item{\code{d_start}}{: daily data available from year}
#'   \item{\code{d_end}}{: daily data available until year}
#'   \item{\code{d_yrs}}{: length of time series, daily data}
#'   \item{\code{d_miss}}{: percentage of missing values (daily data)}
#'   \item{\code{m_start}}{: monthly data available from}
#'   \item{\code{m_end}}{: monthly data available until}
#'   \item{\code{m_yrs}}{: length of time series, monthly data}
#'   \item{\code{m_miss}}{: percentage of missing values (monthly data)}
#'   \item{\code{t_start}}{: earliest data available}
#'   \item{\code{t_end}}{: latest data available}
#'   \item{\code{t_yrs}}{: maximum length of time series, daily and monthly data}
#'   \item{\code{lta_discharge}}{: mean annual streamflow, m3/s}
#'   \item{\code{r_volume_yr}}{: mean annual volume, km3}
#'   \item{\code{r_height_yr}}{: mean annual runoff depth, mm}
#' }
#'
#' @keywords datasets
#'
#' @source \url{http://www.bafg.de/GRDC/EN/02_srvcs/21_tmsrs/211_ctlgs/catalogues_node.html}
"GRDCcatalogue"
