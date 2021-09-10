#! /usr/bin/env Rscript
library(readr)
library(styler)
library(optparse)

OptionParser(option_list = list(make_option(c("-i", "--in-place"), action = "store_true", default = FALSE, help = "huh"))) -> parser
args <- commandArgs(trailingOnly = TRUE)
args


parse_args(parser, positional_arguments = TRUE, args = args) -> result

if (result$options$`in-place`) {
  style_file(result$args[1])
  q(status = 0)
} else {
  style_text(read_file(result$args[1]))
}



# # vim: ft=R
