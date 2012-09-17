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

#' installPackages
#' 
#' Wrapper around \code{\link[utils]{install.packages}} to allow to install old
#' versions of a packages.
#'
#' @param packages a character vector of package names
#' @param version a character vector of package versions (if missing current
#'  version is taken)
#' @param lib.loc a character vector describing the location of the R library
#' @param repos character vector, the base URLs of the repositories to use
#' @param type character string, the preferred setting (e.g. "source")
#' @param contriburl URL(s) of the contrib sections of the repositories
#'
#' @return nothing
#' @seealso \code{\link[utils]{install.packages}}
#' @export
#'
#' @examples
#' \dontrun{
#' installPackages(packages=c("MALDIquant", "readBrukerFlex"), 
#'                 version=c("1.0", "1.0"))
#' }
#'
installPackages <- function(packages, version, lib.loc=NULL, 
                            repos=getOption("repos"), type=.Platform$pkgType,
                            contriburl=contrib.url(repos, type=type)) {

  if (!missing(version) && length(packages) != length(version)) {
    stop("'packages' and 'version' have to be of the same size.")
  }

  ## get currently available packages
  availablePackages <- available.packages(contriburl=contriburl, type=type)

  isCurrentlyAvailable <- packages %in% availablePackages[, "Package"]
  currentPackages <- packages[isCurrentlyAvailable]

  if (!missing(version)) {
    installCurrentVersion <- version[isCurrentlyAvailable] == 
                             availablePackages[currentPackages, "Version"]
  } else {
    installCurrentVersion <- rep(TRUE, length(currentPackages))
  }

  ## install current
  if (sum(installCurrentVersion)) {
    currentPackages <- currentPackages[installCurrentVersion]

    install.packages(currentPackages, lib=lib.loc, repos=repos, type=type,
                     contriburl=contriburl)
 
    ## remove current packages 
    packages <- setdiff(packages, currentPackages)

    ## remove current versions
    if (!missing(version)) {
      currentVersion <- version[isCurrentlyAvailable][installCurrentVersion]
      version <- setdiff(version, currentVersion)
    }
  }

  ## install old versions
  if (!missing(version) && length(packages)) {
    ## fetch archiv
    con <- gzcon(url(paste(repos, "/src/contrib/Archive.rds", sep=""), "rb"))
    archive <- readRDS(con)
    close(con)

    isOldPackageAvailable <- packages %in% names(archive)

    oldPackages <- packages[isOldPackageAvailable]
    oldVersion <- version[isOldPackageAvailable]

    if (sum(!isOldPackageAvailable)) {
      warning("Could not find ",
              paste(sQuote(packages[!isOldPackageAvailable]),
                    collapse=", ", sep=""),
              "in remote repositories.")
    }

    ## package/package_VERSION.tar.gz
    packagePath <- paste(oldPackages, "/", oldPackages, "_", oldVersion,
                         ".tar.gz", sep="")
    isOldVersionAvailable <- packagePath %in% unlist(archive[oldPackages])

    if (sum(!isOldVersionAvailable)) {
      warning("Could not find ",
              paste(sQuote(oldPackages[!isOldVersionAvailable]),
                    " in version ",
                    sQuote(oldVersion[!isOldVersionAvailable]),
                    collapse=", ", sep=""),
              " in remote repositories.")
    }

    ## download packages
    packageUrl <- paste(repos, "/src/contrib/Archive/", packagePath, sep="")
    destPath <- file.path(tempdir(), basename(packagePath))

    ## download packages
    for (i in seq(along=packageUrl)) {
      if (download.file(url=packageUrl[i], destfile=destPath[i]) != 0) {
        stop("Could not download ", sQuote(packageUrl[i]), "!")
      }
    }

    install.packages(destPath, lib=lib.loc, repos=NULL, type="sources")
  }

  invisible(NULL)
}

