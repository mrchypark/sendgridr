#' set mail object
#'
#' @export

mail <- function() {
  res <- list(
    personalizations = list(),
    from = "",
    subject = "",
    content = list()
    )
  return(res)
}

#' address
#'
#' @param locate where to set mail address
#' @importFrom jsonlite unbox
address <- function(locate){
  func <- function(mail, email, name = ""){
    if(!email_chk(email)){
      stop("please check email address.")
    }

    loc_group <- mail$personalizations[[locate]]

    if(name == ""){
      mail_list <- list(email = unbox(email))
    } else {
      mail_list <- list(email = unbox(email), name = unbox(name))
    }

    loc_group[[length(loc_group)+1]] <- mail_list

    mail$personalizations[locate] <- list(loc_group)

    return(mail)
  }
  return(func)
}

#' to
#'
#' @param mail mail object from package
#' @param email email address
#' @param name name for email address
#' @export
to <- address("to")

#' cc
#'
#' @param mail mail object from package
#' @param email email address
#' @param name name for email address
#' @export
cc <- address("cc")

#' bcc
#'
#' @param mail mail object from package
#' @param email email address
#' @param name name for email address
#' @export
bcc <- address("bcc")

#' from
#'
#' @param mail mail object from package
#' @param email email address
#' @param name name for email address
#' @export
#' @importFrom jsonlite unbox

from <- function(mail, email, name="") {
  if(name == ""){
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

content <- function(mail, content){

  contents <- data.frame(type = "text/html",
                   value = content)
  mail[["content"]] <- contents
  return(mail)
}

#' attachments
#'
#' @param mail mail object from package
#' @param path file path to attach
#' @param name file name
#' @import mime
#' @importFrom jsonlite base64_enc
attachments <- function(mail, path, name) {
  content <- base64_enc(path)
  type <- guess_type(path)
}


#' email_chk
#'
#' @param email email address to check
#' @export
email_chk <- function(email){
  grepl("^([a-z0-9_\\.-]+)@([0-9a-z\\.-]+)\\.([a-z\\.]{2,6})$", email)
}
