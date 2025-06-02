options(repos = c(CRAN = "https://cloud.r-project.org"))

if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}

# Ensure testthat is available, as devtools::test() will need it.
# It should have been installed by setup_testthat.R, but this is a safeguard.
if (!requireNamespace("testthat", quietly = TRUE)) {
  install.packages("testthat")
}

# Load devtools and run tests
library(devtools)
test()
