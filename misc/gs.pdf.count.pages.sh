#!/bin/bash

# ----------------------------------------------------------
# Description: count pages of PDF document using ghostscript
# Author: Jaziel Lopez
# Date: August 2019
# ----------------------------------------------------------


function pdf_count_pages() {

  echo "PDF page counter ... please wait..."
  echo "..............................................."

  if [ -z $1 ]; then
    echo "[ERROR] you do not provide file argument\n\n\tUsage:\t$0 :path_pdf_filename"
  else
    TOTAL_PAGES=$(gs -dNODISPLAY -dBATCH -dNOPAUSE \
      -o /dev/null $1 | grep --regex '^Page' | wc -l)

    echo "PDF total pages found: $TOTAL_PAGES"
  fi
}
