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

#' fetchPubmed
#'
#' fetches query counts from pubmed database grouped by years
#'
#' @references Kristoffer Magnusson
#' \emph{An R Script to Automatically download PubMed Citation Counts By Year of Publication}
#' \url{http://rpsychologist.com/an-r-script-to-automatically-look-at-pubmed-citation-counts-by-year-of-publication/}
#'  
#' \url{http://eutils.ncbi.nlm.nih.gov/entrez/query/static/esearch_help.html}
#'
#' @param query character, search term e.g. "Mass Spectrometry[MeSH]"
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
#'  ms <- fetchPubmed("Mass Spectrometry[MeSH]", 2009, 2010);
#'  ms
#'  #        year counts
#'  #   [1,] 2009  10829
#'  #   [2,] 2010  11143
#'

fetchPubmed <- function(query, fromYear, 
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

        ## to be polite and to follow pubmed's e-utility guidelines we have to
        ## wait (max. 3 queries per second allowed)
        Sys.sleep(0.5);
    }

    return(m);
}

## helper function to build pubmed search url
.buildQueryUrl <- function(query, year) {

    ## ONLY CHANGE IF YOU KNOW WHAT YOU ARE DOING
    baseUrl <- "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi";
    db <- "pubmed";
    ##

    query <- paste(baseUrl, "?db=", db, "&rettype=count&term=", 
                   query, " AND ", year, "[ppdat]", sep="");

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

    return(as.numeric(XML::xmlValue(xml[["doc"]][["eSearchResult"]][["Count"]])));
}
