# url <- "https://fictionhorizon.com/all-classroom-of-the-elite-opening-quotes-in-order/"

scrape_quotes <- function(url) {
  html_raw <- rvest::read_html_live(url = url)

  quotes_raw <- html_raw |>
    rvest::html_elements(css = "h3.wp-block-heading") |>
    rvest::html_text() |>
    stringr::str_replace(pattern = "19\\:", replacement = "19.")

  tibble::tibble(raw = quotes_raw) |>
    tidyr::separate_wider_regex(
      cols = raw,
      patterns = c(
        id = "^\\d+\\.\\s",
        episode = "Episode \\d+\\:\\s",
        quote = "\\“.*\\”",
        author = "\\–?.*$"
      )
    ) |>
    dplyr::mutate(
      dplyr::across(.cols = c(id, episode), .fns = \(x) {
        stringr::str_extract(string = x, pattern = "\\d+") |> as.numeric()
      }),
      quote = stringr::str_remove_all(string = quote, pattern = "(\\“|\\”)"),
      author = stringr::str_remove_all(string = author, pattern = "\\s+\\–\\s"),
      season = rep(x = 1:3, times = c(12, 13, 13))
    )
}
