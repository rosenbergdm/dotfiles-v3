#! /usr/bin/env R
library(lintr)
my_linter <- with_defaults(line_length_linter(120),
  commented_code_linter = NULL
)
target_file <- commandArgs(trailingOnly = TRUE)
lint(target_file, linters = my_linter)



# vim: ft=R
