#!/bin/bash


sudo apt install -y jq
sudo apt install -y sysvbanner
sudo apt install -y texlive-latex-base

function dataFormat {
  local year=$1
  local constructFile="${year}_constructor_standings.json"
  local season=$(jq -r '.MRData.StandingsTable.season' "$constructFile")
  local standings=$(jq -c '.MRData.StandingsTable.StandingsLists[0].ConstructorStandings[]' "$constructFile")

  while IFS= read -r standing; do
    local position=$(echo "$standing" | jq -r '.position')
    local constructor=$(echo "$standing" | jq -r '.Constructor.name')
    local points=$(echo "$standing" | jq -r '.points')
    local wins=$(echo "$standing" | jq -r '.wins')

    writeToFinalFile "$season" "$position" "$constructor" "$points" "$wins"
  done <<< "$standings"
}

function writeToFinalFile {
  local season=$1
  local position=$2
  local constructor=$3
  local points=$4
  local wins=$5

  local file_path="finalConstructorTable.txt"

  if [ ! -e "$file_path" ]; then
    touch "$file_path"
  fi

  echo "Writing to File"
  
  {
    echo "Season: $season"
    echo "Position: $position"
    echo "Constructor: $constructor"
    echo "Points: $points"
    echo "Wins: $wins"
    echo ""
  } >> "$file_path"
}


if [ $# -ne 2 ]; then
    echo "Usage: $0 <startYear> <endYear>"
    exit 1
fi

startYear=$1
endYear=$2

echo "Fetching Constructor's Championship Table from $startYear to $endYear..."


for year in $(eval echo {$startYear..$endYear}); do
  echo "Fetching data for year $year..."
  curl -o "${year}_constructor_standings.json" "http://ergast.com/api/f1/${year}/constructorStandings.json"
  jq . "${year}_constructor_standings.json"
  dataFormat "$year"
done

# Concatenate the text file with the constructor
# standings to display the final information
cat finalConstructorTable.txt
