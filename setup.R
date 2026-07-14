# Create reproducible environment
rix::rix(
  shell_hook = "export QUARTO_R=${pkgs.R}/bin/R; unset QUARTO_PANDOC QUARTO_PATH",
  r_ver = "4.4.0",
  r_pkgs = c(
    "chromote",
    "here",
    "quarto",
    "rvest",
    "stringr",
    "tarchetypes",
    "targets",
    "tibble",
    "tidyr"
  ),
  system_pkgs = "quarto",
  git_pkgs = NULL,
  ide = "other",
  project_path = ".",
  overwrite = TRUE,
  print = TRUE
)

# Create CI/CD pipeline
rix::tar_nix_ga()
