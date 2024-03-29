% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dynamic-templates.R
\name{template_id}
\alias{template_id}
\title{template id}
\usage{
template_id(sg_mail, template_id, force = FALSE)
}
\arguments{
\item{sg_mail}{(required) mail object from package}

\item{template_id}{(required) template_id start "d-" and 32-length only digit and lower case alphabet like "d-4ad23ad40a0e47d0a0232b85f24ca5c2"}

\item{force}{pass template_id validation. default is FALSE.}
}
\value{
sg_mail class with template id.
}
\description{
Create dynamic templates at \url{https://mc.sendgrid.com/dynamic-templates}
}
\examples{

mail()\%>\%
  template_id("d-4ad23ad40a0e47d0a0232b85f24ca5c2")

mail() \%>\%
  template_id("foo", force = TRUE)
}
