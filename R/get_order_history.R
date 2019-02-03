#' Get order history using the RobinHood api
#'
#' Returns recent order history.
#'
#' @param RH object of class RobinHood
#' @import curl jsonlite magrittr lubridate
#' @export
#' @examples
#' \dontrun{
#' # Login in to your RobinHood account
#' RH <- RobinHood("username", "password")
#'
#' get_order_history(RH)
#'}
get_order_history <- function(RH) {

  if (class(RH) != "RobinHood") stop("RH must be class RobinHood, see RobinHood()")

  # Get Order History
  order_history <- api_orders(RH, action = "history")
  order_history <- fromJSON(rawToChar(order_history$content))
  order_history <- order_history$results

  # Get symbol to attach to output
  symbol <- as.character()

  for (i in order_history$instrument) {
    x <- api_instruments(RH, i)
    x <- x$symbol
    symbol <- c(symbol, x)
  }

  # Combine symbol with order history
  order_history$symbol <- symbol
  order_history <- order_history[, c("updated_at", "symbol", "side", "price", "quantity", "fees", "state",
                                   "average_price", "type", "trigger", "time_in_force")]

  # Format timestamp
  order_history$updated_at <- ymd_hms(order_history$updated_at)
  order_history$fees <- as.numeric(order_history$fees)
  order_history$price <- as.numeric(order_history$price)
  order_history$average_price <- as.numeric(order_history$average_price)
  order_history$quantity <- as.numeric(order_history$quantity)

  return(order_history)
}