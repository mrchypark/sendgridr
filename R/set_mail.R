
#' Set mail class for Sendgrid
#'
#' New mail class for sendgrid.
#'
#' @return sg_mail class.
#' @examples
#' mail()
#' @export
mail <- function() {
  res <- list(
    from = "",
    personalizations = list(),
    subject = "",
    content = list()
  )
  class(res) <- c("sg_mail", "list")
  return(res)
}

address <- function(locate) {
  func <- function(sg_mail, email, name = "") {
    if (!sg_mail_chk(sg_mail)) {
      stop("please check sg_mail class")
    }
    if (!email_chk(email)) {
      stop("please check email address.")
    }
    loc_group <- sg_mail$personalizations[[locate]]

    if (name == "") {
      mail_list <- list(email = unbox(email))
    } else {
      mail_list <- list(email = unbox(email), name = unbox(name))
    }

    loc_group[[length(loc_group) + 1]] <- mail_list

    sg_mail$personalizations[locate] <- list(loc_group)

    return(sg_mail)
  }
  return(func)
}

#' set address to sg_mail class
#'
#' to(), cc(), bcc() is for set email address to sg_mail class
#'
#' @aliases to cc bcc
#' @param sg_mail (required)mail object from package
#' @param email (required)email address
#' @param name (optional)name for email address.
#' @return sg_mail class with mail address.
#' @examples
#' mail() %>%
#'   to("mrchypark@gmail.com")
#'
#' mail() %>%
#'   cc("mrchypark@gmail.com")
#'
#' mail() %>%
#'   bcc("mrchypark@gmail.com")
#' @name address
NULL

#' @export
#' @rdname address
to <- address("to")

#' @export
#' @rdname address
cc <- address("cc")

#' @export
#' @rdname address
bcc <- address("bcc")

#' from
#'
#' @param sg_mail (required)mail object from package
#' @param email (required)email address
#' @param name name for email address
#' @export
#' @return sg_mail class with from mail address.
#' @examples
#' mail() %>%
#'   from("mrchypark@gmail.com")
from <- function(sg_mail, email, name = "") {
  if (!sg_mail_chk(sg_mail)) {
    stop("please check sg_mail class")
  }
  if (!email_chk(email)) {
    stop("please check email address.")
  }
  mail_list <-
    list(
      email = jsonlite::unbox(email),
      name = jsonlite::unbox(name)
    )
  sg_mail[["from"]] <- mail_list
  return(sg_mail)
}

#' Add dynamic template data
#'
#' \code{template_id} must be included for this data to be applied.
#'
#' @param sg_mail (required) mail object from package
#' @param lst A key-value list for template data. (See \url{https://docs.sendgrid.com/ui/sending-email/how-to-send-an-email-with-dynamic-transactional-templates})
#'
#' @return
#' @export
#'
#' @examples
#' data_lst <-
#'   list(
#'     first_name = "Amanda",
#'     link = "foo"
#'   )
#'
#' mail() %>%
#'   dynamic_template_data(data_lst)
dynamic_template_data <- function(sg_mail, lst) {
  if (!sg_mail_chk(sg_mail)) {
    stop("please check sg_mail class")
  }

  sg_mail$personalizations[["dynamic_template_data"]] <- lst

  return(sg_mail)
}

#' subject
#'
#' @param sg_mail (required)mail object from package
#' @param subject (required)mail subject
#' @export
#' @return sg_mail class with subject.
#' @examples
#' mail() %>%
#'   subject("mrchypark@gmail.com")
subject <- function(sg_mail, subject) {
  sg_mail[["subject"]] <- jsonlite::unbox(subject)
  return(sg_mail)
}

#' template id
#'
#' Create dynamic templates at \url{https://mc.sendgrid.com/dynamic-templates}
#'
#' @param sg_mail (required) mail object from package
#' @param template_id (required) template_id
#'
#' @return
#' @export
#'
#' @examples
#' mail() %>%
#'   template_id("foo")
template_id <- function(sg_mail, template_id) {
  sg_mail[["template_id"]] <- jsonlite::unbox(template_id)
  return(sg_mail)
}

#' body
#'
#' @param sg_mail (required)mail object from package
#' @param body (required)mail content html support.
#' @param type content type. text/html is default.
#' @return sg_mail class with body content.
#' @examples
#' mail() %>%
#'   body("mrchypark@gmail.com")
#' @export
body <- function(sg_mail, body, type = "text/html") {
  if (!sg_mail_chk(sg_mail)) {
    stop("please check sg_mail class")
  }
  body <- data.frame(
    type = type,
    value = read(body),
    stringsAsFactors = F
  )
  sg_mail[["content"]] <- body
  return(sg_mail)
}

#' @importFrom fs is_file
#' @importFrom stringr str_sub
read <- function(content) {
  if (is.character(content)) {
    chk <- stringr::str_sub(content, 1, 10000)
  } else {
    stop("content can contain characters only")
  }
  if (fs::is_file(chk)) {
    content <- readLines(content)
    content <- paste0(content, collapse = "\n")
    # content <- juicer::juice(content)
  }
  content <- as.character(content)
  return(content)
}

#' attachments
#'
#' @param sg_mail (required)mail object from package
#' @param path (required)file path to attach
#' @param name file name. default is path's file name
#' @importFrom base64enc base64encode
#' @importFrom fs is_file
#' @importFrom dplyr filter
#' @return sg_mail class with attachments.
#' @examples
#' \dontrun{
#' mail() %>%
#'   attachments("sendgridr.docx")
#' }
#' @export
attachments <- function(sg_mail, path, name) {
  . <- Extension <- NULL

  if (!fs::is_file(path)) {
    stop("Please make sure it is the correct file path.")
  }

  exten <- strsplit(path, ".", fixed = T)[[1]]
  exten <- tolower(exten[length(exten)])
  mime_types %>%
    dplyr::filter(grepl(paste0("^.", exten, "$"), Extension)) %>%
    .$`MIME Type` -> type

  if (identical(type, character(0))) {
    type <- "application/octet-stream"
  }

  content <- base64enc::base64encode(path)
  if (missing(name)) {
    filename <- strsplit(path, "[\\/\\]")[[1]]
    filename <- filename[length(filename)]
  } else {
    filename <- name
  }

  attached <- sg_mail[["attachments"]]
  if (is.null(attached)) {
    attachments <-
      data.frame(content, filename, type, stringsAsFactors = F)
    sg_mail[["attachments"]] <- attachments
  } else {
    attachments <-
      data.frame(content, filename, type, stringsAsFactors = F)
    sg_mail[["attachments"]] <- rbind(attached, attachments)
  }
  return(sg_mail)
}

email_chk <- function(email) {
  grepl(
    "^([a-z0-9_\\.-]+)@([0-9a-z\\.-]+)\\.([a-z\\.]{2,6})$",
    email
  )
}

sg_mail_chk <- function(sg_mail) {
  any(class(sg_mail) == "sg_mail")
}
