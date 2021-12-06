#' @importFrom utils browseURL
#' @importFrom usethis ui_todo ui_done
view_url <- function(..., open = interactive()) {
  url <- paste(..., sep = "/")
  if (open) {
    ui_done("Opening URL {url}")
    utils::browseURL(url)
  } else {
    ui_todo("Open URL {url}")
  }
  invisible(url)
}
