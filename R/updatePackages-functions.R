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

#' updatePackages
#' 
#' Helper function to update only packages in directories where the current user
#' has write access to.
#'
#' @param lib.loc a character vector describing the location of the R library
#' @param repos character vector, the base URLs of the repositories to use
#' @param type character string, the preferred setting (e.g. "source")
#' @param contriburl URL(s) of the contrib sections of the repositories
#' @param ask logical indicating whether to ask user before packages are
#'  actually downloaded and installed
#'
#' @return nothing
#' @seealso \code{\link[utils]{update.packages}}
#' @export
#'
#' @examples
#' \dontrun{updatePackages()}
#'
updatePackages <- function(lib.loc=NULL, 
                           repos=getOption("repos"), type=.Platform$pkgType,
                           contriburl=contrib.url(repos, type=type),
                           ask=TRUE) {
  ## get updateable packages
  oldPackages <- old.packages(lib.loc=lib.loc, repos=repos, type=type,
                              contriburl=contriburl)

  ## only ask to update packages which installed in a
  ## directory where the user has writing permissions
  writeAccess <- file.access(oldPackages[, "LibPath"], 2)
  
  writeable <- writeAccess == 0
  readonly <- writeAccess == -1

  if (sum(writeable) > 0) {
    ## update packages
    update.packages(lib.loc=lib.loc, repos=repos, type=type,
                    contriburl=contriburl, 
                    oldPkgs=oldPackages[writeable, "Package"], ask=ask)
  }

  invisible(NULL)
}
