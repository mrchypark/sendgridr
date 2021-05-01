#' send mail
#'
#' Send mail with mail content.
#'
#' @param mail mail object
#' @importFrom httr POST add_headers content
#' @importFrom jsonlite toJSON
#' @export
send <- function(mail) {
  tar <- "https://api.sendgrid.com/v3/mail/send"
  ahd <-
    httr::add_headers("Authorization" = paste0("Bearer ", Sys.getenv("SENDGRID_API")),
                      "content-type" = "application/json")

  body <- jsonlite::toJSON(mail)
  body <- gsub('personalizations":', 'personalizations":[', body)
  body <- gsub(',"from"', '],"from"', body)

  res <-
    httr::POST(tar, ahd, body = body) %>%
    httr::content()
  return(res)
}

#' get api_key_id
#'
#' @importFrom httr GET add_headers content
#' @importFrom tibble as_tibble
#' @importFrom tidyr unnest
#' @export
get_key_id <- function() {
  . <- NULL
  tar <- "https://api.sendgrid.com/v3/api_keys"
  ahd <-
    httr::add_headers("Authorization" = paste0("Bearer ", Sys.getenv("SENDGRID_API")),
                      "content-type" = "application/json")
  api_key_id <-
    httr::GET(tar, ahd) %>%
    httr::content() %>%
    .$result %>%
    do.call(rbind, .) %>%
    data.frame() %>%
    tidyr::unnest() %>%
    tibble::as_tibble()

  return(api_key_id)
}
