# File to pull and display the list of constructors 
# for the timeline inputted by the user, year by year

#!/bin/bash

# Formatting for data pull of .json files
function dataFormat {
  local year=$1
  local constructorsFile="${year}_constructorsList.json"
  local season=$(jq -r '.MRData.ConstructorTable.season' "$constructorsFile")
  local constructors=$(jq -c '.MRData.ConstructorTable.Constructors[]' "$constructorsFile")

  while IFS= read -r constructor; do
    local constructorId=$(echo "$constructor" | jq -r '.constructorId')
    local constructorName=$(echo "$constructor" | jq -r '.name')
    local nationality=$(echo "$constructor" | jq -r '.nationality')

    writeToFinalFile "$season" "$constructorId" "$constructorName" "$nationality"
  done <<< "$constructors"
}

function writeToFinalFile {
  local season=$1
  local constructorId=$2
  local constructorName=$3
  local nationality=$4

  local file_path="finalConstructorsList.txt"

  if [ ! -e "$file_path" ]; then
    touch "$file_path"
  fi

  echo "Writing to File"

  {
    echo "Season: $season"
    echo "Constructor ID: $constructorId"
    echo "Constructor Name: $constructorName"
    echo "Nationality: $nationality"
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

echo "Fetching the list of constructors from $startYear to $endYear..."

for year in $(eval echo {$startYear..$endYear}); do
  echo "Fetching data for year $year..."
  curl -o "${year}_constructorsList.json" "http://ergast.com/api/f1/${year}/constructors.json"
  jq . "${year}_constructorsList.json"
  dataFormat "$year"
done

# Display the final information
cat finalConstructorsList.txt
