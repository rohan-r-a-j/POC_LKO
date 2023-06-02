#!/bin/bash

# Function to display the dashboard menu
show_dashboard_menu() {
  # Check if the user is logged in
  if [ "$USER_LOGGED_IN" != "true" ]; then
    dialog --msgbox "Error: You must be logged in to access the dashboard." 8 40
    return 1
  fi

  while true; do
    # Display the dashboard menu using dialog
    choice=$(dialog --stdout --menu " \n\n Investing.com - Dashboard \n\n" 20 50 5 1 "Portfolio Management" 2 "Stock Market Data" 3 "Watchlist" 4 "Investment Analysis" 5 "Notifications and Alerts" 6 "User Settings and Preferences" 7 "Logout")
    if [ $? -ne 0 ]; then
      break  # User canceled the dialog
    fi
    case $choice in
      1)
        source src/portfolio.sh
        ;;
      2)
        source src/stocks.sh
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
