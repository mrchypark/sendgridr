print.sg_mail <- function(x) {
  cat("SendGrid Mail - \n")

  # print to, cc, bcc
  if (length(x$personalizations) == 0) {
    need("  to     : (required)")
  } else {
    to_check <- names(x$personalizations)
    if (!any(to_check == "to")) {
      need("  to     : (required)")
    }
    for (i in 1:(length(x$personalizations))) {
      locate <- names(x$personalizations)[i]
      address_list <- c()
      for (j in 1:length(x$personalizations[[i]])) {
        if (is.null(x$personalizations[[i]][[j]]$name)) {
          address <- x$personalizations[[i]][[j]]$email
        } else {
          address <- paste0(
            x$personalizations[[i]][[j]]$name,
            " <",
            x$personalizations[[i]][[j]]$email,
            ">"
          )
        }
        address_list <- paste0(address_list, ", ", address)
        cnt <- j
      }
      address_list <- gsub("^, ", "", address_list)
      if (locate == "to") {
        text <-
          paste0("  ", locate, "     : cnt[", cnt, "] ", address_list)
        done(console_print(text))
      } else {
        if (locate == "cc") {
          text <-
            paste0("  ", locate, "     : cnt[", cnt, "] ", address_list)
          option(console_print(text))
        } else {
          text <-
            paste0("  ", locate, "    : cnt[", cnt, "] ", address_list)
          option(console_print(text))
        }
      }
    }
  }

  # print from
  if (!is.list(x$from)) {
    need("  from   : (required)")
  } else {
    if (is.null(x$from$name)) {
      address <- x$from$email
    } else {
      address <- paste0(
        x$from$name, " <",
        x$from$email, ">"
      )
    }
    done("  from   : ", address)
  }

  # print subject
  if (nchar(x$subject) == 0) {
    need("  subject: (required)")
  } else {
    text <-
      paste0("  subject: ", "nchr[", nchar(x$subject), "] ", x$subject)
    done(console_print(text))
  }

  # print content
  if (is.null(x$content$value)) {
    need("  content: (required)")
  } else {
    text <-
      paste0(
        "  content: ",
        "nchr[",
        nchar(x$content$value),
        "] ",
        x$content$value
      )
    done(console_print(text))
  }

  # print attachments
  if (!is.null(x$attachments)) {
    attached <- paste0(x$attachments$filename, collapse = ", ")
    cnt <- length(x$attachments$filename)
    text <- paste0("attached : ", "cnt[", cnt, "] ", attached)
    option(console_print(text))
  }
}


console_print <- function(text) {
  console_len <- options("width")$width - 20
  content_len <- nchar(text)
  content_end <- ifelse(content_len > console_len, " ...", "")
  res <- paste0(strtrim(text, console_len), content_end)
  return(res)
}
