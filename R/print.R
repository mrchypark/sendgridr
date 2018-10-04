#' print sg_mail class
#'
#' @param x mail object from package
#' @param ... print params
#' @export
print.sg_mail <- function(x, ...) {
  cat("SendGrid Mail - \n")

  if (length(x$personalizations) == 0) {
    need("  to     :")
  } else {
    to_check <- names(x$personalizations)
    if (!any(to_check == "to")) {
      need("  to     :")
    }

    for (i in 1:(length(x$personalizations))) {
      locate <- names(x$personalizations)[i]

      if (is.null(x$personalizations[[i]][[1]]$name)) {
        address <- x$personalizations[[i]][[1]]$email
      } else {
        address <- paste0(
          x$personalizations[[i]][[1]]$name,
          " <",
          x$personalizations[[i]][[1]]$email,
          ">"
        )
      }
      if (locate == "to") {
        done("  ", locate, "     : ", address)
      } else {
        if (locate == "cc") {
          option("    ", locate, "   : ", address)
        } else {
          option("    ", locate, "  : ", address)
        }
      }
    }
  }

  if (length(x$from) == 1) {
    need("  from   : ")
  } else {
    if (is.null(x$from$name)) {
      address <- x$from$email
    } else {
      address <- paste0(x$from$name, " <",
                        x$from$email, ">")
    }
    done("  from   : ", address)
  }

  if (nchar(x$subject) == 0) {
    need("  subject: ")
  } else {
    done("  subject: ", x$subject)
  }

  console_len <- options("width")$width - 20
  if (is.null(x$content$value)) {
    need("  content: ")
  } else {
    content_len <- nchar(x$content$value)
    content_end <- ifelse(content_len > console_len, " ...", "")
    done("  content: ",
         strtrim(x$content$value, console_len),
         content_end)
  }
}
