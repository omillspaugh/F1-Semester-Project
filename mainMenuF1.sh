#!/bin/bash

# Install required packages
sudo apt install -y jq
sudo apt install -y sysvbanner
sudo apt install -y texlive-latex-base

# Print welcome message and prompt user to input years
echo "Welcome to the Formula 1 Data Aggregator!"
echo "Please Enter the Years of Formula 1 Data you are searching for:"

# Checks if input year is valid (4 digits, returns 1 and prints error message if invalid, returns 0 if valid)
# Also checks if input years are between 1950 and 2023
function validateYear() {
  year="$1"
  if [[ ! "$year" =~ ^[0-9]{4}$ ]]; then
    echo "Invalid year. Please enter a 4-digit year."
    return 1
  elif [[ "$year" -lt 1950 || "$year" -gt 2023 ]]; then
    echo "Invalid year. Please enter a year between 1950 and 2023."
    return 1
  fi
  return 0
}

# Loop to prompt user to enter start year and continues until a valid year is entered
while true; do
  read -p "Starting Year: " startYear
  if validateYear "$startYear"; then
    break
     echo "Invalid year. Please enter a valid year."
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
  echo "1. Constructor's Championship Table"
  echo "2. Driver's Championship Table"
  echo "3. Driver List"
  echo "4. Constructor List"
  echo "5. General Info about Formula 1"
  read -p "Please enter the corresponding number of the data choice you would like to view: " menuSelect
  if [[ $menuSelect -lt 1 || $menuSelect -gt 5 ]]; then
    echo "Invalid selection. Please enter a number between 1 and 5."
  fi
done

read -p "Enter your selection (1-5): " menuSelect

# Switch case to run the script for each selection, prints error message if script fails
case $menuSelect in
  1) 
	./constructorChampTablePull.sh "$startYear" "$endYear" 
	if [ $? -ne 0 ]; then
		echo "Error: Could not generate constructorChampTablePull.sh" 
	fi
	;;
  2) 
	./driverChampTablePull.sh "$startYear" "$endYear"
	if [ $? -ne 0 ]; then
		echo "Error: Could not generate driverChampTablePull.sh"
	fi
	;;
  3) 
	./driverListPull.sh "$startYear" "$endYear"
	if [ $? -ne 0 ]; then
		echo "Error: Could not generate driverListPull.sh"
	fi
	;;
  4) 
	./constructorListPull.sh "$startYear" "$endYear" 
	if [ $? -ne 0 ]; then
		echo "Error: Could not generate constructorListPull.sh"
	fi
	;;
  5) 
	pdflatex generalInfoF1.tex
	if [ $? -ne 0 }; then
		echo "Error: Could not generate generalInfoF1.tex"
	else
		./generalInfoF1.tex
		if [ $? -ne 0 ]; then
			echo "Error: Could not open generalInfoF1.tex"
		fi
	fi
	;;
  *) 
	echo "Invalid selection. Please enter a number between 1 and 5."
	;;
esac

# Asks user if they want to select another option, goes back to calling main menu if yes,
# prints goodbye message if no, prints error message and prompts for a proper input if input is invalid
while true; do
	read -p "Would you like to select another option (y/n)? " choice
	if [[ $choice =~ ^[Yy]$ ]]; then
  		./mainMenuF1.sh
		break
	elif [[ $choice =~ ^[Nn]$ ]]; then
  		echo "Thank you for using the Formula 1 Data Aggregator. Goodbye"
		break
  	else
 		 echo "Invalid input. Please answer yes(y) or no(n)."
	fi
done
