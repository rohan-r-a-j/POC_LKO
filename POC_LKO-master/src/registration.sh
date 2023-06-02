#!/bin/bash

# Function to display the registration form
show_registration_form() {
  local name
  local email
  local password

  # Prompt the user for registration details using dialog
  name=$(dialog --stdout --inputbox "Enter your name:" 8 40)
  if [ $? -ne 0 ]; then
    return 1  # User canceled the dialog
  fi

  email=$(dialog --stdout --inputbox "Enter your email:" 8 40)
  if [ $? -ne 0 ]; then
    return 1  # User canceled the dialog
  fi

  password=$(dialog --stdout --passwordbox "Enter your password:" 8 40)
  if [ $? -ne 0 ]; then
    return 1  # User canceled the dialog
  fi

  # Validate if the user already exists in the database (MySQL)
  existing_user=$(mysql -hcontainers-us-west-146.railway.app -uroot -pCFLQtzJ1fgs0QGBPSmvS --port 6886 --protocol=TCP railway -se "SELECT * FROM users WHERE email='$email'")

  if [ -n "$existing_user" ]; then
    dialog --msgbox "Error: User with email $email already exists." 8 40
    return 1
  fi

  # Escape special characters in the password
  password_escaped=$(printf '%s' "$password" | sed -e 's/[]\/$*.^[]/\\&/g')

  # Insert the user details into the database
  mysql -hcontainers-us-west-146.railway.app -uroot -pCFLQtzJ1fgs0QGBPSmvS --port 6886 --protocol=TCP railway -e "INSERT INTO users (name, email, password) VALUES ('$name', '$email', '$password_escaped')"

  dialog --msgbox "Registration successful!" 8 40
}



























# #!/bin/bash

# # Function to display the registration form
# show_registration_form() {
#   local name
#   local email
#   local password

#   # Prompt the user for registration details using dialog
#   name=$(dialog --stdout --inputbox "Enter your name:" 8 40)
#   if [ $? -ne 0 ]; then
#     return 1  # User canceled the dialog
#   fi

#   email=$(dialog --stdout --inputbox "Enter your email:" 8 40)
#   if [ $? -ne 0 ]; then
#     return 1  # User canceled the dialog
#   fi

#   password=$(dialog --stdout --passwordbox "Enter your password:" 8 40)
#   if [ $? -ne 0 ]; then
#     return 1  # User canceled the dialog
#   fi

#   # Validate if the user already exists in the database (MySQL)
#   existing_user=$(mysql -u rohan -prohan123 -D InvestingProject -se "SELECT * FROM users WHERE email='$email'")

#   if [ -n "$existing_user" ]; then
#     dialog --msgbox "Error: User with email $email already exists." 8 40
#     return 1
#   fi

#   # Escape special characters in the password
#   password_escaped=$(printf '%s' "$password" | sed -e 's/[]\/$*.^[]/\\&/g')

#   # Insert the user details into the database
#   mysql -u rohan -prohan123 -D InvestingProject -e "INSERT INTO users (name, email, password) VALUES ('$name', '$email', '$password_escaped')"

#   dialog --msgbox "Registration successful!" 8 40
# }
