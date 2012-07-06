\name{removeSpaces}
\alias{removeSpaces}
\title{removeSpaces}
\usage{
  removeSpaces(text)
}
\arguments{
  \item{text}{character vector}
}
\value{
  cleaned vector
}
\description{
  removes all spaces (whitespaces, tabs, newlines) in a
  string
}
\examples{
removeSpaces(" a lot of                      spaces\\n")
 # "alotofspaces"
}

