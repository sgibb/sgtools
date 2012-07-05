\name{multipleHist}
\alias{multipleHist}
\title{multipleHist}
\usage{
  multipleHist(l, col = rainbow(length(l)), right = TRUE,
    legend = names(l), ...)
}
\arguments{
  \item{l}{list of data values}

  \item{col}{colors}

  \item{right}{logical, should the histogram cells are
  right-closed? see also \code{\link{hist}}}

  \item{legend}{add legend to plot. Set \code{legend=NULL}
  to hide legend.  \code{\link{hist}}}

  \item{...}{further arguments passed to
  \code{\link{barplot}}}
}
\value{
  a list of objects of class "histogram", see also
  \code{\link{hist}}
}
\description{
  computes histogram for a list of data
}
\examples{
x <- lapply(c(1, 1.1, 4), rnorm, n=1000);
 multipleHist(x);
}
\seealso{
  hist barplot
}

