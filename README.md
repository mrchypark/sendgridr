<!-- README.md is generated from README.Rmd. Please edit that file -->

# sendgridr <img src="man/figures/logo.png" align="right" height=140/>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/mrchypark/sendgridr/workflows/R-CMD-check/badge.svg)](https://github.com/mrchypark/sendgridr/actions)
[![send-test](https://github.com/mrchypark/sendgridr/actions/workflows/send-test.yaml/badge.svg)](https://github.com/mrchypark/sendgridr/actions/workflows/send-test.yaml)
[![CRAN
status](https://www.r-pkg.org/badges/version/sendgridr)](https://CRAN.R-project.org/package=sendgridr)
[![runiverse-name](https://mrchypark.r-universe.dev/badges/:name)](https://mrchypark.r-universe.dev/)
[![runiverse-package](https://mrchypark.r-universe.dev/badges/sendgridr)](https://mrchypark.r-universe.dev/packages)
[![metacran
downloads](https://cranlogs.r-pkg.org/badges/sendgridr)](https://cran.r-project.org/package=sendgridr)
[![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/sendgridr)](https://CRAN.R-project.org/package=sendgridr)
<!-- badges: end -->

The goal of sendgridr is to mail using r with sendgrid service that
provides free 100 mail per day forever.

## Installation

    # CRAN version
    install.packages("sendgridr")

    # Dev version
    install.packages("sendgridr", repos = "https://mrchypark.r-universe.dev")

## Set API key for authentication

You can set api key using `auth_set()` function. Also `auth_check()`
function check api key works.

    auth_check()
    auth_set()

### Using with Shiny Apps

For non-interactive environments like Shiny, you can provide the
SendGrid API key via the `SENDGRID_API_KEY` environment variable. For
example:

    Sys.setenv(SENDGRID_API_KEY = "YOUR_API_KEY")
    library(sendgridr)

## Send mail

### Example code

Please replace your conditions.

    mail() |>
      from("example1@mail.com", "example name for display") |>
      to("example2@mail.com", "example name for display 2") |>
      subject("test mail title") |>
      body("hello world!")  |>
      ## attachments is optional
      attachments("report.html") |>
      send()

### sg_mail class

`mail()` function create sg_mail class object and also list. sg_mail
class only has print method.

``` r
sendproject1 <- mail()
class(sendproject1)
#> [1] "sg_mail" "list"
sendproject1
#> SendGrid Mail - 
#> ✖   from   : (required)
#> ✖   to     : (required)
#> ✖   subject: (required)
#> ✖   content: (required)
#> ✔   attach : (optional)
```

to, from, subject, body are required. cc, bcc, attachments are optional.

### multi- setting using inline

to, cc, bcc, attachments functions are able to set multi values.

``` r
library(sendgridr)
mail() |>
  from("example1@mail.com", "toexam@mail.com") |>
  to("toexam1@mail.com", "1 exam") |>
  to("toexam2@mail.com", "2 exam") |>
  to("toexam3@mail.com", "3 exam") |>
  subject("test mail title") |>
  body("hello world!")
#> SendGrid Mail -
#> ✔   from   : toexam@mail.com <example1@mail.com>
#> ✔   to     : cnt[3] 1 exam <toexam1@mail.com>, 2 exam <toexam2 ...
#> ✔   subject: nchr[15] test mail title
#> ✔   content: nchr[12] hello world!
#> ✔   attach : (optional)
```

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
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="http://web-r.org"><img src="https://avatars.githubusercontent.com/u/7410607?v=4?s=100" width="100px;" alt="Keon-Woong Moon"/><br /><sub><b>Keon-Woong Moon</b></sub></a><br /><a href="https://github.com/mrchypark/sendgridr/issues?q=author%3Acardiomoon" title="Bug reports">🐛</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://www.zarathu.com"><img src="https://avatars.githubusercontent.com/u/33089958?v=4?s=100" width="100px;" alt="Jinseob Kim"/><br /><sub><b>Jinseob Kim</b></sub></a><br /><a href="#ideas-jinseob2kim" title="Ideas, Planning, & Feedback">🤔</a></td>
      <td align="center" valign="top" width="14.28%"><a href="http://www.getgoodtree.com"><img src="https://avatars.githubusercontent.com/u/11653794?v=4?s=100" width="100px;" alt="Carl Ganz"/><br /><sub><b>Carl Ganz</b></sub></a><br /><a href="#ideas-carlganz" title="Ideas, Planning, & Feedback">🤔</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/peter-bastian"><img src="https://avatars.githubusercontent.com/u/79409618?v=4?s=100" width="100px;" alt="peter-bastian"/><br /><sub><b>peter-bastian</b></sub></a><br /><a href="https://github.com/mrchypark/sendgridr/issues?q=author%3Apeter-bastian" title="Bug reports">🐛</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/CurtisPetersen"><img src="https://avatars.githubusercontent.com/u/13002038?v=4?s=100" width="100px;" alt="Curtis Petersen"/><br /><sub><b>Curtis Petersen</b></sub></a><br /><a href="#ideas-CurtisPetersen" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/mrchypark/sendgridr/pulls?q=is%3Apr+reviewed-by%3ACurtisPetersen" title="Reviewed Pull Requests">👀</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://dobb.ae/"><img src="https://avatars.githubusercontent.com/u/4908283?v=4?s=100" width="100px;" alt="Amanda Dobbyn"/><br /><sub><b>Amanda Dobbyn</b></sub></a><br /><a href="https://github.com/mrchypark/sendgridr/commits?author=aedobbyn" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://eguidotti.com"><img src="https://avatars.githubusercontent.com/u/24247667?v=4?s=100" width="100px;" alt="Emanuele Guidotti"/><br /><sub><b>Emanuele Guidotti</b></sub></a><br /><a href="https://github.com/mrchypark/sendgridr/commits?author=eguidotti" title="Documentation">📖</a> <a href="https://github.com/mrchypark/sendgridr/commits?author=eguidotti" title="Tests">⚠️</a> <a href="https://github.com/mrchypark/sendgridr/issues?q=author%3Aeguidotti" title="Bug reports">🐛</a> <a href="https://github.com/mrchypark/sendgridr/commits?author=eguidotti" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/ALanguillaume"><img src="https://avatars.githubusercontent.com/u/43757522?v=4?s=100" width="100px;" alt="Antoine Languillaume"/><br /><sub><b>Antoine Languillaume</b></sub></a><br /><a href="https://github.com/mrchypark/sendgridr/issues?q=author%3AALanguillaume" title="Bug reports">🐛</a> <a href="https://github.com/mrchypark/sendgridr/commits?author=ALanguillaume" title="Code">💻</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the
[all-contributors](https://github.com/all-contributors/all-contributors)
specification. Contributions of any kind welcome!
