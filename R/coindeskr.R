#' Extract Bitcoin Price Index from Coindesk API
#' @param currency a valid ISO 4217 currency code supported by coindesk - verify with get_currency_list(), default is USD
#' @param only_price a TRUE/FALSE flag to force-return only the bitcoin price filtering other associated info
#' @return dataframe containing Bitcoin Price and other associated info returned from the API call if only_price is FALSE, if TRUE, returns only the numeric value of Bitcoin price in the given currency
#' @examples
#' get_current_price()
#' @export
#' @importFrom httr RETRY

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

  response <- httr::RETRY(
    verb = "GET"
    , url = url
    , terminate_on = c(
      403, 404
    )
  )


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

#' Extract daily USD Price of Bitcoin for the last 31 days
#'
#' @return Dataframe with USD Price as one column and Date as rownames
#' @examples
#' get_last31days_price()
#' @export

get_last31days_price <- function(){

        last31days_price <- jsonlite::fromJSON('https://api.coindesk.com/v1/bpi/historical/close.json')

        last31days_price_df <- data.frame(do.call(rbind,last31days_price$bpi))

        names(last31days_price_df) <- 'Price'

        return(last31days_price_df)
}


#' Extract historic  Price of Bitcoin for the given time period and given currency
#' @param currency a valid ISO 4217 currency code supported by coindesk - verify with get_currency_list(), default is USD
#' @param start start date supplied in the YYYY-MM-DD format, e.g. 2013-09-01 for September 1st, 2013. default is current date - 2
#' @param end end date supplied in the YYYY-MM-DD format, e.g. 2013-09-01 for September 1st, 2013. default is current date - 1
#' @return Dataframe with the requested currency Price as one column and Date as rownames
#' @examples
#' get_historic_price()
#' @export

get_historic_price <- function(currency = 'USD', start = Sys.Date()-2, end = Sys.Date()-1){

        #currency check

        currency_list <- get_currency_list()

        if(!(currency %in% currency_list$currency))
                stop('Error: \n Currency code is not supported, Please check with get_currency_list() \n Did you forget the quote ""')

        #start date check

        sd <- as.Date(start,"%Y-%m-%d")
        if(class( sd ) == "try-error" || is.na( sd ))
                stop('Error: \n Start Date is not in the right format YYYY-MM-DD. Please fix!')


        #end ate check

        ed <- as.Date(end,"%Y-%m-%d")
        if(class( ed ) == "try-error" || is.na( ed ))
                stop('Error: \n Start Date is not in the right format YYYY-MM-DD. Please fix!')

        #start vs end check

        if(as.numeric(as.Date(end,"%Y-%m-%d") - as.Date(start,"%Y-%m-%d")) <= 0)
                stop('Error: \n start cannot be older/smaller/earlier than end ')

        url <- paste0('https://api.coindesk.com/v1/bpi/historical/close.json','?currency=',currency,'&start=',as.Date(start,"%Y-%m-%d"),'&end=',as.Date(end,"%Y-%m-%d"))

        historic_price <- jsonlite::fromJSON(url)

        historic_price_df <- data.frame(do.call(rbind,historic_price$bpi))

        names(historic_price_df) <- 'Price'

        return(historic_price_df)
}
