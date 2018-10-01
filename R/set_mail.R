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
#' @export
to <- address("to")

#' cc
#'
#' @export
cc <- address("cc")

#' bcc
#'
#' @export
bcc <- address("bcc")

#' from
#'
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
#' @export
#' @importFrom jsonlite unbox

subject <- function(mail, title) {
  mail[["subject"]] <- unbox(title)
  return(mail)
}

#' content
#'
#' @export

content <- function(mail, content){

  contents <- data.frame(type = "text/html",
                   value = content)
  mail[["content"]] <- contents
  return(mail)
}

#' attachments
#'
#' @import mime
#' @importFrom jsonlite base64_enc
attachments <- function(mail, path, name) {
  content <- base64_enc(path)
  type <- guess_type(path)
}


#' email_chk
#'
#' @export
email_chk <- function(email){
  grepl("^([a-z0-9_\\.-]+)@([0-9a-z\\.-]+)\\.([a-z\\.]{2,6})$", email)
}
