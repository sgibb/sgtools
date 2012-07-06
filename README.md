# install

```R
install.packages("devtools")
library("devtools")
install_github("sgTools", "sgibb")
```


# fetchArxiv

fetches query counts from arxiv database grouped by years

example:

```R
library("rmisc")
bayes <- fetchArxiv("cat:stat.AP AND abs:Bayes", 2009, 2010)
bayes
#     year counts
#[1,] 2009      4
#[2,] 2010     13
```


# fetchPubmed

fetches query counts from pubmed database grouped by years

Thanks to Kristoffer Magnusson for providing this nice article: 
[An R Script to Automatically download PubMed Citation Counts By Year of
Publication](http://rpsychologist.com/an-r-script-to-automatically-look-at-pubmed-citation-counts-by-year-of-publication/)

example:

```R
library("rmisc")
ms <- fetchPubmed("Mass Spectrometry[MeSH]", 2009, 2010)
ms
#     year counts
#[1,] 2009  10829
#[2,] 2010  11143

total <- fetchPubmed("", 1975, 2011);
barplot(total[, "counts"], names.arg=as.character(total[, "year"]),
        main="total number of publications in pubmed", col="#7FC97F")
```
![pubmed publication barplot](https://github.com/sgibb/rmisc/raw/master/images/totalNumberPubmed.png)


# multipleHist

computes histogram for a list of data

example:
```R
library("rmisc")
x <- lapply(c(1, 1.1, 4), rnorm, n=1000)
multipleHist(x)
```
![multiple histograms](https://github.com/sgibb/rmisc/raw/master/images/multipleHist.png)

