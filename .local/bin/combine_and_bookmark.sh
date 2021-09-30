#!/bin/bash

out_file="combined.pdf"
bookmarks_file="/tmp/bookmarks.txt"
bookmarks_fmt="BookmarkBegin
BookmarkTitle: %s
BookmarkLevel: 1
BookmarkPageNumber: %d
"

rm -f "$bookmarks_file" "$out_file"

declare -a files=(*.pdf)
page_counter=1

# Generate bookmarks file.
for f in "${files[@]}"; do
    title="${f%.*}"
    printf "$bookmarks_fmt" "$title" "$page_counter" >> "$bookmarks_file"
    num_pages="$(pdftk "$f" dump_data | grep NumberOfPages | awk '{print $2}')"
    page_counter=$((page_counter + num_pages))
done

# Combine PDFs and embed the generated bookmarks file.
pdftk "${files[@]}" cat output - | \
    pdftk - update_info "$bookmarks_file" output "$out_file"
