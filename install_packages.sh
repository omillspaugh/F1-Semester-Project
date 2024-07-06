#!/bin/bash

# Install required packages in the background
sudo apt install -y jq &
sudo apt install -y sysvbanner &
sudo apt install -y texlive-latex-base &

# Wait for all background processes to finish
wait

