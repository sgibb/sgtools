## Copyright 2012 Sebastian Gibb
## <mail@sebastiangibb.de>
##
## This is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## It is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## See <http://www.gnu.org/licenses/>

#' fetchArxiv
#'
#' fetches query counts from arxiv database grouped by years
#'
#' @references \url{http://arxiv.org/help/api}
#'
#' @param query character, search term e.g. "cat:stat AP AND abs:Bayes"
#' @param fromYear numeric, start year
#' @param toYear numeric, end year [default: last year]
#'
#' @return
#'  a 2-column matrix
#'      1. column: "year"
#'      2. column: "counts"
#'
#' @import RCurl XML
#' @export
#'
#' @examples
#'  bayes <- fetchArxiv("cat:stat.AP AND abs:Bayes", 2009, 2010)
#'  bayes 
#'  #        year counts
#'  #   [1,] 2009      4
#'  #   [2,] 2010     13
#'

fetchArxiv <- function(query, fromYear, 
                       toYear=as.integer(format(Sys.Date(), "%Y"))-1) {

    ## load libraries
    library("RCurl");
    library("XML");
    
    ## testing arguments
    isValidQuery <- is.character(query);
    isValidFromYear <- is.numeric(fromYear) && fromYear <= toYear;
    isValidToYear <- is.numeric(toYear) && toYear >= fromYear;

    stopifnot(isValidQuery);
    stopifnot(isValidFromYear);
    stopifnot(isValidToYear);

    years <- fromYear:toYear;
    nYears <- length(years);

    m <- matrix(c(years, rep(NA, nYears)), nrow=nYears, ncol=2,
                dimnames=list(list(), list("year", "counts")));

    message(query, ":");
    for (i in seq(along=years)) {
        message("  fetching counts for ", years[i], " ...");
        queryResult <- RCurl::getURL(.buildQueryUrl(query, years[i]));
        m[i, "counts"] <- .counts(queryResult);

        ## to be polite and to follow arxiv's user manual we have to
        ## wait (max. 1 query each 3 seconds allowed)
        Sys.sleep(3);
    }

    return(m);
}

## helper function to build arxiv search url
.buildQueryUrl <- function(query, year) {

    ## ONLY CHANGE IF YOU KNOW WHAT YOU ARE DOING
    baseUrl <- "http://export.arxiv.org/api/query?search_query=";
    ##

    query <- paste(baseUrl, query, " AND lastUpdatedDate:", 
                   "[", year, "01010000 TO ", year, "12312359]",
                   "&max_results=1", sep="");

    ## replace special characters by url conform version
    query <- gsub(" ", "+", query);
    query <- gsub('"', "%22", query);
    query <- gsub("\\[", "%5B", query);
    query <- gsub("\\]", "%5D", query);

    return(query);
}

## helper function to parse xml and grep counts
.counts <- function(queryResult) {

    xml <- XML::xmlTreeParse(queryResult, asText=TRUE);
    xmlChild <- XML::xmlChildren(xml$doc$children$feed);
    return(as.numeric(XML::xmlValue(xmlChild$totalResults)));
}
