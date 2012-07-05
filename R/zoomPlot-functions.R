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

#' zoomPlot
#' 
#' zoom into a user defined region (spanned by two clicks)
#' \emph{double click on bottom left edge}: return to original size
#' \emph{double click on top right edge}: return to last zoom level
#' \emph{right click}: quit
#'
#' @export
#'

zoomPlot <- function() {
  
  limHistory <- list();

  while (TRUE) {
    loc <- locator(n=2, type="n");

    if (length(loc) < 1) {
      break;
    }

    usr <- par("usr");

    ## if locator in left bottom edge => return back to original limits
    isLeft <- usr[1] > loc$x[1] && usr[1] > loc$x[2];
    isBottom <- usr[3] > loc$y[1] && usr[3] > loc$y[2];

    ## if locator in right upper edge => return one zoom step backwards 
    isRight <- usr[2] < loc$x[1] && usr[2] < loc$x[2];
    isTop <- usr[4] < loc$y[1] && usr[4] < loc$y[2];

    if (isLeft && isBottom) {
      limHistory <- list();
      ## use autoscale
      .zoomPlot(xlim=c(0, 0), ylim=c(0, 0));
    } else if (isRight && isTop) {
      if (length(limHistory) > 0) {
        xlim=limHistory[[length(limHistory)]]$oldxlim
        ylim=limHistory[[length(limHistory)]]$oldylim
        .zoomPlot(xlim=xlim, ylim=ylim);
        limHistory <- limHistory[1:(length(limHistory)-1)];
      } else {
        break;
      }
    } else {
      xlim=sort(c(loc$x[1], loc$x[2]));
      ylim=sort(c(loc$y[1], loc$y[2]));
      limHistory <- c(limHistory, list(.zoomPlot(xlim=xlim, ylim=ylim)));
    }
  }
  invisible(NA);
}

## .zoomPlot 
##  helper function, record a plot and apply new zoomlevel
##
## params:
##  xlim: vector (sizeof==2); autoscale if xlim=c(0, 0)
##  ylim: vector (sizeof==2)
##
## returns:
##  a list, with old limits
##
.zoomPlot <- function(xlim, ylim) {
  ## fetch current plot
  p <- recordPlot();

  isAutoScale <- !missing(xlim) && all(xlim==c(0, 0));

  for (i in rev(seq(along=p[[1]]))) {
    ## since R 2.14.2 .Primitive("plot.window") is missing (replaced by
    ## plot.window)
    isPlotWindow <- all.equal('.Primitive("plot.window")', deparse(p[[1]][[i]][[1]])); 
    isPlotXY <- all.equal('.Primitive("plot.xy")', deparse(p[[1]][[i]][[1]])); 

    if (is.logical(isPlotXY) && isPlotXY && isAutoScale) {
      xlim <- range(p[[1]][[i]][[2]][[1]]$x)
      ylim <- range(p[[1]][[i]][[2]][[1]]$y)
    }

    ## reset limits
    if (is.logical(isPlotWindow) && isPlotWindow) {
      if (!missing(xlim)) {
        oldxlim <- p[[1]][[i]][[2]][[1]];
        p[[1]][[i]][[2]][[1]] <- xlim;
      }

      if (!missing(ylim)) {
        oldylim <- p[[1]][[i]][[2]][[2]];
        p[[1]][[i]][[2]][[2]] <- ylim;
      }
    }
  }

  dev.hold();
  replayPlot(p);
  dev.flush();

  invisible(list(oldxlim=oldxlim, oldylim=oldylim));
}
