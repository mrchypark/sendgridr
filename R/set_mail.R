#' set mail class for sendgrid
#'
#' @export
mail <- function() {
  res <- list(
    personalizations = list(),
    from = "",
    subject = "",
    content = list()
  )
  class(res) <- c("sg_mail","list")
  return(res)
}

#' address
#'
#' @param locate where to set mail address
#' @importFrom jsonlite unbox
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
#' @importFrom jsonlite unbox

from <- function(sg_mail, email, name = "") {
  if (!sg_mail_chk(sg_mail)) {
    stop("please check sg_mail class")
  }
  if (!email_chk(email)) {
    stop("please check email address.")
  }
  if (name == "") {
    mail_list <- list(email = unbox(email))
  } else {
    mail_list <- list(email = unbox(email), name = unbox(name))
  }
  sg_mail[["from"]] <- mail_list
  return(sg_mail)
}

#' subject
#'
#' @param sg_mail (required)mail object from package
#' @param subject (required)mail subject
#' @export
#' @importFrom jsonlite unbox

subject <- function(sg_mail, subject) {
  sg_mail[["subject"]] <- unbox(subject)
  return(sg_mail)
}

#' content
#'
#' @param sg_mail (required)mail object from package
#' @param content (required)mail content html support.
#' @export

content <- function(sg_mail, content) {
  if (!sg_mail_chk(sg_mail)) {
    stop("please check sg_mail class")
  }
  contents <- data.frame(type = "text/html",
                         value = read(content),
                         stringsAsFactors = F)
  sg_mail[["content"]] <- contents
  return(sg_mail)
}

#' @importFrom juicer juice
#' @importFrom fs is_file
read <- function(content) {
  if (fs::is_file(content)) {
    content <- readLines(content)
    content <- juicer::juice(content)
  }
  content <- as.character(content)
  return(content)
}

#' attachments
#'
#' @param sg_mail (required)mail object from package
#' @param path (required)file path to attach
#' @param name file name. default is path's file name
#' @param content_id content id(cid). default is `content_id``
#' @importFrom base64enc base64encode
#' @importFrom fs is_file
#' @importFrom dplyr filter
#' @export
attachments <- function(sg_mail, path, name, content_id) {
  . <- Extension <- NULL

  if (!fs::is_file(path)) {
    stop("Please make sure it is the correct file path.")
  }

  exten <- strsplit(path, ".", fixed = T)[[1]]
  exten <- tolower(exten[length(exten)])
  mime_types %>%
    filter(grepl(exten, Extension)) %>%
    .$`MIME Type` -> type

  content <- base64enc::base64encode(path)
  if (missing(name)) {
    filename <- strsplit(path,"[\\/\\]")[[1]]
    filename <- filename[length(filename)]
  } else {
    filename <- name
  }

  if (missing(content_id)) {
    content_id <- "content_id"
  } else {
    content_id <- content_id
  }
  attached <- sg_mail[["attachments"]]
  if (is.null(attached)) {
    attachments <- data.frame(content, filename, type, content_id, stringsAsFactors = F)
    sg_mail[["attachments"]] <- attachments
  } else {
    attachments <- data.frame(content, filename, type, content_id, stringsAsFactors = F)
    sg_mail[["attachments"]] <- rbind(attached, attachments)
  }
  return(sg_mail)
}


#' email_chk
#'
#' @param email email address to check
email_chk <- function(email) {
  grepl("^([a-z0-9_\\.-]+)@([0-9a-z\\.-]+)\\.([a-z\\.]{2,6})$", email)
}

#' mail_class_chk
#'
#' @param sg_mail mail class to check
sg_mail_chk <- function(sg_mail){
  any(class(sg_mail) == "sg_mail")
}
