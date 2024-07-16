# This will be run through the main menu and we can loop

#!/bin/bash

# List of available driver numbers
available_driver_numbers=(1 11 44 63 16 55 3 4 14 31 10 22 5 18 6 23 24 77 20 47)

while true; do
    # Print menu of available driver numbers
    echo "Available 2022  Driver Numbers:"
    for number in "${available_driver_numbers[@]}"; do
        echo "$number"
    done

    # Prompt user to enter a driver number
    read -p "Enter a driver number from the 2022 list above (or 'q' to quit): " selected_driver_number

    # Check if user wants to quit
    if [[ "$selected_driver_number" == "q" ]]; then
        echo "Exiting the program. Goodbye!"
        exit 0
    fi

    # Validate user input
    if [[ " ${available_driver_numbers[*]} " =~ " $selected_driver_number " ]]; then
        echo "Fetching data for driver number $selected_driver_number..."
        ./driverDataPull.sh "$selected_driver_number"

        # Ask user if they want to see another number or quit
        while true; do
            read -p "Do you want to see another driver number (yes/no)? " choice
            case $choice in
                [yY]|[yY][eE][sS])
                    break  # Continue to outer loop to fetch another number
                    ;;
                [nN]|[nN][oO])
                    echo "Exiting the program. Goodbye!"
                    exit 0  # Exit the script
                    ;;
                *)
                    echo "Invalid input. Please enter 'yes' or 'no'."
                    ;;
            esac
        done

    else
        echo "Error: Please enter a valid driver number from the list or 'q' to quit."
    fi
done
