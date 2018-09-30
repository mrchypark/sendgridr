#' set mail object
#'
#' @export

mail <- function() {
  res <- list(
    personalizations = list(),
    from = list(),
    subject = "",
    content = list()
    )
  return(res)
}

#' address
#'
#' @export
address <- function(locate){
  func <- function(mail, email, name = ""){
    if(!email_chk(email)){
      stop("please check email address.")
    }

    loc_group <- mail$personalizations[[locate]]

    if(name == ""){
      mail_list <- list(email = email)
    } else {
      mail_list <- list(email = email, name = name)
    }

    loc_group[[length(loc_group)+1]] <- mail_list

    mail$personalizations[[locate]] <- loc_group

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

from <- function(mail, email, name) {

}

#' subject
#'
#' @export

subject <- function(mail, title) {

}

#' content
#'
#' @export

content <- function(mail, content){

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
