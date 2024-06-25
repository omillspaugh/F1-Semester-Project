#!/bin/bash

echo "Welcome to the Formula 1 Data Aggregator!"
echo "Please Enter the Years of Formula 1 Data you are searching for:"
read -p "Starting Year: " startYear
read -p "Ending Year: " endYear
echo
echo "Looking at the year range $startYear to $endYear, I can provide the following data:"
echo
echo "1. Constructor's Championship Table"
echo "2. World Driver's Championship Table"
echo "3. Driver List"
echo "4. Constructor List"
echo "5. General Info about Formula 1"

read -p "Please Enter the number of the menu you would like to read more about: " menuSelect

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
