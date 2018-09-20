#' send mail
#'
#' @param mail mail object
#' @export
send <- function(mail) {
  return(mail)
}

#' get api_key_id
#'
#' @importFrom httr GET add_headers content
#' @export
get_key_id <- function() {
  tar <- "https://api.sendgrid.com/v3/api_keys"
  ahd <- httr::add_headers("Authorization" = paste0("Bearer ", Sys.getenv("SENDGRID_API")),
                           "content-type" = "application/json")
  api_key_id <- httr::content(httr::GET(tar, ahd))
  return(api_key_id$result)
}
