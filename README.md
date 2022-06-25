
<!-- README.md is generated from README.Rmd. Please edit that file -->

<div class="floatting">

<img src="man/figures/leninsticker_tiny.png" width="150" style="float:right; padding:10px" />

# leninature

<!-- badges: start -->
<!-- badges: end -->

The goal of this package is to make it easy to query and analyse the
works of Lenin.

</div>

# Getting started

## The Easy Way

If you would like to use the tidy data in the format provided, simply
install this package from github using devtools:

``` r
devtools::install_github("alicirce/leninature")
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
