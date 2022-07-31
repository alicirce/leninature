
<!-- README.md is generated from README.Rmd. Please edit that file -->

# leninature <img src='man/figures/leninsticker_tiny.png' align="right"/>

<!-- badges: start -->
<!-- badges: end -->

The goal of this package is to make it easy to query and analyse the
works of Lenin.

If you would prefer to work with Lenin’s work in their original Russian,
please see [leninism](https://github.com/alicirce/leninism). These
databases are not fully comparable; some documents may be present in one
and not in the other.

# Getting started

## The Easy Way

If you would like to use the tidy data in the format provided, simply
install this package from github using devtools:

``` r
devtools::install_github("alicirce/leninature")
```

Then, simply load the package and play around with the available data
frame, `leninru`

``` r
library(leninature)
library(dplyr, warn.conflicts = FALSE)

lenin %>%
  head() %>%
  mutate(text = substring(text, 1, 30)) # for nicer README printing
#>                        url              title text_annotation
#> 1 works/1893/dec/00ppm.htm To:   P. P. Maslov            <NA>
#> 2 works/1893/dec/00ppm.htm To:   P. P. Maslov            <NA>
#> 3 works/1893/dec/00ppm.htm To:   P. P. Maslov            <NA>
#> 4 works/1893/dec/00ppm.htm To:   P. P. Maslov            <NA>
#> 5 works/1893/dec/00ppm.htm To:   P. P. Maslov            <NA>
#> 6 works/1893/dec/00ppm.htm To:   P. P. Maslov            <NA>
#>                             text year
#> 1  I received your letter the da 1893
#> 2  I am very sorry you did not f 1893
#> 3  I am expecting from you a cri 1893
#> 4  I offered the article to Russ 1893
#> 5  It would be very interesting  1893
#> 6  The basic premise in my comme 1893
```

## From Scratch

If you would like to run the data compilation scripts yourself from
scratch, you will need to download the texts from the Marxists Internet
Archive (MIA). MIA provides instructions for (respectfully) downloading
portions of their archives in their
[FAQ](https://www.marxists.org/admin/janitor/faq.htm#hdd).

The scripts in `data-raw` assume you have already run the following
commands. You will also need to have your working directory
appropriately set.

``` bash
mkdir lenin
cd lenin
wget -mpnp -nH -N -t 3 -w .5 https://www.marxists.org/archive/lenin/by-title.htm
```

This took me about 2.5 hours to pull, but others have reported it taking
substantially longer. If your command is interrupted, you can restart it
again.

## I don’t want to use R

If you’d like the tidied data available in this package, but would
prefer to use another language to perform your analysis, assuming you
have R installed and you’ve downloaded this package from github using
the code above, you can run the following lines to export the data as a
text file:

``` r
library(leninature)
write.csv(lenin, "lenin.csv", row.names = FALSE)
```
