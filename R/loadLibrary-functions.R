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
#' helper function to call \code{\link{library}}, install missing packages or
#' update old packages if needed
#'
#' @param x the name of a package
#' @param repos character vector, the base URLs of the repositories to use
#' @param type character string, the preferred setting (e.g. "source")
#' @param contriburl URL(s) of the contrib sections of the repositories
#' @param lib.loc a character vector describing the location of the R library
#'
#' @return nothing
#' @seealso install.pacakges require
#' @export
#'
#' @examples
#' \dontrun{loadLibrary("MALDIquant")}
#'

loadLibrary <- function(x, repos=getOption("repos"), type=.Platform$pkgType,
                        contriburl=contrib.url(repos, type=type),
                        lib.loc=NULL) {
  ## get warning settings
  warn <- getOption("warn", default=1)
  ## show warnings when they occur
  options(warn=1)
  
  installedPackages <- installed.packages()
  oldPackages <- old.packages(lib.loc=lib.loc, contriburl=contriburl)
  
  for (i in seq(along=x)) {
    p <- (x[i])
    
    ## Is package missing or is an updated version available?
    if (!(p %in% installedPackages[, "Package"]) ||
         (p %in% oldPackages[, "Package"])) {
      message("Package ", sQuote(p), " is missing or outdated, ",
              "try to download and to install it.")
      install.packages(p, lib=lib.loc, contriburl=contriburl, type=type)
    }
    
    ## load package
    if (!require(p, lib.loc=lib.loc, character.only=TRUE)) {
      stop("Package ", sQuote(p), " is missing and installation failed!")
    }
  }

  ## reset warning settings
  options(warn=warn)

  invisible()
}

