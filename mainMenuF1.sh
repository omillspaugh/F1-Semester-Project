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

# Print welcome message and prompt user to input years
echo "Welcome to the Formula 1 Data Aggregator! This will present data from 2018 to 2022."
echo "Please enter a year range:"

# Checks if input year is valid (4 digits, returns 1 and prints error message if invalid, returns 0 if valid)
# Also checks if input years are between 2018 and 2022
function validateYear() {
  year="$1"
  if [[ ! "$year" =~ ^[0-9]{4}$ ]]; then
    echo "Invalid year. Please enter a 4-digit year."
    return 1
  elif [[ "$year" -lt 2018 || "$year" -gt 2022 ]]; then
    echo "Invalid year. Please enter a year between 2018 and 2022."
    return 1
  fi
  return 0
}

# Loop to prompt user to enter start year and continues until a valid year is entered
while true; do
  read -p "Starting Year: " startYear
  if validateYear "$startYear"; then
    break
  fi
done

# Loop to prompt user to enter end year and continues until a valid year is entered
while true; do
  read -p "Ending Year: " endYear
  if validateYear "$endYear" && [[ $endYear -ge $startYear ]]; then
    break
  else
    echo "Invalid end year. Must be greater than or equal to start year."
  fi
done

# Prints menu options, prompts user to select one, and continues to prompt until valid selection is made
echo
echo "Looking at the year range $startYear to $endYear, I can provide the following data:"
echo
menuSelect=0
while [[ $menuSelect -lt 1 || $menuSelect -gt 5 ]]; do
  echo "1. 2022 Driver Number List"
  echo "2. 2021 Driver Number List"
  echo "3. 2020 Driver Number List"
  echo "4. 2019 Driver Number List"
  echo "5. 2018 Driver Number List"
  echo "6. General Info about Formula 1"
  read -p "Please enter the corresponding number of the data choice you would like to view: " menuSelect
  if [[ $menuSelect -lt 1 || $menuSelect -gt 5 ]]; then
    echo "Invalid selection. Please enter a number between 1 and 5."
  fi
done

# Switch case to run the script for each selection, prints error message if script fails
case $menuSelect in
  1)
    scriptName="$DRIVER_SEARCH_BASE/driverSearch2022.sh"
    if [ ! -f "$SCRIPT" ]; then
      echo "Error: Script '$SCRIPT' not found."
      exit 1
    fi
    if ! "$SCRIPT" "$startYear" "$endYear"; then
      echo "Error: '$SCRIPT' failure."
    fi
    ;;
  2)
    scriptName="$DRIVER_SEARCH_BASE/driverSearch2021.sh"
    if [ ! -f "$SCRIPT" ]; then
      echo "Error: Script '$SCRIPT' not found."
      exit 1
    fi
    if ! "$SCRIPT" "$startYear" "$endYear"; then
      echo "Error: '$SCRIPT' failure."
    fi
  3)
      scriptName="$DRIVER_SEARCH_BASE/driverSearch2020.sh"
    if [ ! -f "$SCRIPT" ]; then
      echo "Error: Script '$SCRIPT' not found."
      exit 1
    fi
    if ! "$SCRIPT" "$startYear" "$endYear"; then
      echo "Error: '$SCRIPT' failure."
    fi
  4)
    scriptName="$DRIVER_SEARCH_BASE/driverSearch2019.sh"
    if [ ! -f "$SCRIPT" ]; then
      echo "Error: Script '$SCRIPT' not found."
      exit 1
    fi
    if ! "$SCRIPT" "$startYear" "$endYear"; then
      echo "Error: '$SCRIPT' failure."
    fi
  5)
    scriptName="$DRIVER_SEARCH_BASE/driverSearch2018.sh"
    if [ ! -f "$SCRIPT" ]; then
      echo "Error: Script '$SCRIPT' not found."
      exit 1
    fi
    if ! "$SCRIPT" "$startYear" "$endYear"; then
      echo "Error: '$SCRIPT' failure."
    fi
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
