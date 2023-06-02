#!/bin/bash

# Function to display the portfolio management menu
show_portfolio_menu() {
  while true; do
    choice=$(dialog --stdout --menu "Portfolio Management" 20 50 5 1 "Create Portfolio" 2 "Edit Portfolio" 3 "Delete Portfolio" 4 "Go to Dashboard")
    if [ $? -ne 0 ]; then
      break  # User canceled the dialog
    fi

    case $choice in
      1)
        create_portfolio
        ;;
      2)
        edit_portfolio
        ;;
      3)
        delete_portfolio
        ;;
      4)
        break
        ;;
    esac
  done
}

# Function to create a new portfolio
create_portfolio() {
  name=$(dialog --stdout --inputbox "Enter portfolio name:" 8 40)
  if [ $? -ne 0 ]; then
    return 1  # User canceled the dialog
  fi

  # Insert the portfolio details into the database
  mysql -u rohan -prohan123 -D InvestingProject -e "INSERT INTO portfolios (name) VALUES ('$name')"

  dialog --msgbox "Portfolio created successfully!" 8 40
}

# Function to edit an existing portfolio
edit_portfolio() {
  # Fetch the list of portfolios from the database
  portfolios=$(mysql -u rohan -prohan123 -D InvestingProject -se "SELECT * FROM portfolios")

  # Convert the list of portfolios into an array
  portfolios_array=()
  while read -r portfolio; do
    portfolios_array+=("$portfolio")
  done <<< "$portfolios"

  # Prompt the user to select a portfolio
  selected_portfolio=$(dialog --stdout --menu "Select a portfolio to edit" 20 50 10 "${portfolios_array[@]}")
  if [ $? -ne 0 ]; then
    return 1  # User canceled the dialog
  fi

  new_name=$(dialog --stdout --inputbox "Enter new name for the portfolio:" 8 40)
  if [ $? -ne 0 ]; then
    return 1  # User canceled the dialog
  fi

  # Update the portfolio name in the database
  mysql -u rohan -prohan123 -D InvestingProject -e "UPDATE portfolios SET name='$new_name' WHERE name='$selected_portfolio'"

  dialog --msgbox "Portfolio updated successfully!" 8 40
}

# Function to delete an existing portfolio
delete_portfolio() {
  # Fetch the list of portfolios from the database
  portfolios=$(mysql -u rohan -prohan123 -D InvestingProject -se "SELECT * FROM portfolios")

  # Convert the list of portfolios into an array
  portfolios_array=()
  while read -r portfolio; do
    portfolios_array+=("$portfolio")
  done <<< "$portfolios"

  # Prompt the user to select a portfolio
  selected_portfolio=$(dialog --stdout --menu "Select a portfolio to delete" 20 50 10 "${portfolios_array[@]}")
  if [ $? -ne 0 ]; then
    return 1  # User canceled the dialog
  fi

  # Delete the portfolio from the database
  mysql -u rohan -prohan123 -D InvestingProject -e "DELETE FROM portfolios WHERE name='$selected_portfolio'"

  dialog --msgbox "Portfolio deleted successfully!" 8 40
}

# Call the show_portfolio_menu function to display the portfolio management menu
show_portfolio_menu
