library(hexSticker)
imgurl <-
  "https://kasunkodagoda.gallerycdn.vsassets.io/extensions/kasunkodagoda/sendgrid-email/2.0.1/1529945827053/Microsoft.VisualStudio.Services.Icons.Default"
# for mac
sticker(
  imgurl,
  package = "SendGridR",
  p_size = 6,
  s_x = 1,
  s_y = 0.8,
  s_width = 0.5,
  filename = "man/figures/logo.png",
  h_fill = "#214663",
  p_color = "#FFFFFF",
  h_color = "#489be8",
  url = "mrchypark.github.io",
  u_size = 2.3,
  u_color = "darkgray"
)
# for windows
sticker(
  imgurl,
  package = "SendGridR",
  p_size = 18,
  s_x = 1,
  s_y = 0.8,
  s_width = 0.5,
  filename = "man/figures/logo.png",
  h_fill = "#214663",
  p_color = "#FFFFFF",
  h_color = "#489be8",
  url = "mrchypark.github.io",
  u_size = 2.3,
  u_color = "darkgray"
)
