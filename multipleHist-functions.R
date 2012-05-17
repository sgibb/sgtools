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

## multipleHist 
##  computes histogram for a list of data
##
## params:
##  l: list of data values
##  col: colors
##  right: logical, Should the histogram cells are right-closed? see also ?hist
##  ...: further arguments passed to barplot
##
## returns:
##  a list of objects of class "histogram", see also ?hist
##
## example:
##  x <- lapply(c(1, 1.1, 4), rnorm, n=1000);
##  multipleHist(x);
##

multipleHist <- function(l, col=rainbow(length(l)), right=TRUE, legend=names(l), ...) {
    ## create hist for each list element
    l <- lapply(l, hist, plot=FALSE, right=right);

    ## get mids
    mids <- unique(unlist(lapply(l, function(x)x$mids)))

    ## get densities
    densities <- lapply(l, function(x)x$density[match(x=mids, table=x$mids, nomatch=NA)]);

    ## create names
    names <- unique(unlist(lapply(l, function(x)x$breaks)))

    names <- mapply(function(a, b) {
        if (right) {
            return(paste("(", a, ", ", b, "]", sep=""));
        } else {
            return(paste("[", a, ", ", b, ")", sep=""));
        }
    }, a=names[-length(names)], b=names[-1], SIMPLIFY=FALSE);
  
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

