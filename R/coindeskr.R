#' Extract Bitcoin Price Index from Coindesk API
#' @param currency a valid ISO 4217 currency code supported by coindesk - verify with get_currency_list(), default is USD
#' @param only_price a TRUE/FALSE flag to force-return only the bitcoin price filtering other associated info
#' @return dataframe containing Bitcoin Price and other associated info returned from the API call if only_price is FALSE, if TRUE, returns only the numeric value of Bitcoin price in the given currency
#' @examples
#' get_current_price()
#' @export

get_current_price <- function(currency = 'USD', only_price = FALSE){

  #currency check

  currency_list <- get_currency_list()

  if(!(currency %in% currency_list$currency))
          stop('Error: \n Currency code is not supported, Please check with get_currency_list()')


  if(!is.logical(only_price))
          stop('Error: \n only_price takes only logical value TRUE or FALSE, Please fix!')

  coindeskAPI <- "http://api.coindesk.com/v1/bpi/currentprice/"

  #ua <- httr::user_agent("http://github.com/amrrs/coinmarketcapr")

  url <- paste0(coindeskAPI,currency,'.json')

  response <- httr::GET(url)


  parsed <- jsonlite::fromJSON(httr::content(response, "text", encoding = "UTF-8"))

  #print(parsed)


  if (httr::status_code(response) != 200) {
    stop(
      sprintf(
        "Coindesk API request failed [%s]\n%s\n<%s>",
        httr::status_code(response),
        parsed$disclaimer
      ),
      call. = FALSE
    )
  }

 if(only_price == F){
         return(data.frame(parsed))
 }
 else if(only_price == T & currency == 'USD'){
         return(as.numeric(gsub(',','',unlist(parsed$bpi[[1]][2]))))
 }
 else if(only_price == T & currency != 'USD'){
         return(as.numeric(gsub(',','',unlist(parsed$bpi[[2]][2]))))
  }

}

#' Extract List of currency codes supported by Coindesk
#'
#' @return Dataframe of different currency codes supported by Coindesk along with its country
#' @examples
#' get_currency_list()
#' @export

get_currency_list <- function(){

        currency_list <- jsonlite::read_json('https://api.coindesk.com/v1/bpi/supported-currencies.json',simplifyVector = T)

        return(currency_list)
}
