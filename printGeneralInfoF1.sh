#!/bin/bash


# Define the LaTeX file and the output PDF file
TEX_FILE="generalInfoF1.tex"
PDF_FILE="generalInfoF1.pdf"
TXT_FILE="generalInfoF1.txt"

# Check if the .tex file exists
if [ ! -f "$TEX_FILE" ]; then
  echo "Error: $TEX_FILE not found."
  exit 1
fi

# Compile the LaTeX file
pdflatex "$TEX_FILE"

# Check if the PDF was generated
if [ ! -f "$PDF_FILE" ]; then
  echo "Error: Failed to generate $PDF_FILE."
  exit 1
fi

# Convert the PDF to text
pdftotext "$PDF_FILE" "$TXT_FILE"

# Check if the text file was generated
if [ ! -f "$TXT_FILE" ]; then
  echo "Error: Failed to convert $PDF_FILE to text."
  exit 1
fi

# Display the text file in the console
cat "$TXT_FILE"
