#!/bin/bash


sudo apt install -y jq
sudo apt install -y sysvbanner
sudo apt install -y texlive-latex-base

function dataFormat {
  local year=$1
  local constructFile="${year}_driver_standings.json"
  local season=$(jq -r '.MRData.StandingsTable.season' "$driverFile")
  local standings=$(jq -c '.MRData.StandingsTable.StandingsLists[0].DriverStandings[]' "$driverFile")

  while IFS= read -r standing; do
    local position=$(echo "$standing" | jq -r '.position')
    local driver=$(echo "$standing" | jq -r '.Driver.name')
    local points=$(echo "$standing" | jq -r '.points')
    local wins=$(echo "$standing" | jq -r '.wins')

    writeToFinalFile "$season" "$position" "$driver" "$points" "$wins"
  done <<< "$standings"
}

function writeToFinalFile {
  local season=$1
  local position=$2
  local driver=$3
  local points=$4
  local wins=$5

  local file_path="finalDriverTable.txt"

  if [ ! -e "$file_path" ]; then
    touch "$file_path"
  fi

  echo "Writing to File"
  
  {
    echo "Season: $season"
    echo "Position: $position"
    echo "Driver: $driver"
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

echo "Fetching Driver's Championship Table from $startYear to $endYear..."


for year in $(eval echo {$startYear..$endYear}); do
  echo "Fetching data for year $year..."
  curl -o "${year}_driver_standings.json" "http://ergast.com/api/f1/${year}/driverStandings.json"
  jq . "${year}_driver_standings.json"
  dataFormat "$year"
done
