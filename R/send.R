#' send mail
#'
#' Send mail with mail content.
#'
#' @param mail mail object
#' @importFrom httr POST add_headers content
#' @importFrom jsonlite toJSON
#' @return [list] if success, success message. and error, please check <https://sendgrid.com/docs/api-reference/>.
#' @examples
#' \dontrun{
#' mail() %>%
#'   from("example1@mail.com", "example name for display") %>%
#'   to("example2@mail.com", "example name for display 2") %>%
#'   subject("test mail title") %>%
#'   body("hello world!")  %>%
#' ## attachments is optional
#'   attachments("report.html") %>%
#'   send()
#'   }
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
  if (identical(res, raw(0))) {
    res <- list("success" = "Send Success!")
  }
  return(res)
}



#' get api_key_id
#'
#' @importFrom httr GET add_headers content
#' @importFrom tibble as_tibble
#' @importFrom tidyr unnest
#' @return a [tibble][tibble::tibble-package] cols name, api_key_id
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
    tidyr::unnest(cols = c("name", "api_key_id")) %>%
    tibble::as_tibble()

  return(api_key_id)
}
