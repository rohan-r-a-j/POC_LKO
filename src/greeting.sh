#!/bin/bash

# Function to display the greeting message
show_greeting() {
  local message=" \n\n\n\n                                        WELCOME TO INVESTING.COM!\n\n\n\
Start your journey towards financial success.\n\n\
Investing.com - Your Partner in Wealth Creation \n\n\

Please note the following before going forward:\n\n\
- Investing involves market risk. Be aware of the potential risks and rewards.\n\n\
- It is important to do thorough research and analysis before making any investment decisions.\n\n\
- Read all related documents and disclosures carefully.\n\n\
- Past performance is not indicative of future results.\n\n\
- Consult with a financial advisor or professional for personalized investment advice.\n\n\n\
By using this application, you agree to the above terms and conditions. "

  dialog --title "Investing.com" --msgbox "$message" 35 120
}
