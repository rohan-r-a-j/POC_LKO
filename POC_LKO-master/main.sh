#!/bin/bash

# Function to reset terminal settings and exit gracefully
cleanup() {
  # Reset terminal settings
  reset
  exit
}

# Set signal handler to call the cleanup function on script exit
trap cleanup EXIT

# Source the required files
source src/greeting.sh
source src/registration.sh
source src/login.sh
source src/main_menu.sh
source src/dashboard.sh

# Show the greeting message
show_greeting

# Prompt the user to confirm understanding and proceed
dialog --title "Investing.com" --yesno "Do you understand and wish to proceed?" 10 60
choice=$?

# Check the user's choice
if [ $choice -eq 0 ]; then
  # User understood and wants to proceed
  echo "User selected 'I Understand'"
  # Proceed with the application logic here
  show_main_menu
else
  # User chose to cancel and exit
  echo "User selected 'Cancel and Exit'"
  exit
fi
