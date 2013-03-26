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

#' sourceLines
#'
#' Only partly source an R file.
#'
#' @param file \code{character}, filename to source
#' @param firstLine \code{numeric}, start sourcing at line \code{firstLine}
#' @param lastLine \code{numeric}, finish sourcing at line \code{lastLine}
#' @param \dots arguments to be passed to \code{\link[base]{source}}
#'
#' @rdname sourceLines-functions
#' @export
#'
sourceLines <- function(file, firstLine=1, lastLine=0, ...) {
  l <- scan(file, what=character(), skip=firstLine-1,
            nlines=lastLine-firstLine+1, sep="\n")
  return(source(textConnection(paste(l, collapse="\n")), ...))
}

