library(rvest)
library(dplyr)
library(tibble)

tar <- "https://developer.mozilla.org/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Complete_list_of_MIME_types"

read_html(tar) %>%
  html_nodes("table.standard-table") %>%
  html_table() %>%
  .[[1]] %>%
  as_tibble() -> mime_types

use_data(mime_types, internal = T, overwrite = T)
