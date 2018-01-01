# coindeskr

[![Build Status](https://travis-ci.org/amrrs/coindeskr.svg?branch=master)](https://travis-ci.org/amrrs/coindeskr) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/coindeskr)](https://cran.r-project.org/package=coindeskr) [![DOWNLOADSTOTAL](https://cranlogs.r-pkg.org/badges/grand-total/coindeskr)](https://cranlogs.r-pkg.org/badges/grand-total/coindeskr) 

The goal of coindeskr is to access 'CoinDesk' Bitcoin Price Index API in R

## Installation

You can install coindeskr from github with:


``` r
# install.packages("devtools")
devtools::install_github("amrrs/coindeskr")
```

## Example

Get Current Bitcoin Price:

``` r
library(coindeskr)
get_current_price()

#output
> get_current_price()
$USD
[1] 13276.75

$EUR
[1] 11066.24

$GBP
[1] 9839.734

attr(,"class")
[1] "coindesk_api"
```

## Courtesy
Powered by [Coindesk](https://www.coindesk.com/api/)