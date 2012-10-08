## Copyright 2012 Sebastian Gibb
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

#' multipleHist 
#'
#' computes histogram for a list of data
#'
#' @param l list of data values
#' @param col colors 
#' @param right logical, should the histogram cells are right-closed? see also
#'  \code{\link{hist}}
#' @param legend add legend to plot. Set \code{legend=NULL} to hide legend.
#'  \code{\link{hist}}
#' @param ... further arguments passed to \code{\link{barplot}}
#'
#' @return a list of objects of class "histogram", see also \code{\link{hist}}
#' @seealso hist barplot
#' @export
#'
#' @examples
#'  x <- lapply(c(1, 1.1, 4), rnorm, n=1000);
#'  multipleHist(x);
#'

multipleHist <- function(l, col=rainbow(length(l)), right=TRUE, legend=names(l), ...) {
    ## create hist for each list element
    l <- lapply(l, hist, plot=FALSE, right=right);

    ## get mids
    mids <- unique(unlist(lapply(l, function(x)x$mids)))

    ## get densities
    densities <- lapply(l, function(x)x$density[match(x=mids, table=x$mids, nomatch=NA)]);

    ## create names
    names <- unique(unlist(lapply(l, function(x)x$breaks)))

    a <- head(names, -1)
    b <- names[-1]

    if (right) {
      names <- paste("(", a, ", ", b, "]", sep="");
    } else {
      names <- paste("[", a, ", ", b, ")", sep="");
    }
  
    ## create barplot list
    h <- do.call(rbind, densities);

    ## set names
    colnames(h) <- names;
  
    ## draw barplot
    barplot(h, beside=TRUE, col=col, ...);

    if (!is.null(legend)) {
        legend(x="topright", col=1, pch=22, pt.bg=col, legend=legend);
    }

    invisible(l);
}

