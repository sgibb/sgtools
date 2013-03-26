\name{sourceLines}
\alias{sourceLines}
\title{sourceLines}
\usage{
  sourceLines(file, firstLine = 1, lastLine = 0, ...)
}
\arguments{
  \item{file}{\code{character}, filename to source}

  \item{firstLine}{\code{numeric}, start sourcing at line
  \code{firstLine}}

  \item{lastLine}{\code{numeric}, finish sourcing at line
  \code{lastLine}}

  \item{\dots}{arguments to be passed to
  \code{\link[base]{source}}}
}
\description{
  Only partly source an R file.
}

