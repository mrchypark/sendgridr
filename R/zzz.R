.onLoad <- function(libname, pkgname){
  if (Sys.getenv("SENDGRID_API") != "") {
    try(silent=TRUE,
    keyring::key_set_with_value(service = "apikey",
                                username = "sendgridr",
                                password = Sys.getenv("SENDGRID_API"))
      )
  }
}
