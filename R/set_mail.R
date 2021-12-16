


#' Set mail class for Sendgrid
#'
#' New mail class for sendgrid.
#'
#' @return sg_mail class.
#' @importFrom jsonlite unbox
#' @examples
#' mail()
#' @export
mail <- function() {
  res <- list(
    from = "",
    personalizations = list(),
    subject = "",
    content = list(type = "text/plain",
      value = "")
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
      mail_list <- list(email = jsonlite::unbox(email))
    } else {
      mail_list <-
        list(email = jsonlite::unbox(email),
          name = jsonlite::unbox(name))
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
    list(email = jsonlite::unbox(email),
      name = jsonlite::unbox(name))
  sg_mail[["from"]] <- mail_list
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
  if (!sg_mail_chk(sg_mail)) {
    stop("please check sg_mail class")
  }

  sg_mail[["subject"]] <- jsonlite::unbox(subject)
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
  body <- data.frame(type = type,
    value = read(body),
    stringsAsFactors = F)
  sg_mail[["content"]] <- body
  return(sg_mail)
}

#' @importFrom fs is_file
read <- function(content) {
  if (!is.character(content)) {
    stop("content can contain characters only")
  }
  if (fs::is_file(content)) {
    content <- readLines(content)
    content <- paste0(content, collapse = "\n")
  }
  content <- as.character(content)
  return(content)
}

#' attachments
#'
#' @param sg_mail (required)mail object from package
#' @param path (required)file path to attach
#' @param name file name. default is path's file name
#' @param content_id content id. default is Null.
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
attachments <- function(sg_mail, path, name, content_id) {
  . <- Name <- NULL

  if (!sg_mail_chk(sg_mail)) {
    stop("please check sg_mail class")
  }

  if (!fs::is_file(path)) {
    stop("Please make sure it is the correct file path.")
  }

  exten <- strsplit(path, ".", fixed = T)[[1]]
  exten <- tolower(exten[length(exten)])
  mime_types %>%
    dplyr::filter(grepl(paste0("^", exten, "$"), Name)) %>%
    .$Template -> type

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
  if (missing(content_id)) {
    attachments <-
      data.frame(content, filename, type,
        stringsAsFactors = F)
  } else {
    disposition <- "inline"
    attachments <-
      data.frame(content,
        filename,
        type,
        disposition,
        content_id,
        stringsAsFactors = F)
  }
  if (is.null(attached)) {
    sg_mail[["attachments"]] <- attachments
  } else {
    sg_mail[["attachments"]] <- rbind(attached, attachments)
  }
  return(sg_mail)
}

email_chk <- function(email) {
  grepl("^([a-z0-9_\\.-]+)@([0-9a-z\\.-]+)\\.([a-z\\.]{2,6})$",
    email)
}

sg_mail_chk <- function(sg_mail) {
  any(class(sg_mail) == "sg_mail")
}
