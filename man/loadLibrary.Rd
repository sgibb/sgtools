\name{loadLibrary}
\alias{loadLibrary}
\title{loadLibrary}
\usage{
  loadLibrary(x, repos = getOption("repos"), ...)
}
\arguments{
  \item{x}{the name of a package}

  \item{repos}{character vector, the base URLs of the
  repositories to use}

  \item{...}{arguments to be passed to
  \code{\link{require}}}
}
\value{
  nothing
}
\description{
  helper function to call \code{\link{library}} and install
  missing packages if needed
}
\examples{
loadLibrary("MALDIquant")
}
\seealso{
  install.pacakges require
}

