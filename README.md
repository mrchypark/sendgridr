# sendgridr <img src="man/figures/logo.png" align="right" height=140/>

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/mrchypark/sendgridr?branch=master&svg=true)](https://ci.appveyor.com/project/mrchypark/sendgridr)
[![Travis build status](https://travis-ci.org/mrchypark/sendgridr.svg?branch=master)](https://travis-ci.org/mrchypark/sendgridr)
[![Coverage status](https://codecov.io/gh/mrchypark/sendgridr/branch/master/graph/badge.svg)](https://codecov.io/github/mrchypark/sendgridr?branch=master)

The goal of sendgridr is to mail using r with sendgrid service that provides free 100 mail per day forever.

## Installation

You can install the developing version of sendgridr from [Github](https://github.com/mrchypark/sendgridr) with:

``` r
remotes::install_github("mrchypark/sendgridr")
```

## Set API key for authentication

You can set api key env value name `SENDGRID_API`. `auth_check()` function check whether key named `SENDGRID_API` is set or not, whether key is dummy or not, whether key works or not. `auth_set()` function ask some questions and open browser for create api key, open .Renviron for set `SENDGRID_API` value.

``` r
auth_check()
auth_set()
```

## Send mail

``` r
mail() %>% 
  from("example1@mail.com", "example name for display") %>% 
  to("example2@mail.com", "example name for display 2") %>% 
  subject("test mail title") %>% 
  content("hello world!")  %>% 
  ## attachments is optional
  attachments("report.html") %>% 
  send()
```

## TODO

- [ ] write the documents nicly
- [x] define sg_mail class
- [ ] set print-family functions for sg_mail class
- [ ] check content type 'html'
- [x] build attachments function
- [ ] support multi-mail list
- [ ] write the vignette
- [ ] set tests

## Code of conduct

Please note that the 'sendgridr' project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you agree to abide by its terms.
