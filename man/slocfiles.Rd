\name{sloc.files}
\alias{sloc.files}
\title{SLOC}
\usage{
  sloc.files(path, pattern="\\\\.[Rr]$", recursive=TRUE,
    type=c("logical", "physical"))
}
\arguments{
  \item{path}{\code{character}, path to directory (details:
  \code{\link[base]{list.files}})}

  \item{pattern}{\code{character}, regular expression
  (details: \code{\link[base]{list.files}})}

  \item{recursive}{\code{logical}, should the listing
  recurse into directories? (details:
  \code{\link[base]{list.files}})}

  \item{type}{\code{character}, determine type of sloc
  counting.}
}
\value{
  \code{numeric}, sloc counts
}
\description{
  Calculate physical and logical Source Lines Of Code of R
  files in a given directory
}
\examples{
sloc.files(R.home(), type="physical")
}

