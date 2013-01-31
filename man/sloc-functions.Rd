\name{sloc}
\alias{lloc}
\alias{ploc}
\alias{sloc}
\title{SLOC}
\usage{
  sloc(x, type = c("logical", "physical"))

  lloc(x)

  ploc(x)
}
\arguments{
  \item{x}{\code{character}, filename of file or text which
  should be counted.}

  \item{type}{\code{character}, determine type of sloc
  counting.}
}
\value{
  \code{numeric}, sloc counts
}
\description{
  Calculate physical and logical Source Lines Of Code of R
  files.
}
\details{
  Type \code{physical} counts each line in a file but
  \code{logical} measures the executable statements.
  \code{ploc}/\code{lloc} are shortcuts for \code{sloc(...,
  type="physical")}/\code{sloc(..., type="logical")}.
}
\examples{
e <- "x <- 1:10; sum(x)"
sloc(e, type="physical")  ## == 1
sloc(e, type="logical")   ## == 2
}

