#!/bin/bash

# ----------------------------------------------------------
# Description: extract pages of PDF document using ghostscript
# Author: Jaziel Lopez
# Date: October 2019
# ----------------------------------------------------------

function pdf_extract_pages() {

  echo "
  ----------------------------------------------------------------------
                            PDF PAGE EXTRACTOR
  ----------------------------------------------------------------------
  
  Jaziel Lopez,

  Software Engineer

  Tijuana Area, BC. Mexico

  jlopez.mx"


  INPUT_FILE=$1
  START_AT=$2
  END_AT=$3
  OUTPUT_FILE="Pages-${START_AT}-${END_AT}-${INPUT_FILE}"

  echo ""
  echo "# extracting pages from pdf ... please wait ... "  
  
  gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH \
    -dFirstPage=$START_AT \
    -dLastPage=$END_AT \
    -sOutputFile=$OUTPUT_FILE $INPUT_FILE > .debug.log  2>&1
 
    EXIT_CODE=$?

    echo ""
    echo "................................"
    echo ""
  

    if [ $EXIT_CODE -eq 0 ]; then 
      echo "# document is ready and can be found at:"
      echo "#  $OUTPUT_FILE"
  else
      echo "# unable to process pdf due to an error"
      echo "# $(cat .debug.log)"
  fi
    
  echo ""
  echo "Contact:"
  echo "Jaziel Lopez <jaziel.lopez @ thermofisher.com>"
  echo ""
}
