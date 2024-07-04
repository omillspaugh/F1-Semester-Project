#!/bin/bash

echo "Welcome to the Formula 1 Data Aggregator!"
echo "Please Enter the Years of Formula 1 Data you are searching for:"

function validateYear() {
  year="$1"
  if [[ ! "$year" =~ ^[0-9]{4}$ ]]; then
    echo "Invalid year. Please enter a 4-digit year."
    return 1
  fi
  return 0
}
while true; do
  read -p "Starting Year: " startYear
  if validateYear "$startYear"; then
    break
  fi
done

while true; do
  read -p "Ending Year: " endYear
  if validateYear "$endYear" && [[ $endYear -ge $startYear ]]; then
    break
  else
    echo "Invalid end year. Must be greater than or equal to start year."
  fi
done

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


if [ $menuSelect -eq 1 ]; then
    ./constructorChampTablePull.sh "$startYear" "$endYear" 
elif [ $menuSelect -eq 2 ]; then
    ./driverChampTablePull.sh "$startYear" "$endYear"
elif [ $menuSelect -eq 3 ]; then
    ./driverListPull.sh "$startYear" "$endYear"
elif [ $menuSelect -eq 4 ]; then
    ./constructorListPull.sh "$startYear" "$endYear"
elif [ $menuSelect -eq 5 ]; then
    pdflatex generalInfoF1.tex
    ./generalInfoF1.tex
else
    echo "Invalid selection. Please enter a number between 1 and 4."
fi
