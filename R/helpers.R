# this function from usthis:::view_url
#' @importFrom utils browseURL
#' @importFrom usethis ui_todo ui_done
view_url <- function(url, open = interactive()) {
  if (open) {
    ui_done("Opening URL {url}")
    utils::browseURL(url)
  } else {
    ui_todo("Open URL {url}")
  }
  invisible(url)
}
