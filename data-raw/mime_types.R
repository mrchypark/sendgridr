library(rvest)
library(dplyr)
library(tidyr)
library(stringr)
library(tibble)
#
# tar <- "https://www.iana.org/assignments/media-types/media-types.xhtml"
#
# read_html(tar) |>
#   html_nodes("table") -> htmls
#
# htmls[htmls |>
#   as.character() |>
#   str_which('id="table-')] |>
#   html_table() |>
#   bind_rows() |>
#   select(Name, Template) -> mime_types

tar <- "https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types"

read_html(tar) |>
  html_nodes("table")  |>
  html_table() |>
  (\(x) x[[1]])() |>
  rename(Template = `MIME Type`, Name = Extension) |>
  select(Name, Template) -> ppmt

ppmt |>
  filter(str_detect(Name, fixed(" ."))) |>
  mutate(Names = str_split(Name, " ")) |>
  select(Names, Template) |>
  unnest(cols = c(Names)) |>
  rename(Name = Names) |>
  bind_rows(
    ppmt |>
      filter(!str_detect(Name, fixed(" .")))
  ) |>
  mutate(Name = str_replace_all(Name, fixed("."),"")) -> mime_types
#
# mime_types |>
#   filter(Template != "") |>
#   bind_rows(ppmts) |>
#   mutate(Name = str_to_lower(Name)) |>
#   distinct() -> mime_types

use_data(mime_types, internal = T, overwrite = T)
