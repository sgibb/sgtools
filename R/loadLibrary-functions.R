### Copyright 2012 Sebastian Gibb
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

#' loadLibrary
#' 
#' helper function to call \code{\link{library}} and install missing packages
#' if needed
#'
#' @param x the name of a package
#' @param repos character vector, the base URLs of the repositories to use
#' @param ... arguments to be passed to \code{\link{require}}
#'
#' @return nothing
#' @seealso install.pacakges require
#' @export
#'
#' @examples
#'  loadLibrary("MALDIquant")
#'

loadLibrary <- function(x, repos="http://cran.at.r-project.org", ...) {
    ## get warning settings
    warn <- getOption("warn", default=1);
    ## show warnings when they occur
    options(warn=1);

    for (i in seq(along=x)) {
        p <- (x[i]);

        ## try to load package
        if (!require(p, character.only=TRUE, ...)) {
            message("Package ", sQuote(p), " is missing, try downloading ",
                    "and installing it.");
            ## if failed: try installing it
            install.packages(p, repos=repos, ...);

            ## no success? => stop
            if (!require(p, character.only=TRUE, ...)) {
                stop("Package ", sQuote(p), " is missing and installation ",
                     "failed!");
            }
        }
    }
    ## reset warning settings
    options(warn=warn);

    invisible();
}

