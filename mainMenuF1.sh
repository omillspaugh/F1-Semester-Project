#!/bin/bash

# Check if the marker file exists, indicating that packages have already been installed
INSTALL_SCRIPT="./install_packages.sh"
MARKER_FILE="./tmp/f1_data_aggregator_installed"
DRIVER_SEARCH_BASE="./driverSearch" 
GENERAL_INFO_SCRIPT="./printGeneralInfoF1.sh"


if [ ! -f "$MARKER_FILE" ]; then
  ./install_packages.sh
  touch "$MARKER_FILE"
fi

clear

# Print welcome message and prompt user to choose a selection
echo "Welcome to the Formula 1 Data Aggregator!"
echo "Please choose menu option."

# Menu options, prompts user to select one, and continues to prompt until valid selection is made
echo 
menuSelect=0
while [[ $menuSelect -lt 1 || $menuSelect -gt 5 ]]; do
  echo "1. Current driver list
  echo "2. General Info about Formula 1"
  read -p "Please enter the corresponding number of the data choice you would like to view: " menuSelect
  if [[ $menuSelect -lt 1 || $menuSelect -gt 2 ]]; then
    echo "Invalid selection. Please enter either 1 or 2."
  fi
done

# Switch case to run the script for each selection, prints error message if script fails
case $menuSelect in
  1)
    scriptName="$DRIVER_SEARCH_BASE/driverSearch.sh"
    if [ ! -f "$SCRIPT" ]; then
      echo "Error: Script '$SCRIPT' not found."
      exit 1
    fi
    if ! "$SCRIPT" "$startYear" "$endYear"; then
      echo "Error: '$SCRIPT' failure."
    fi
    ;;
  6)
    if ! "$GENERAL_INFO_SCRIPT"; then
      echo "Error: Failed to generate general information."
    fi
    ;;
  *)
    echo "Invalid selection."  
    ;;
esac

# Asks user if they want to select another option, goes back to calling main menu if yes,
# prints goodbye message if no, prints error message and prompts for a proper input if input is invalid
while true; do
  read -p "Would you like to select another option (y/n)? " choice
  if [[ <span class="math-inline">choice \=\~ ^\[Yy\]</span> ]]; then
    ./mainMenuF1.sh
    break
  elif [[ <span class="math-inline">choice \=\~ ^\[Nn\]</span> ]]; then
    echo "Thank you for using the Formula 1 Data Aggregator. Goodbye"
    break
  else
    echo "Invalid input. Please answer yes(y) or no(n)."
  fi
