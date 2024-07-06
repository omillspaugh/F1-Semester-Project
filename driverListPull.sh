#!/bin/bash

# Formatting for data pull of .Json files
function dataFormat {
  local year=$1
  local driversFile="${year}_driversList.json"
  local season=$(jq -r '.MRData.DriverTable.season' "$driversFile")
  local drivers=$(jq -c '.MRData.DriverTable.Drivers[]' "$driversFile")

  while IFS= read -r driver; do
    local driverId=$(echo "$driver" | jq -r '.driverId')
    local driverName=$(echo "$driver" | jq -r '.givenName + " " + .familyName')
    local nationality=$(echo "$driver" | jq -r '.nationality')
    local dateOfBirth=$(echo "$driver" | jq -r '.dateOfBirth')

    writeToFinalFile "$season" "$driverId" "$driverName" "$nationality" "$dateOfBirth"
  done <<< "$drivers"
}

function writeToFinalFile {
  local season=$1
  local driverId=$2
  local driverName=$3
  local nationality=$4
  local dateOfBirth=$5

  local file_path="finalDriversList.txt"

  if [ ! -e "$file_path" ]; then
    touch "$file_path"
  fi

  echo "Writing to File"

  {
    echo "Season: $season"
    echo "Driver ID: $driverId"
    echo "Driver Name: $driverName"
    echo "Nationality: $nationality"
    echo "Date of Birth: $dateOfBirth"
    echo ""
  } >> "$file_path"
}

# Check for correct number of arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <startYear> <endYear>"
    exit 1
fi

startYear=$1
endYear=$2

echo "Fetching the list of drivers from $startYear to $endYear..."

for year in $(eval echo {$startYear..$endYear}); do
  echo "Fetching data for year $year..."
  curl -o "${year}_driversList.json" "http://ergast.com/api/f1/${year}/drivers.json"
  jq . "${year}_driversList.json"
  dataFormat "$year"
done

# Display the final information
cat finalDriversList.txt
