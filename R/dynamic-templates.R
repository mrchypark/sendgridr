#' Add dynamic template
#'
#' Create dynamic templates at \url{https://mc.sendgrid.com/dynamic-templates}.
#'
#' @param sg_mail (required) mail object from package
#' @param template_id (required) template_id start "d-" and 32-length only digit and lower case alphabet like "d-4ad23ad40a0e47d0a0232b85f24ca5c2"
#' @param template_data A key-value list for template data. (See \url{https://docs.sendgrid.com/ui/sending-email/how-to-send-an-email-with-dynamic-templates})
#' @param force pass template_id validation. default is FALSE.
#' @return sg_mail class with dynamic template
#' @importFrom jsonlite unbox
#' @export
#'
#' @examples
#' mail() %>%
#'   dynamic_template("d-4ad23ad40a0e47d0a0232b85f24ca5c2", list(first_name = "Amanda", link = "foo"))
#'
#' mail() %>%
#'   dynamic_template(template_id = "foo",
#'     template_data = list(first_name = "Amanda", link = "foo"),
#'     force = TRUE)
dynamic_template <- function(sg_mail, template_id, template_data, force = FALSE){
  if (!sg_mail_chk(sg_mail)) {
    stop("please check sg_mail class")
  }
  if (!force) {
    if (!template_id_chk(template_id)) {
      stop("please check template_id value.")
    }
  }
  sg_mail[["template_id"]] <- jsonlite::unbox(template_id)
  sg_mail$personalizations[["dynamic_template_data"]] <- template_data
  return(sg_mail)
}



#' template id
#'
#' Create dynamic templates at \url{https://mc.sendgrid.com/dynamic-templates}
#'
#' @param sg_mail (required) mail object from package
#' @param template_id (required) template_id start "d-" and 32-length only digit and lower case alphabet like "d-4ad23ad40a0e47d0a0232b85f24ca5c2"
#' @param force pass template_id validation. default is FALSE.
#'
#' @return sg_mail class with template id.
#' @importFrom jsonlite unbox
#' @export
#'
#' @examples
#'
#' mail()%>%
#'   template_id("d-4ad23ad40a0e47d0a0232b85f24ca5c2")
#'
#' mail() %>%
#'   template_id("foo", force = TRUE)
template_id <- function(sg_mail, template_id, force = FALSE) {
  if (!sg_mail_chk(sg_mail)) {
    stop("please check sg_mail class")
  }
  if (!force) {
    if (!template_id_chk(template_id)) {
      stop("please check template_id value.")
    }
  }

  sg_mail[["template_id"]] <- jsonlite::unbox(template_id)
  return(sg_mail)
}


#' Add dynamic template data
#'
#' \code{template_id} must be included for this data to be applied.
#'
#' @param sg_mail (required) mail object from package
#' @param data A key-value list for template data. (See \url{https://docs.sendgrid.com/ui/sending-email/how-to-send-an-email-with-dynamic-templates})
#'
#' @return sg_mail class with template data for dynamic transactional templates
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
#'   template_id("d-4ad23ad40a0e47d0a0232b85f24ca5c2")%>%
#'   dynamic_template_data(data_lst)
dynamic_template_data <- function(sg_mail, data) {
  if (!sg_mail_chk(sg_mail)) {
    stop("please check sg_mail class")
  }
  if (is.null(sg_mail[["template_id"]])) {
    stop("please set template_id first.\n  use template_id() function before dynamic_template_data().")
  }

  sg_mail$personalizations[["dynamic_template_data"]] <- data
  return(sg_mail)
}


template_id_chk <- function(template_id) {
  grepl(
    "^d-[a-z0-9]{32}$",
    template_id
  )
}
