#' Embeding Rmd on body with images.
#'
#' @param sg_mail (required) mail object from package
#' @param input (required) input file path to render for email.
#' @param ... extra params pass to emayili::render() function.
#'
#' @export
#' @examples
#' path <- system.file("extdata", "test.Rmd", package = "sendgridr")
#' mail() %>%
#'  embed_rmd(path)
#' @importFrom emayili render envelope
#' @importFrom base64enc base64encode
embed_rmd <- function(sg_mail, input, ...) {
  if (!sg_mail_chk(sg_mail)) {
    stop("please check sg_mail class")
  }
  rendered <- emayili::render(emayili::envelope(), input, ...)$parts[[1]]$children
  images <- c()

  for (i in 1:length(rendered)) {
    if (any(class(rendered[[i]]) %in% "text_html")) {
      content <- rendered[[i]]$content
    }
    if (grepl("image", rendered[[i]]$type)) {
      images <- c(images, list(rendered[[i]]))
    }
  }

  body <- data.frame(
    type = "text/html",
    value = content,
    stringsAsFactors = F
  )
  sg_mail[["content"]] <- body

  if (length(images) != 0) {
    disposition <- "inline"
    cont <- c()
    for (i in 1:length(images)) {
      content <- base64enc::base64encode(images[[i]]$content)
      filename <- images[[i]]$filename
      type <- strsplit(images[[i]]$type,";")[[1]][1]
      content_id <- images[[i]]$cid
      cont <- rbind(cont, data.frame(content, filename, type, disposition, content_id))
    }
    sg_mail[["attachments"]] <- cont
  }
  return(sg_mail)
}
