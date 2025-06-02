library(testthat)
library(sendgridr)

test_that("auth_key() uses SENDGRID_API_KEY environment variable if set", {
  Sys.setenv(SENDGRID_API_KEY = "testkey_env")
  expect_equal(auth_key(), "testkey_env")
  Sys.unsetenv("SENDGRID_API_KEY")
})

test_that("auth_key() uses keyring if SENDGRID_API_KEY is not set", {
  # Ensure the environment variable is not set
  Sys.unsetenv("SENDGRID_API_KEY")

  # Mock keyring::key_get
  with_mocked_bindings(
    key_get = function(service, username) {
      if (service == "apikey" && username == "sendgridr") {
        return("testkey_keyring")
      } else {
        # Call actual keyring::key_get for other services/usernames if needed
        return(keyring::key_get(service = service, username = username))
      }
    },
    .package = "keyring", # Specify the package for the mocked function
    {
      expect_equal(auth_key(), "testkey_keyring")
    }
  )
})
