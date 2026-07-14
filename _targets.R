# Source R functions

r_paths <- list.files(
  path = here::here("R"),
  pattern = "\\.R$",
  full.names = TRUE
)

lapply(X = r_paths, FUN = source) |> invisible()


list(
  # Scrape quotes ----
  targets::tar_target(
    quotes_data,
    scrape_quotes(
      url = "https://fictionhorizon.com/all-classroom-of-the-elite-opening-quotes-in-order/"
    )
  ),

  # Create report ----
  tarchetypes::tar_quarto(
    report,
    path = here::here("reporting/report.qmd"),
    cue = targets::tar_cue("always")
  )
)
