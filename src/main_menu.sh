#!/bin/bash

# Function to display the main menu
show_main_menu() {
  while true; do
    # Display the main menu using dialog
    choice=$(dialog --stdout --menu "Investing.com - Main Menu" 20 50 5 1 "New User? Register" 2 "Already have an account? Login" 3 "Exit")
    if [ $? -ne 0 ]; then
      break  # User canceled the dialog
    fi

    case $choice in
      1)
        show_registration_form
        ;;
      2)
        show_login_form
        if [ $? -eq 0 ]; then
          # User logged in successfully
          show_dashboard_menu
        fi
        ;;
      3)
        break
        ;;
    esac
  done
}

# Function to display the dashboard menu
show_dashboard_menu() {
  while true; do
    # Display the dashboard menu using dialog
    choice=$(dialog --stdout --menu "Investing.com - Dashboard" 20 50 5 1 "Portfolio Management" 2 "Stock Market Data" 3 "Watchlist" 4 "Investment Analysis" 5 "Notifications and Alerts" 6 "User Settings and Preferences" 7 "Logout")
    if [ $? -ne 0 ]; then
      break  # User canceled the dialog
    fi

    case $choice in
      1)
        source src/portfolio.sh
        ;;
      2)
        # Implement Stock Market Data functionality
        ;;
      3)
        # Implement Watchlist functionality
        ;;
      4)
        # Implement Investment Analysis functionality
        ;;
      5)
        # Implement Notifications and Alerts functionality
        ;;
      6)
        # Implement User Settings and Preferences functionality
        ;;
      7)
        break  # Logout and go back to the main menu
        ;;
    esac
  done
}
