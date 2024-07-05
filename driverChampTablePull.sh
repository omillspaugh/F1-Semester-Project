#!/bin/bash

# Install required packages
sudo apt install -y jq
sudo apt install -y sysvbanner
sudo apt install -y texlive-latex-base

# Function to format the data
function dataFormat {
  local year=$1
  local constructFile="${year}_driver_standings.json"
  local season=$(jq -r '.MRData.StandingsTable.season' "$constructFile")
  local standings=$(jq -c '.MRData.StandingsTable.StandingsLists[0].DriverStandings[]' "$constructFile")

  # Clear the temporary file
  local temp_file="temp_driver_table.txt"
  > "$temp_file"

  while IFS= read -r standing; do
    local position=$(echo "$standing" | jq -r '.position')
    local driver_given_name=$(echo "$standing" | jq -r '.Driver.givenName')
    local driver_family_name=$(echo "$standing" | jq -r '.Driver.familyName')
    local driver="${driver_given_name} ${driver_family_name}"
    local points=$(echo "$standing" | jq -r '.points')
    local wins=$(echo "$standing" | jq -r '.wins')

    writeToTempFile "$season" "$position" "$driver" "$points" "$wins" "$temp_file"
  done <<< "$standings"

  # Append the contents of the temporary file to the final file
  cat "$temp_file" >> "finalDriverTable.txt"
}

# Function to write the data to the temporary file
function writeToTempFile {
  local season=$1
  local position=$2
  local driver=$3
  local points=$4
  local wins=$5
  local temp_file=$6

  {
    echo "Season: $season"
    echo "Position: $position"
    echo "Driver: $driver"
    echo "Points: $points"
    echo "Wins: $wins"
    echo ""
  } >> "$temp_file"
}

# Check for correct number of arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <startYear> <endYear>"
    exit 1
fi

startYear=$1
endYear=$2

echo "Fetching Driver's Championship Table from $startYear to $endYear..."

# Clear the final file at the start
> "finalDriverTable.txt"

# Loop through each year and fetch the data
for year in $(eval echo {$startYear..$endYear}); do
  echo "Fetching data for year $year..."
  curl -o "${year}_driver_standings.json" "http://ergast.com/api/f1/${year}/driverStandings.json"
  jq . "${year}_driver_standings.json"
  dataFormat "$year"
done

# Concatenate the text file with final diver standings
# to display the information to the user
cat finalDriverTable.txt
