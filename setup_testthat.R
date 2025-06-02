options(repos = c(CRAN = "https://cloud.r-project.org"))
if (!requireNamespace("usethis", quietly = TRUE)) {
  install.packages("usethis")
}
if (!requireNamespace("testthat", quietly = TRUE)) {
  install.packages("testthat") # Ensure testthat is also installed
}
usethis::use_testthat()
