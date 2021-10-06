# code from usethis/R/style.R v1.4.0.9000

# Helpers --------------------------------------------------------------------

## anticipates usage where the `...` bits make up one line
##
## 'usethis.quiet' is an undocumented option; anticipated usage:
##   * eliminate `capture_output()` calls in usethis tests
##   * other packages, e.g., devtools can call usethis functions quietly
cat_line <- function(..., quiet = getOption("usethis.quiet", default = FALSE)) {
  if (quiet) {
    return(invisible())
  }
  cat(..., "\n", sep = "")
}

#' @importFrom crayon red
#' @importFrom clisymbols symbol
todo_bullet <- function() crayon::red(clisymbols::symbol$bullet)
#' @importFrom crayon green
done_bullet <- function() crayon::green(clisymbols::symbol$tick)
#' @importFrom crayon red
need_bullet <- function() crayon::red(clisymbols::symbol$cross)
#' @importFrom crayon make_style
option_bullet <- function() crayon::make_style("lightgrey")(clisymbols::symbol$tick)


## adds a leading bullet
bulletize <- function(line, bullet = "*") {
  paste0(bullet, " ", line)
}

#' @importFrom utils getFromNamespace packageVersion
collapse <- function(x, sep = ", ", width = Inf, last = "") {
  if (utils::packageVersion("glue") > "1.2.0") {
    utils::getFromNamespace("glue_collapse", "glue")(x, sep = sep, width = Inf, last = last)
  } else {
    utils::getFromNamespace("collapse", "glue")(x = x, sep = sep, width = width, last = last)
  }
}

## glue into lines stored as character vector
glue_lines <- function(lines, .envir = parent.frame()) {
  unlist(lapply(lines, glue, .envir = .envir))
}


# Functions designed for a single line ----------------------------------------
todo <- function(..., .envir = parent.frame()) {
  out <- glue(..., .envir = .envir)
  cat_line(bulletize(out, bullet = todo_bullet()))
}

done <- function(..., .envir = parent.frame()) {
  out <- glue(..., .envir = .envir)
  cat_line(bulletize(out, bullet = done_bullet()))
}

need <- function(..., .envir = parent.frame()) {
  out <- glue(..., .envir = .envir)
  cat_line(bulletize(out, bullet = need_bullet()))
}

option <- function(..., .envir = parent.frame()) {
  out <- glue(..., .envir = .envir)
  cat_line(bulletize(out, bullet = option_bullet()))
}

# Function designed for several lines -------------------------------------

## ALERT: each individual bit of `...` is destined to be a line
#' @importFrom clipr clipr_available write_clip
#' @importFrom crayon make_style
code_block <- function(..., copy = interactive(), .envir = parent.frame()) {
  lines <- glue_lines(c(...), .envir = .envir)
  block <- paste0("  ", lines, collapse = "\n")
  if (copy && clipr::clipr_available()) {
    clipr::write_clip(collapse(lines, sep = "\n"))
    message("Copying code to clipboard:")
  }
  cat_line(crayon::make_style("darkgrey")(block))
}


# Inline styling functions ------------------------------------------------

## use these inside todo(), done(), and code_block()
## ^^ and let these functions handle any glue()ing ^^
#' @importFrom crayon green
field <- function(...) {
  x <- paste0(...)
  crayon::green(x)
}

#' @importFrom crayon blue
value <- function(...) {
  x <- paste0(...)
  crayon::blue(encodeString(x, quote = "'"))
}

#' @importFrom crayon make_style
code <- function(...) {
  x <- paste0(...)
  crayon::make_style("darkgrey")(encodeString(x, quote = "`"))
}

#' @importFrom crayon make_style
unset <- function(...) {
  x <- paste0(...)
  crayon::make_style("lightgrey")(x)
}
