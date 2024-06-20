#!/bin/bash

# Check if the correct number of arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <startYear> <endYear>"
    exit 1
fi

# Assign the arguments to variables
startYear=$1
endYear=$2

# Use the variables
echo "Fetching Constructor's Championship Table from $startYear to $endYear..."
# Your script logic here


for year in {$startYear..$endYear}; do
  curl -o "${year}_season.json" "http://ergast.com/api/f1/${year}.json"
done

jq . '.MRData.RaceTable.Races{} | {raceName: .racename, date: .date}' "${year}_data.json"
