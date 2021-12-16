#' Print for sg_mail class
#'
#' @param x sg_mail class object
#' @param ... pass for default print. But not use in sg_mail class.
#' @importFrom usethis ui_todo ui_done
#' @export
print.sg_mail <- function(x, ...) {
  cat("SendGrid Mail - \n")

  # print from
  if (!is.list(x$from)) {
    ui_need("  from   : (required)")
  } else {
    if (is.null(x$from$name)) {
      address <- x$from$email
    } else {
      address <- paste0(x$from$name, " <",
        x$from$email, ">")
    }
    usethis::ui_done("  from   : ", address)
  }

  # print to, cc, bcc
  per <- x
  x$personalizations[["dynamic_template_data"]] <- NULL
  if (length(x$personalizations) == 0) {
    ui_need("  to     : (required)")
  } else {
    to_check <- names(x$personalizations)
    if (!any(to_check == "to")) {
      ui_need("  to     : (required)")
    }
    for (i in 1:(length(x$personalizations))) {
      locate <- names(x$personalizations)[i]
      address_list <- c()
      for (j in 1:length(x$personalizations[[i]])) {
        if (is.null(x$personalizations[[i]][[j]]$name)) {
          address <- x$personalizations[[i]][[j]]$email
        } else {
          address <- paste0(x$personalizations[[i]][[j]]$name,
            " <",
            x$personalizations[[i]][[j]]$email,
            ">")
        }
        address_list <- paste0(address_list, ", ", address)
        cnt <- j
      }
      address_list <- gsub("^, ", "", address_list)
      if (locate == "to") {
        text <-
          paste0("  ", locate, "     : cnt[", cnt, "] ", address_list)
        usethis::ui_done(console_print(text))
      } else {
        if (locate == "cc") {
          text <-
            paste0("  ", locate, "     : cnt[", cnt, "] ", address_list)
          ui_option(console_print(text))
        } else {
          text <-
            paste0("  ", locate, "    : cnt[", cnt, "] ", address_list)
          ui_option(console_print(text))
        }
      }
    }
  }

  x <- per
  # print subject
  if (nchar(x$subject) == 0) {
    ui_need("  subject: (required)")
  } else {
    text <-
      paste0("  subject: ", "nchr[", nchar(x$subject), "] ", x$subject)
    usethis::ui_done(console_print(text))
  }

  # check dynamic_template_data
  if (is.null(x$template_id)) {
    # print content
    if (nchar(x$content$value) == 0) {
      ui_need("  content: (required)")
    } else {
      text <-
        paste0("  content: ",
          "nchr[",
          nchar(x$content$value),
          "] ",
          x$content$value)
      usethis::ui_done(console_print(text))
    }
  } else {
    # print dynamic_template_data
    text <-
      paste0("  template_id: ",
        "nchr[",
        nchar(x$template_id),
        "] ",
        x$template_id)
    usethis::ui_done(console_print(text))
    usethis::ui_done("    data: json below")
    print(jsonlite::toJSON(
      x$personalizations[["dynamic_template_data"]],
      auto_unbox = TRUE,
      pretty = TRUE
    ))
  }


  # print attachments
  if (is.null(x$attachments)) {
    ui_option("  attach : (optional)")
  } else {
    attached <- paste0(x$attachments$filename, collapse = ", ")
    cnt <- length(x$attachments$filename)
    text <- paste0("attached : ", "cnt[", cnt, "] ", attached)
    ui_option(console_print(text))
  }
}

#' @importFrom cli cat_bullet
ui_need <- function(x) {
  cli::cat_bullet(x, bullet = "cross", bullet_col = "red")
}

#' @importFrom cli cat_bullet
ui_option <- function(x) {
  cli::cat_bullet(x, bullet = "tick", bullet_col = "lightgrey")
}


console_print <- function(text) {
  console_len <- options("width")$width - 20
  content_len <- nchar(text)
  content_end <- ifelse(content_len > console_len, " ...", "")
  res <- paste0(strtrim(text, console_len), content_end)
  return(res)
}
