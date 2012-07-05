\name{fetchPubmed}
\alias{fetchPubmed}
\title{fetchPubmed}
\usage{
  fetchPubmed(query, fromYear,
    toYear = as.integer(format(Sys.Date(), "\%Y")) - 1)
}
\arguments{
  \item{query}{character, search term e.g. "Mass
  Spectrometry[MeSH]"}

  \item{from}{numeric, start year}

  \item{to}{numeric, end year [default: last year]}
}
\value{
  a 2-column matrix 1. column: "year" 2. column: "counts"
}
\description{
  fetches query counts from pubmed database grouped by
  years
}
\examples{
ms <- fetchPubmed("Mass Spectrometry[MeSH]", 2009, 2010);
 ms
         year counts
    [1,] 2009  10829
    [2,] 2010  11143
}
\references{
  Kristoffer Magnusson \emph{An R Script to Automatically
  download PubMed Citation Counts By Year of Publication}
  \url{http://rpsychologist.com/an-r-script-to-automatically-look-at-pubmed-citation-counts-by-year-of-publication/}

  \url{http://eutils.ncbi.nlm.nih.gov/entrez/query/static/esearch_help.html}
}

