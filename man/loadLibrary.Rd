\name{loadLibrary}
\alias{loadLibrary}
\title{loadLibrary}
\usage{
  loadLibrary(x, repos = getOption("repos"),
    contriburl = contrib.url(repos, type = .Platform$pkgType),
    ...)
}
\arguments{
  \item{x}{the name of a package}

  \item{repos}{character vector, the base URLs of the
  repositories to use}

  \item{contrib.url}{URL(s) of the contrib sections of the
  repositories}

  \item{...}{arguments to be passed to
  \code{\link{require}}}
}
\value{
  nothing
}
\description{
  helper function to call \code{\link{library}}, install
  missing packages or update old packages if needed
}
\examples{
loadLibrary("MALDIquant")
}
\seealso{
  install.pacakges require
}

