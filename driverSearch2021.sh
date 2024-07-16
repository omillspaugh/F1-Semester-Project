# This will be run through the main menu

#!/bin/bash

# List of available driver numbers
available_driver_numbers=(33 11 44 77 16 55 3 4 5 18 14 31 10 22 7 99 9 47 6 63)

while true; do
    # Print menu of available driver numbers
    echo "Available Driver Numbers:"
    for number in "${available_driver_numbers[@]}"; do
        echo "$number"
    done

    # Prompt user to enter a driver number
    read -p "Enter a driver number from the list above (or 'q' to quit): " selected_driver_number

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
