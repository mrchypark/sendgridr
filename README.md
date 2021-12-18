
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sendgridr <img src="man/figures/logo.png" align="right" height=140/>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/mrchypark/sendgridr/workflows/R-CMD-check/badge.svg)](https://github.com/mrchypark/sendgridr/actions)
[![test-coverage](https://github.com/mrchypark/sendgridr/workflows/test-coverage/badge.svg)](https://github.com/mrchypark/sendgridr/actions)
[![CRAN
status](https://www.r-pkg.org/badges/version/sendgridr)](https://CRAN.R-project.org/package=sendgridr)
[![metacran
downloads](https://cranlogs.r-pkg.org/badges/sendgridr)](https://cran.r-project.org/package=sendgridr)
<!-- badges: end -->

The goal of sendgridr is to mail using r with sendgrid service that
provides free 100 mail per day forever.

## Installation

### CRAN

You can install the released version of sendgridr from CRAN with:

    install.packages("sendgridr")

### Github

You can install the developing version of sendgridr from
[Github](https://github.com/mrchypark/sendgridr) with:

    # install.packages("remotes")
    remotes::install_github("mrchypark/sendgridr")

## Set API key for authentication

You can set api key env value name `SENDGRID_API`. `auth_check()`
function check whether key named `SENDGRID_API` is set or not, whether
key is dummy or not, whether key works or not. `auth_set()` function ask
some questions and open browser for create api key, open .Renviron for
set `SENDGRID_API` value.

    auth_check()
    auth_set()

## Send mail

### Example code

Please replace your conditions.

    mail() %>% 
      from("example1@mail.com", "example name for display") %>% 
      to("example2@mail.com", "example name for display 2") %>% 
      subject("test mail title") %>% 
      body("hello world!")  %>% 
      ## attachments is optional
      attachments("report.html") %>% 
      send()

### sg\_mail class

`mail()` function create sg\_mail class object and also list. sg\_mail
class only has print method.

``` r
sendproject1 <- mail()
class(sendproject1)
#> [1] "sg_mail" "list"
sendproject1
#> SendGrid Mail - 
#> x   from   : (required)
#> x   to     : (required)
#> x   subject: (required)
#> x   content: (required)
#> v   attach : (optional)
```

![](https://user-images.githubusercontent.com/6179259/146438934-6a462118-9691-4fcf-8c1d-895b63fa6c9e.png)

to, from, subject, body are required. cc, bcc, attachments are optional.

### multi- setting using inline

to, cc, bcc, attachments functions are able to set multi values.

``` r
library(sendgridr)
mail() %>% 
  from("example1@mail.com", "toexam@mail.com") %>% 
  to("toexam1@mail.com", "1 exam") %>% 
  to("toexam2@mail.com", "2 exam") %>% 
  to("toexam3@mail.com", "3 exam") %>% 
  subject("test mail title") %>% 
  body("hello world!")
#> SendGrid Mail -
#> v   from   : 
#> v   to     : cnt[3] 1 exam <toexam1@mail.com>, 2 exam <toexam2 ...
#> v   subject: nchr[15] test mail title
#> v   content: nchr[12] hello world!
#> v   attach : (optional)
```

## TODO

-   [ ] write the documents nicly
-   [ ] support multi-mail list with one function
-   [ ] write the vignette
-   [ ] set tests
-   [x] rebuild html file possible to view in gmail

## Code of Conduct

Please note that the sendgridr project is released with a [Contributor
Code of
Conduct](https://mrchypark.github.io/sendgridr/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.

## Contributors ✨

Thanks goes to these wonderful people ([emoji
key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
<tr>
<td align="center">
<a href="http://web-r.org"><img src="https://avatars.githubusercontent.com/u/7410607?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Keon-Woong
Moon</b></sub></a><br /><a href="https://github.com/mrchypark/sendgridr/issues?q=author%3Acardiomoon" title="Bug reports">🐛</a>
</td>
<td align="center">
<a href="http://www.zarathu.com"><img src="https://avatars.githubusercontent.com/u/33089958?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Jinseob
Kim</b></sub></a><br /><a href="#ideas-jinseob2kim" title="Ideas, Planning, & Feedback">🤔</a>
</td>
<td align="center">
<a href="http://www.getgoodtree.com"><img src="https://avatars.githubusercontent.com/u/11653794?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Carl
Ganz</b></sub></a><br /><a href="#ideas-carlganz" title="Ideas, Planning, & Feedback">🤔</a>
</td>
<td align="center">
<a href="https://github.com/peter-bastian"><img src="https://avatars.githubusercontent.com/u/79409618?v=4?s=100" width="100px;" alt=""/><br /><sub><b>peter-bastian</b></sub></a><br /><a href="https://github.com/mrchypark/sendgridr/issues?q=author%3Apeter-bastian" title="Bug reports">🐛</a>
</td>
<td align="center">
<a href="https://github.com/CurtisPetersen"><img src="https://avatars.githubusercontent.com/u/13002038?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Curtis
Petersen</b></sub></a><br /><a href="#ideas-CurtisPetersen" title="Ideas, Planning, & Feedback">🤔</a>
<a href="https://github.com/mrchypark/sendgridr/pulls?q=is%3Apr+reviewed-by%3ACurtisPetersen" title="Reviewed Pull Requests">👀</a>
</td>
<td align="center">
<a href="https://dobb.ae/"><img src="https://avatars.githubusercontent.com/u/4908283?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Amanda
Dobbyn</b></sub></a><br /><a href="https://github.com/mrchypark/sendgridr/commits?author=aedobbyn" title="Code">💻</a>
</td>
<td align="center">
<a href="https://guidotti.dev"><img src="https://avatars.githubusercontent.com/u/24247667?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Emanuele
Guidotti</b></sub></a><br /><a href="https://github.com/mrchypark/sendgridr/commits?author=eguidotti" title="Documentation">📖</a>
<a href="https://github.com/mrchypark/sendgridr/commits?author=eguidotti" title="Tests">⚠️</a>
<a href="https://github.com/mrchypark/sendgridr/issues?q=author%3Aeguidotti" title="Bug reports">🐛</a>
<a href="https://github.com/mrchypark/sendgridr/commits?author=eguidotti" title="Code">💻</a>
</td>
</tr>
</table>
<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the
[all-contributors](https://github.com/all-contributors/all-contributors)
specification. Contributions of any kind welcome!
