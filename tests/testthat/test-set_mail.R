test_that("Email validation works", {
  emails <- c(
    "example2@gmail.com",
    "example-pouet@gmail.com"
  )
  expect_true(
    all(
      email_chk(emails)
    )
  )
})
