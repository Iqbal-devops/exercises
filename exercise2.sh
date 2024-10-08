#!/bin/bash

# Check if exactly 6 arguments are provided
if [ "$#" -ne 6 ]; then
    echo "Usage: $0 num1 num2 num3 num4 num5 num6"
    exit 1
fi

# Read the input numbers into an array
numbers=("$@")

# Function to display the menu
show_menu() {
    echo "Choose an option:"
    echo "1) Perform subtraction and show output (comma separated)"
    echo "2) Perform multiplication and store result in JSON file"
    echo "3) Pick a random number and show it"
    echo "4) Print sorted array (highest to lowest)"
    echo "5) Print sorted array (lowest to highest)"
}

# Perform subtraction (number1 - number2, number2 - number3, ..., number5 - number6)
perform_subtraction() {
    local results=()
    for ((i=0; i<5; i++)); do
        result=$((numbers[i] - numbers[i+1]))
        results+=($result)
    done
    echo "Subtraction results: ${results[*]}" | tr ' ' ','
}

# Perform multiplication and store result in a JSON file
perform_multiplication() {
    local product=1
    for num in "${numbers[@]}"; do
        product=$((product * num))
    done
    echo "{\"InputNumber1\": ${numbers[0]}, \"InputNumber2\": ${numbers[1]}, \"InputNumber3\": ${numbers[2]}, \"InputNumber4\": ${numbers[3]}, \"InputNumber5\": ${numbers[4]}, \"InputNumber6\": ${numbers[5]}, \"Multiplication\": $product}" > result.json
    echo "Multiplication result stored in result.json"
}

# Pick a random number
pick_random_number() {
    local random_index=$((RANDOM % 6))
    echo "Randomly picked number: ${numbers[$random_index]}"
}

# Print sorted array (highest to lowest)
print_sorted_descending() {
    local sorted_numbers=($(printf "%s\n" "${numbers[@]}" | sort -nr))
    echo "Sorted (highest to lowest): ${sorted_numbers[*]}"
}

# Print sorted array (lowest to highest)
print_sorted_ascending() {
    local sorted_numbers=($(printf "%s\n" "${numbers[@]}" | sort -n))
    echo "Sorted (lowest to highest): ${sorted_numbers[*]}"
}

# Show menu and read user choice
show_menu
read -r choice

# Execute the chosen operation
case "$choice" in
    1)
        perform_subtraction
        ;;
    2)
        perform_multiplication
        ;;
    3)
        pick_random_number
        ;;
    4)
        print_sorted_descending
        ;;
    5)
        print_sorted_ascending
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
esac
