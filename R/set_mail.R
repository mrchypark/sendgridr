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
  class(res) <- "sg_mail"
  return(res)
}

#' address
#'
#' @param locate where to set mail address
#' @importFrom jsonlite unbox
address <- function(locate) {
  func <- function(sg_mail, email, name = "") {
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
#' @param sg_mail mail object from package
#' @param email email address
#' @param name name for email address
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
#' @param mail mail object from package
#' @param email email address
#' @param name name for email address
#' @export
#' @importFrom jsonlite unbox

from <- function(mail, email, name = "") {
  if (name == "") {
    mail_list <- list(email = unbox(email))
  } else {
    mail_list <- list(email = unbox(email), name = unbox(name))
  }
  mail[["from"]] <- mail_list
  return(mail)
}

#' subject
#'
#' @param mail mail object from package
#' @param subject mail subject
#' @export
#' @importFrom jsonlite unbox

subject <- function(mail, subject) {
  mail[["subject"]] <- unbox(subject)
  return(mail)
}

#' content
#'
#' @param mail mail object from package
#' @param content mail content
#' @export

content <- function(mail, content) {
  contents <- data.frame(type = "text/html",
                         value = content,
                         stringsAsFactors = F)
  mail[["content"]] <- contents
  return(mail)
}

#' attachments
#'
#' @param mail mail object from package
#' @param path file path to attach
#' @param name file name. default is path's file name
#' @importFrom base64enc base64encode
#' @export
attachments <- function(mail, path, name) {
  content <- base64enc::base64encode(path)
  if (missing(name)) {
    filename <- strsplit(path,"[\\/\\]")[[1]]
    filename <- filename[length(filename)]
  } else {
    filename <- name
  }

  attachments <- data.frame(content, filename, stringsAsFactors = F)
  mail[["attachments"]] <- attachments
  return(mail)
}


#' email_chk
#'
#' @param email email address to check
#' @export
email_chk <- function(email) {
  grepl("^([a-z0-9_\\.-]+)@([0-9a-z\\.-]+)\\.([a-z\\.]{2,6})$",
        email)
}
