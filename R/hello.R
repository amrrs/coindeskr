#'@import ggplot2
#'@import httr
#'@import jsonlite
#' Extract Bitcoin Price Index (USD, EUR, GBP Price) from Coindesk API.
#' @return structured list of USD, EUR, GBP Price of Bitcoin returned from the API call.
#' @export
#' @examples
#' get_current_price()


coindeskAPI <- "http://api.coindesk.com/v1/bpi/"

get_current_price <- function(){

        ua <- httr::user_agent("http://github.com/amrrs/coinmarketcapr")

        url <- paste0(coindeskAPI,'currentprice.json')

        response <- httr::GET(url, ua)


        parsed <- jsonlite::fromJSON(httr::content(response, "text", encoding = "UTF-8"))


        if (httr::status_code(resp) != 200) {
                stop(
                        sprintf(
                                "Coindesk API request failed [%s]\n%s\n<%s>",
                                httr::status_code(resp),
                                parsed$disclaimer
                        ),
                        call. = FALSE
                )
        }


        structure(
                list(
                        USD = as.numeric(gsub(',','',parsed$bpi$USD$rate)),
                        EUR = as.numeric(gsub(',','',parsed$bpi$EUR$rate)),
                        GBP = as.numeric(gsub(',','',parsed$bpi$GBP$rate))
                ),
                class = "coindesk_api"
        )
}
