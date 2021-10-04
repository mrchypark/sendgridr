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
#'
#' data_lst <-
#'   list(
#'     total = "$239.85",
#'     name = "Sample Name"
#'   )
#'
#' mail() %>%
#'   from("example1@mail.com", "example name for display") %>%
#'   to("example2@mail.com", "example name for display 2") %>%
#'   dynamic_template_data(data_lst) %>%
#'   template_id(template_id) %>%
#'   subject("test mail title") %>%
#'   body("hello world!") %>%
#'   ## attachments is optional
#'   attachments("report.html") %>%
#'   send()
#' }
#' @export
send <- function(mail) {
  tar <- "https://api.sendgrid.com/v3/mail/send"
  ahd <-
    httr::add_headers(
      "Authorization" = paste0("Bearer ", Sys.getenv("SENDGRID_API")),
      "content-type" = "application/json"
    )

  body <- jsonlite::toJSON(mail, auto_unbox = TRUE)

  # Add brackets around `personalizations`
  body <- gsub('personalizations":', 'personalizations":[', body)
  body <- gsub('},"subject"', '}],"subject"', body)

  res <-
    httr::POST(tar, ahd, body = body) %>%
    httr::content()

  if (identical(res, raw(0))) {
    res <- list("success" = "Send Success!")
  }
  return(res)
}
