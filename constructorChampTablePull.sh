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



#####################################################################################
## Update by SREYA KALYAN
## Posted on June 21, 2024

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


for year in $(seq $startYear $endYear); do
  curl -o "${year}_season.json" "http://ergast.com/api/f1/${year}.json"
done

for year in $(seq $startYear $endYear); do
        echo "Year: $year"
        jq '.MRData.ConstructorTable.Constructors[] | {constructorName: .name, nationality: .nationality}' "${year}_season.json"
done

#####################################################################################
