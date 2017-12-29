#' Extract Bitcoin Price Index from Coindesk API
#'
#' @return structured list of Bitcoin price in different currencies returned from the API call
#' @examples
#' get_current_price()
#' @export

get_current_price <- function(){

  coindeskAPI <- "http://api.coindesk.com/v1/bpi/"

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
