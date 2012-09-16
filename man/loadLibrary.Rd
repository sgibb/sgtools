\name{loadLibrary}
\alias{loadLibrary}
\title{loadLibrary}
\usage{
  loadLibrary(x, repos = getOption("repos"),
    type = .Platform$pkgType,
    contriburl = contrib.url(repos, type = type),
    lib.loc = NULL)
}
\arguments{
  \item{x}{the name of a package}

  \item{repos}{character vector, the base URLs of the
  repositories to use}

  \item{type}{character string, the preferred setting (e.g.
  "source")}

  \item{contriburl}{URL(s) of the contrib sections of the
  repositories}

  \item{lib.loc}{a character vector describing the location
  of the R library}
}
\value{
  nothing
}
\description{
  Helper function to call \code{\link{library}}, install
  missing packages or update old packages if needed
}
\examples{
\dontrun{loadLibrary("MALDIquant")}
}
\seealso{
  \code{\link[utils]{install.packages}},
  \code{\link[base]{require}}
}

