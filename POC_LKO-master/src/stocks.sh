#!/bin/bash

# Function to fetch the stock data from the API
fetch_stock_data() {
  local url="http://localhost:3000/stocks"
  local response=$(curl -s "$url")
  echo "$response"
}

# Function to display the stocks using dialog
show_stock_list() {
  local stocks
  local selected_stock
  local stock_index=0
  local stock_limit=10
  local page=1

  while true; do
    # Fetch the stock data from the API
    stocks=$(fetch_stock_data)

    # Extract the stock names from the API response
    stock_names=$(echo "$stocks" | jq -r '.[].name')

    # Calculate the start and end index of stocks to display
    start_index=$((stock_index))
    end_index=$((stock_index + stock_limit - 1))

    # Create an array of stock options for dialog
    stock_options=()
    while IFS= read -r stock_name; do
      stock_options+=("$stock_name" "")
    done <<< "$stock_names"

    # Display the stock list using dialog
    selected_stock=$(dialog --stdout --title "Stocks - Page $page" --menu "Navigate using UP/DOWN keys and press Enter to select:" 15 60 "$stock_limit" "${stock_options[@]}" "Previous 10 stocks" "Next 10 stocks" "Exit")

    case "$selected_stock" in
      "Previous 10 stocks")
        if ((stock_index >= stock_limit)); then
          stock_index=$((stock_index - stock_limit))
          page=$((page - 1))
        fi
        ;;
      "Next 10 stocks")
        if ((stock_index + stock_limit < $(echo "$stocks" | jq length))); then
          stock_index=$((stock_index + stock_limit))
          page=$((page + 1))
        fi
        ;;
      *)
        # Handle stock selection or exit
        if [ -n "$selected_stock" ]; then
          # Perform the desired action for the selected stock
          echo "Selected stock: $selected_stock"
          # Add your logic here for what to do with the selected stock
        else
          # User chose to exit
          break
        fi
        ;;
    esac
  done
}

# Call the function to display the stock list
show_stock_list
