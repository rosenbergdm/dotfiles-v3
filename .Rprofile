# .Rprofile
#  Local R settings

# local({
# options(repos = c(
#   CRAN = "https://mirror.las.iastate.edu/CRAN",
#   BioCsoft = "https://bioconductor.org/packages/3.11/bioc",
#   BioCann = "https://bioconductor.org/packages/3.11/data/annotation",
#   BioCexp = "https://bioconductor.org/packages/3.11/data/experiment",
#   CRANextra = "https://www.stats.ox.ac.uk/pub/RWin",
#   Omegahat = "http://www.omegahat.net/R",
#   `R-Forge` = "https://R-Forge.R-project.org",
#   rforge.net = "https://www.rforge.net"
# ))
# })

# options(stringsAsFactors = TRUE) # matches R 4.0
options(repos = c(
  CRAN = "https://rweb.crmda.ku.edu/cran",
  BioCsoft = "https://bioconductor.org/packages/3.13/bioc",
  BioCann = "https://bioconductor.org/packages/3.13/data/annotation",
  BioCexp = "https://bioconductor.org/packages/3.13/data/experiment",
  CRANextra = "https://www.stats.ox.ac.uk/pub/RWin"
  # `R-Forge` = "https://R-Forge.R-project.org",
  # rforge.net = "https://www.rforge.net"
))
home <- Sys.getenv("HOME")
options(pager = "/opt/homebrew/bin/less")
options(help_type = "html")
options(warn = -1) # disable warnings
options(max.print = 500)
options(scipen = 10)
# options(editor = "$HOME/.local/bin/lvim")
options(editor = Sys.getenv("VISUAL"))
if (interactive()) {
  options(width = as.integer(system("tput cols", intern = TRUE)))
  options(error = utils::recover)
} else {
  options(width = 80)
  options(error = utils::dump.frames)
}
options(devtools.install.args = c(
  "--with-keep.source",
  "--with-keep.parse.data",
  "--example",
  "--html",
  "--build-vignettes"
))
options(help.try.all.packages = TRUE)
options(papersize = "letter")
options(keep.source.pkgs = TRUE)
options(keep.parse.data.pkgs = TRUE)
utils::rc.settings(ipck = TRUE)

suppress_load_message <- function(pkgname) {
  suppressWarnings(suppressPackageStartupMessages(library(pkgname, character.only = TRUE)))
}

auto_loads <- c("devtools", "roxygen2")
if (interactive()) {
  invisible(sapply(auto_loads, suppress_load_message))
}

if (Sys.getenv("TERM") %in% c("xterm-256color", "kitty", "alacritty") ) {
  if (commandArgs()[1] != "radian") {
    if ("colorout" %in% rownames(utils::installed.packages())) {
      suppress_load_message("colorout")
      # invisible(setOutputColors(
      #   normal = "\x1b[38;2;0;200;0m", # red = 0; green = 200; blue = 0
      #   negnum = "\x1b[38;2;255;200;0m",
      #   zero = "\x1b[38;2;255;255;0m",
      #   number = "\x1b[38;2;200;255;75m",
      #   date = "\x1b[38;2;155;155;255m",
      #   string = "\x1b[38;2;0;255;175m",
      #   const = "\x1b[38;2;0;255;255m",
      #   false = "\x1b[38;2;255;125;125m",
      #   true = "\x1b[38;2;125;255;125m",
      #   infinite = "\x1b[38;2;75;75;255m",
      #   index = "\x1b[38;2;00;150;80m",
      #   stderror = "\x1b[38;2;255;0;255m",
      #   warn = "\x1b[38;2;255;0;0m",
      #   error = "\x1b[38;2;255;255;255;48;2;255;0;0m",
      #   zero.limit = 0.01, verbose = FALSE
      # ))
    } else {
      cat("'Colorout not installed\n")
    }
  }
}

.rprofile_env <- new.env()
attach(.rprofile_env)
.rprofile_env$auto_loads <- auto_loads
.rprofile_env$suppress_load_message <- suppress_load_message
.rprofile_env$unrowname <- function(x) {
  rownames(x) <- NULL
  x
}

# .rprofile_env$original_plus <- `+`
# .rprofile_env$overload_plus_character <- function() {
#   cat(
#     "Overloading the `+` operator for strings to allow concatenation.",
#     "Please don't use this in scripts.  Use .rprofile_env$unoverload_plus_character() to ",
#     "revert behavior.",
#     sep = "\n"
#   )
#   .GlobalEnv[["+"]] <- function(...) UseMethod("+")
#   .GlobalEnv[["+.default"]] <- .Primitive("+")
#   .GlobalEnv[["+.character"]] <- function(...) {
#     arg_list <- list(...)
#     if (!is.character(arg_list[[2]])) {
#       stop(simpleError(message = paste0(
#         "Attempting to use + with character and another type while overloading ",
#         "+ is not a good idea.  Use .rprofile_env$unoverload_plus_character() ",
#         "to revert to default behavior",
#         sep = "", collapse = ""
#       )))
#     } else {
#       paste(..., sep = "")
#     }
#   }
# }

# .rprofile_env$unoverload_plus_character <- function() {
#   if ("+" %in% ls(.GlobalEnv)) {
#     rm("+", envir = .GlobalEnv)
#   }
# }

# .rprofile_env$unfactor <- function(df) {
#   id <- sapply(df, is.factor)
#   df[id] <- lapply(df[id], as.character)
#   df
# }
# rm(list = c("auto_loads", "suppress_load_message"))

# if (interactive()) {
#   package_string <- paste("`", paste(.rprofile_env$auto_loads, collapse = "`, `"), "`", sep = "")
#   message(paste("*** Successfully loaded .Rprofile including packages ", package_string, " ***", sep = ""))
#   rm(package_string)
#   # .rprofile_env$overload_plus_character()
# }

# .rprofile_env$style_in_place <- function(fname, backup = FALSE) {
#   if (backup) {
#     bkfile <- tempfile(pattern = "styler")
#     file.copy(fname, bkfile, overwrite = TRUE)
#   }
#   styler::style_file(fname)
# }

setHook(
  packageEvent("languageserver", "onLoad"),
  function(...) {
    require("lintr")
    # options(languageserver.default_linters = lintr::with_defaults(
    #   lintr::line_length_linter(120),
    #   object_usage_linter = NULL,
    #   object_name_linter = NULL
    # ))
  }
)
source("~/lib/R/dmr-fns.R")
# vim: ft=R
