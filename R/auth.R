#' Set API key for auth.
#'
#' @importFrom keyring key_set
#' @export
#' @return None
auth_set <- function() {
  usethis::ui_todo(
    "Your API Key is at {usethis::ui_value('https://app.sendgrid.com/settings/api_keys')}"
  )

  Sys.sleep(1)

  keyring::key_set(service = "apikey",
                   username = "sendgridr")
}

#' Check API key for auth.
#'
#' @return TRUE/FALSE check work fine return TRUE.
#' @importFrom usethis ui_info
#' @export
auth_check <- function() {

  if (!auth_exist()) {
    usethis::ui_info("Api key is unset")
    return(FALSE)
  }

  return(auth_check_work())
}

#' @importFrom httr GET add_headers status_code
auth_check_work <- function() {
  tar <- "https://api.sendgrid.com/v3/api_keys"
  ahd <-
    httr::add_headers("Authorization" = paste0("Bearer ", auth_key()),
                      "content-type" = "application/json")
  chk <- httr::status_code(httr::GET(tar, ahd))
  return(chk == 200)
}

#' @importFrom keyring key_get
auth_exist <- function() {
  chk <- try(auth_key(), silent = T)
  return(!inherits(chk, "try-error"))
}

#' @importFrom keyring key_get
auth_key <- function() {
  keyring::key_get(service = "apikey",
                   username = "sendgridr")
}
