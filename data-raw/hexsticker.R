i <- magick::image_read("https://www.marxists.org/archive/lenin/photo/head.jpg")
i <- magick::image_convert(i, type = "Grayscale")

magick::image_write(
  i,
  path = file.path("man", "figures", "lenin_greyscale.png"),
  format = "png"
)

hexSticker::sticker(
  file.path("man", "figures", "lenin_greyscale.png"),
  package = "leninature",
  p_y = 0.5,
  p_color = "red",
  p_size = 8,
  p_fontface = "bold",
  h_color = "red",
  h_fill = "white",
  s_width = 0.5,
  s_height = 0.5,
  s_y = 1.1,
  s_x = 1,
  filename = file.path("man", "figures", "leninsticker.png"),
  white_around_sticker = FALSE,
  dpi = 150
)
s <- magick::image_read(file.path("man", "figures", "leninsticker.png"))
s_tiny <- magick::image_scale(s, "150")
magick::image_write(
  s_tiny,
  path = file.path("man", "figures", "leninsticker_tiny.png"),
  format = "png"
)

