#!/bin/bash

# Variable to track the login status
USER_LOGGED_IN="false"

# Function to display the login form
show_login_form() {
  local email
  local password

  # Prompt the user for login details using dialog
  email=$(dialog --stdout --inputbox "Enter your email:" 8 40)
  if [ $? -ne 0 ]; then
    return 1  # User canceled the dialog
  fi

  password=$(dialog --stdout --passwordbox "Enter your password:" 8 40)
  if [ $? -ne 0 ]; then
    return 1  # User canceled the dialog
  fi

  # Retrieve the user details from the database (MySQL)
  user=$(mysql -u rohan -prohan123 -D InvestingProject -se "SELECT * FROM users WHERE email='$email'")

  if [ -z "$user" ]; then
    dialog --msgbox "Error: User with email $email does not exist." 8 40
    return 1
  fi

  # Get the stored password from the user details
  stored_password=$(echo "$user" | awk '{print $4}')

  # Compare the entered password with the stored password
  if [ "$password" = "$stored_password" ]; then
    # Set the login status to true
    USER_LOGGED_IN="true"
    dialog --msgbox "Login successful!" 8 40
  else
    dialog --msgbox "Error: Invalid password." 8 40
  fi
}
