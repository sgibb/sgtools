## Copyright 2013 Sebastian Gibb
## <mail@sebastiangibb.de>
##
## This is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## It is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## See <http://www.gnu.org/licenses/>

#' SLOC
#'
#' Calculate physical and logical Source Lines Of Code of R files.
#'
#' @details Type \code{physical} counts each line in a file but \code{logical}
#'  measures the executable statements. \code{ploc}/\code{lloc} are shortcuts
#'  for \code{sloc(..., type="physical")}/\code{sloc(..., type="logical")}.
#'
#' @param x \code{character}, filename of file or text which should be counted.
#' @param type \code{character}, determine type of sloc counting.
#'
#' @return \code{numeric}, sloc counts
#' @rdname sloc-functions
#' @export
#'
#' @examples
#' e <- "x <- 1:10; sum(x)"
#' sloc(e, type="physical")  ## == 1
#' sloc(e, type="logical")   ## == 2
#'
sloc <- function(x, type=c("logical", "physical")) {
  type <- match.arg(type)

  if (file.exists(x)) {
    x <- readLines(x)
  }

  if (type == "physical") {
    return(length(x))
  } else {
    p <- as.list(parse(text=x))
    x <- unlist(lapply(p, function(e)length(deparse(e, width.cutoff=500L))))
    return(sum(x))
  }
}

#' @rdname sloc-functions
#' @export
lloc <- function(x) {
  return(sloc(x, type="logical"))
}

#' @rdname sloc-functions
#' @export
ploc <- function(x) {
  return(sloc(x, type="physical"))
}

#' SLOC
#'
#' Calculate physical and logical Source Lines Of Code of R files in a given
#' directory
#'
#' @usage sloc.files(path, pattern="\\\\.[Rr]$", recursive=TRUE,
#' type=c("logical", "physical"))
#'
#' @param path \code{character}, path to directory
#' (details: \code{\link[base]{list.files}})
#' @param pattern \code{character}, regular expression
#' (details: \code{\link[base]{list.files}})
#' @param recursive \code{logical}, should the listing recurse into
#' directories? (details: \code{\link[base]{list.files}})
#' @param type \code{character}, determine type of sloc counting.
#'
#' @return \code{numeric}, sloc counts
#' @rdname slocfiles
#' @export
#'
#' @examples
#'  sloc.files(R.home(), type="physical")
#'
sloc.files <- function(path, pattern="\\.[Rr]$", recursive=TRUE,
                       type=c("logical", "physical")) {
  type <- match.arg(type)

  f <- list.files(path=path, pattern=pattern, full.names=TRUE,
                  recursive=recursive)
  s <- unlist(lapply(f, sloc, type=type))

  return(data.frame(file=f, sloc=s, stringsAsFactors=FALSE))
}

