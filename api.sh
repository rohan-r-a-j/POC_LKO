#!/bin/bash

# API Key for Alpha Vantage


# Stock symbol to query


# API URL to retrieve stock data
API_URL="http://localhost:3000/stocks"

# Function to fetch stock data and display it
function view_stock_data() {
    # Send the API request and store the response
    response=$(curl -s "$API_URL")

    # Check if the API request was successful
    if [[ $response =~ "Error Message" ]]; then
        echo "Error: Failed to fetch stock data. Please check your symbol and API key."
        exit 1
    fi

 for i in {0..50}
 do
    echo -n $(echo $response | jq ".data[$i].identifier") 

    echo -n "   "

    echo -n $(echo -n $response | jq ".data[$i].symbol")

    echo -n "   "

    echo -n $(echo -n $response | jq ".data[$i].open")

    echo -n "   "

    echo -n $(echo -n $response | jq ".data[$i].open")
echo
 done

    # Extract and display relevant stock information
    # latest_close=$(echo "$response" | jq -r '.["Time Series (Daily)"] | keys[]' | head -n 1)
    # latest_close_price=$(echo "$response" | jq -r ".[\"Time Series (Daily)\"][\"$latest_close\"][\"4. close\"]")
    # echo "Latest closing price for $SYMBOL: $latest_close_price"
}

# Call the function to view stock data
view_stock_data
