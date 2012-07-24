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
#' @param contrib.url URL(s) of the contrib sections of the repositories
#' @param ... arguments to be passed to \code{\link{require}}
#'
#' @return nothing
#' @seealso install.pacakges require
#' @export
#'
#' @examples
#' loadLibrary("MALDIquant")
#'

loadLibrary <- function(x, repos=getOption("repos"),
                        contriburl=contrib.url(repos, type=.Platform$pkgType),
                        ...) {
  ## get warning settings
  warn <- getOption("warn", default=1)
  ## show warnings when they occur
  options(warn=1)
  
  installedPackages <- installed.packages()
  oldPackages <- old.packages(repos=repos, contriburl=contriburl)
  
  for (i in seq(along=x)) {
    p <- (x[i])
    
    ## Is package missing?
    if (!(p %in% installedPackages[, "Package"])) {
      message("Package ", sQuote(p), " is missing, try downloading ",
              "and installing it.")
      install.packages(p, repos=repos, contriburl=contriburl, ...)
    }
    
    ## Is an updated version available?
    if (p %in% oldPackages[, "Package"]) {
      update.packages(p, repos=repos, contriburl=contriburl, ...)
    }

    ## load package
    if (!require(p, character.only=TRUE, ...)) {
      stop("Package ", sQuote(p), " is missing and installation failed!")
    }
  }

  ## reset warning settings
  options(warn=warn)

  invisible()
}

