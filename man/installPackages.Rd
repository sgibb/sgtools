\name{installPackages}
\alias{installPackages}
\title{installPackages}
\usage{
  installPackages(packages, version, lib.loc = NULL,
    repos = getOption("repos"), type = .Platform$pkgType,
    contriburl = contrib.url(repos, type = type))
}
\arguments{
  \item{packages}{a character vector of package names}

  \item{version}{a character vector of package versions (if
  missing current version is taken)}

  \item{lib.loc}{a character vector describing the location
  of the R library}

  \item{repos}{character vector, the base URLs of the
  repositories to use}

  \item{type}{character string, the preferred setting (e.g.
  "source")}

  \item{contriburl}{URL(s) of the contrib sections of the
  repositories}
}
\value{
  nothing
}
\description{
  Wrapper around \code{\link[utils]{install.packages}} to
  allow to install old versions of a packages.
}
\examples{
\dontrun{
installPackages(packages=c("MALDIquant", "readBrukerFlex"),
                version=c("1.0", "1.0"))
}
}
\seealso{
  \code{\link[utils]{install.packages}}
}

