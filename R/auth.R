#' Set API key for auth.
#'
#' If run code, open .Renviron file for set api key.
#'
#' @param force force set api key process. defualt is FALSE.
#' @importFrom usethis edit_r_environ ui_todo ui_value ui_nope ui_code_block ui_yeah
#' @export
#' @return None
auth_set <- function(force = FALSE) {
  if (!force) {
    res <- auth_check()
    if (res) {
      return()
    }
  }
  hasKey <- usethis::ui_nope("Do you have sendgrid api key?")
  if (hasKey) {
    view_url("https://app.sendgrid.com/settings/api_keys")
    usethis::ui_todo("Create your API Key at {usethis::ui_value('https://app.sendgrid.com/settings/api_keys')}")
  }

  globOrNot <- usethis::ui_yeah("Do you use this key Globally(yes) or only this project(no)?")
  if (globOrNot) {
    scope <- "user"
  } else {
    scope <- "project"
  }

  usethis::ui_todo("Add your api key in .Renviron like below code block")
  usethis::ui_code_block(
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
#' @importFrom usethis ui_todo ui_value ui_done ui_info
#' @export
auth_check <- function() {
  res <- c()
  keyZero <- auth_check_zero()
  keyDummy <- auth_check_dummy()
  if (keyZero) {
    usethis::ui_info("Api key is unset")
    res <- FALSE
  } else {
    if (keyDummy) {
      usethis::ui_info("Api key is set dummy XXXXXXXXXXXXXXX")
      res <- TRUE
    } else {
      keyWork <- auth_check_work()
      if (keyWork) {
        usethis::ui_done("Api key for Authorization works")
        res <- TRUE
      } else {
        usethis::ui_todo("Api key set but not working")
        usethis::ui_todo("Please set right api key")
        usethis::ui_todo("If you want to set new api key, rerun {usethis::ui_value('auth_set(force = T)')}")
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
