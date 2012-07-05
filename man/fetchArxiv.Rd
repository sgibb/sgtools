\name{fetchArxiv}
\alias{fetchArxiv}
\title{fetchArxiv}
\usage{
  fetchArxiv(query, fromYear,
    toYear = as.integer(format(Sys.Date(), "\%Y")) - 1)
}
\arguments{
  \item{query}{character, search term e.g. "cat:stat AP AND
  abs:Bayes"}

  \item{fromYear}{numeric, start year}

  \item{toYear}{numeric, end year [default: last year]}
}
\value{
  a 2-column matrix 1. column: "year" 2. column: "counts"
}
\description{
  fetches query counts from arxiv database grouped by years
}
\examples{
bayes <- fetchArxiv("cat:stat.AP AND abs:Bayes", 2009, 2010)
 bayes
 #        year counts
 #   [1,] 2009      4
 #   [2,] 2010     13
}
\references{
  \url{http://arxiv.org/help/api}
}

