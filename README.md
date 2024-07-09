# F1-Semester-Project
Semester project for CS2080 dealing with F1 stat aggregation

How to Run the F1 Aggregator:
  1. The files invovled in running the main programmme are "install_packages.sh" , "generalInfoF1.tex" ,
      "mainMenuF1.sh" , "printGeneralInfoF1.sh" , "constructorChampTablePull.sh" , "driverChampTablePull.sh" , "driverListPull.sh" , and "constructorListPull.sh" . 
  3. Make sure the correct permissions (chmod 755) are set on all of the script files to allow it to be executed.
  4. Enter " ./mainMenuF1.sh " into the command line to start the main programme. The first thing that it will do is install all of the packages necessary to run the programme for any possible user input.
  5. It will prompt you for a Starting Year, and then an Ending Year. Anything is valid from 1950 - 2023, and the Starting Year must ALWAYS be less than the Ending Year.
  6. After reading in and validating your starting and ending years, it will print a list of options regarding what information you would like to view of Formula 1 history.
  7. Input the number corressponding to the menu option you are interested in, and it will run the appropriate script to print out the information that you were searching for based on your start and end year inputs.
  8. After printing the information, it will ask the user to input whether they would like to return to the Main Menu to search for more information or simply quit the programme, - enter the input accordingly.

