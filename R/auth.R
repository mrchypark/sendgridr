#' Set API key for auth.
#'
#' If run code, open .Renviron file for set api key.
#'
#' @param force force set api key process. defualt is FALSE.
#' @export
#' @return None
#' @importFrom usethis edit_r_environ
auth_set <- function(force = FALSE) {
  if (!force) {
    res <- auth_check()
    if (res) {
      return(invisible())
    }
  }
  hasKey <- nope("Do you have sendgrid api key?")
  if (hasKey) {
    view_url("https://app.sendgrid.com/settings/api_keys")
    todo("Create your API Key at ", value("https://app.sendgrid.com/settings/api_keys"))
  }

  globOrNot <- yep("Do you use this key Globally(yes) or only this project(no)?")
  if (globOrNot) {
    scope <- "user"
  } else {
    scope <- "project"
  }

  todo("Add your api key in .Renviron like below code block")
  code_block(
    "SENDGRID_API=XXXXXXXXXXXXXXX",
    copy = FALSE
  )
  usethis::edit_r_environ(scope)
}

#' Check API key for auth.
#'
#' Check SENDGRID_API env value is set.
#' If any value from SENDGRID_API detected, return TRUE.
#' Function works using auth_check_zero(), auth_check_dummy(), auth_check_work().
#'
#' @return TRUE/FALSE check work fine return TRUE.
#' @export
auth_check <- function() {
  res <- c()
  keyZero <- auth_check_zero()
  keyDummy <- auth_check_dummy()
  if (keyZero) {
    unset("Api key is unset")
    res <- FALSE
  } else {
    if (keyDummy) {
      unset("Api key is set dummy XXXXXXXXXXXXXXX")
      res <- TRUE
    } else {
      keyWork <- auth_check_work()
      if (keyWork) {
        done("Api key for Authorization works")
        res <- TRUE
      } else {
        todo("Api key set but not working")
        todo("Please set right api key")
        todo("If you want to set new api key, rerun ", value("auth_set(force = T)"))
        res <- TRUE
      }
    }
  }
  return(res)
}

auth_check_zero <- function() {
  Sys.getenv("SENDGRID_API") == ""
}

auth_check_dummy <- function() {
  Sys.getenv("SENDGRID_API") == "XXXXXXXXXXXXXXX"
}

#' @importFrom httr GET add_headers status_code
auth_check_work <- function() {
  res <- c()
  tar <- "https://api.sendgrid.com/v3/api_keys"
  ahd <- httr::add_headers(
    "Authorization" = paste0("Bearer ", Sys.getenv("SENDGRID_API")),
    "content-type" = "application/json"
  )
  chk <- httr::status_code(httr::GET(tar, ahd))
  if (chk == 200) {
    res <- TRUE
  } else {
    res <- FALSE
  }
  return(res)
}
