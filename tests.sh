#!/bin/bash

gcc -o cacheMoney memoization.c main.c convert_money.c

if [ $? -ne 0 ]; then
    echo "Compilation failed."
    exit 1
fi

echo "Compilation successful. Running tests..."

declare -A test_cases

# Clean function to remove extra output lines
clean_output() {
    # Remove initialization message, prompt, and cache messages
    # Get the last line and trim any leading/trailing whitespace
    echo "$1" | tail -n 1 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed 's/Enter the number of cents: //'
}

test_cases=(
    ["0"]="0 = zero dollars and zero cents."
    ["100"]="100 = one dollar and zero cents."
    ["123"]="123 = one dollar and twenty three cents."
    ["2000"]="2000 = twenty dollars and zero cents."
    ["9999"]="9999 = ninety nine dollars and ninety nine cents."
    ["150000"]="150000 = one thousand five hundred dollars and zero cents."
    ["-1"]="Negative value not supported."
    ["10000000"]="10000000 = one hundred thousand dollars and zero cents."
    ["888888"]="888888 = eight thousand eight hundred eighty eight dollars and eighty eight cents."    
)

success=0
fail=0

for input in "${!test_cases[@]}"; do
    expected_output="${test_cases[$input]}"
    
    # Get full output and clean it
    full_output=$(echo "$input" | ./cacheMoney 2>&1)
    output=$(clean_output "$full_output")

    if [ "$output" = "$expected_output" ]; then
        echo "Test with input '$input': SUCCESS"
        ((success++))
    else
        echo "Test with input '$input': FAILURE"
        echo "Expected: '$expected_output'"
        echo "Got:      '$output'"
        ((fail++))
    fi
done

echo "Tests completed: $success passed, $fail failed."

if [ $fail -ne 0 ]; then
    exit 1
else
    exit 0
fi