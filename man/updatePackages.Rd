\name{updatePackages}
\alias{updatePackages}
\title{updatePackages}
\usage{
  updatePackages(lib.loc = NULL,
    repos = getOption("repos"), type = .Platform$pkgType,
    contriburl = contrib.url(repos, type = type))
}
\arguments{
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
  Helper function to update only packages in directories
  where the current user has write access to.
}
\examples{
\dontrun{updatePackages()}
}
\seealso{
  \code{\link[utils]{update.packages}}
}

