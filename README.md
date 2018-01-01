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
get_current_price('EUR',F)

#output
> get_current_price('EUR',F)
              time.updated           time.updatedISO           time.updateduk
1 Jan 1, 2018 19:58:00 UTC 2018-01-01T19:58:00+00:00 Jan 1, 2018 at 19:58 GMT
                                                                                                                                                   disclaimer
1 This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org
  bpi.USD.code bpi.USD.rate  bpi.USD.description bpi.USD.rate_float bpi.EUR.code bpi.EUR.rate bpi.EUR.description
1          USD  13,266.4225 United States Dollar           13266.42          EUR  11,045.6897                Euro
  bpi.EUR.rate_float
1           11045.69```

## Courtesy
Powered by [Coindesk](https://www.coindesk.com/api/)