#!/bin/bash

# Check if marker file exists for package installation
INSTALL_SCRIPT="./install_packages.sh"
MARKER_FILE="./tmp/f1_data_aggregator_installed"
DRIVER_SEARCH_BASE="./driverSearch"
GENERAL_INFO_SCRIPT="./printGeneralInfoF1.sh"

if [ ! -f "$MARKER_FILE" ]; then
  # Install script execution and error handling
  ./install_packages.sh || (echo "Error: Installation failed." && exit 1)
  touch "$MARKER_FILE"
fi

# Print welcome message and prompt user to choose a selection
echo "Welcome to the Formula 1 Data Aggregator!"
echo "Please choose a menu option."

# Menu options, prompts user to select one, and continues to prompt until valid selection is made
echo 
while [[ $menuSelect -lt 1 || $menuSelect -gt 2 ]]; do
  echo "1. Current driver list"
  echo "2. General Info about Formula 1"
  read -p "Please enter the corresponding number (1 or 2): " menuSelect
  if [[ $menuSelect -lt 1 || $menuSelect -gt 2 ]]; then
    echo "Invalid selection. Please enter 1 or 2."
  fi
done

# Switch case to run the script for each selection, prints error message if script fails
case $menuSelect in
  1)
    scriptName="$DRIVER_SEARCH_BASE/driverSearch.sh"
    if [ ! -f "$scriptName" ]; then
      echo "Error: Script driverSearch.sh not found."
      exit 1
    fi
    "$scriptName" || echo "Error: driverSearch.sh failed."
    ;;
  2)
    "$GENERAL_INFO_SCRIPT" || echo "Error: Failed to generate general information."
    ;;
  *)
    echo "Invalid selection."
    ;;
esac


# Asks user if they want to select another option, goes back to calling main menu if yes,
# prints goodbye message if no, prints error message and prompts for a proper input if input is invalid
while true; do
  read -p "Would you like to select another option (y/n)? " choice
  if [[ $choice =~ ^[Yy]$ ]]; then
    # Check if mainMenuF1.sh exists before calling
    if [ -f "./mainMenuF1.sh" ]; then
      ./mainMenuF1.sh
    else
      echo "Error: Script mainMenuF1.sh not found."
    fi
    break
  elif [[ $choice =~ ^[Nn]$ ]]; then
    echo "Thank you for using the Formula 1 Data Aggregator. Goodbye"
    break
  else
    echo "Invalid input. Please answer yes(y) or no(n)."
  fi
done
