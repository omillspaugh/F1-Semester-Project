# This will be called through one of the driver search scripts (2022, 2021, 2020, or 2019)

#!/bin/bash

# Define variables
driver_number=$1
session_key=9158
output_file="${driver_number}_driver_data.json"

# Fetch data from OpenF1 API
curl -s "https://api.openf1.org/v1/drivers?driver_number=$driver_number&session_key=$session_key" -o "$output_file"

# Check if curl command was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to fetch data from OpenF1 API."
  exit 1
fi

# Check if output file exists and is not empty
if [ ! -s "$output_file" ]; then
  echo "Error: Empty or missing output file."
  exit 1
fi

# Process JSON data
driver_data=$(jq '.' "$output_file")

# Example: Extracting relevant fields
broadcast_name=$(echo "$driver_data" | jq -r '.[0].broadcast_name')
full_name=$(echo "$driver_data" | jq -r '.[0].full_name')
team_name=$(echo "$driver_data" | jq -r '.[0].team_name')

# Print extracted data
echo "Broadcast Name: $broadcast_name"
echo "Full Name: $full_name"
echo "Team Name: $team_name"
