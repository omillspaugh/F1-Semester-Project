#!/bin/bash

# Install required packages in the background
sudo apt install -y jq &
sudo apt install -y sysvbanner &
sudo apt install -y texlive-latex-base &
sudo apt install -y dos2unix &
sudo apt-get install poppler-utils &

# Convert all files to the same file endings for consistency
dos2unix mainMenuF1.sh constructorChampTablePull.sh driverChampTablePull.sh driverListPull.sh constructorListPull.sh &

# Wait for all background processes to finish
wait

