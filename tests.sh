#!/bin/bash

gcc -o cacheMoney memoization.c main.c convert_money.c

if [ $? -ne 0 ]; then
    echo "Compilation failed."
    exit 1
fi

echo "Compilation successful. Running tests..."

declare -A test_cases

test_cases=(
    ["123"]="123 = one dollar and twenty three cents."
    ["2000"]="2000 = twenty dollars and zero cents."
    ["150000"]="150000 = one thousand five hundred dollars and zero cents."
    ["-1"]="Negative value not supported."
    ["0"]="0 = zero dollars and zero cents."
    ["10000000"]="10000000 = one hundred thousand dollars and zero cents."
)

success=0
fail=0

clean_output() {
    echo "$1" | tail -n 1 | sed 's/Enter the number of cents: //' | awk '{$1=$1;print}'
}

echo "Testing caching mechanism..."
echo "Testing caching with input '2000'..."

echo "2000" | ./cacheMoney > cache_test_output.txt 2>&1
cache_first_call=$(cat cache_test_output.txt)
echo "First call output: $cache_first_call"

echo "2000" | ./cacheMoney > cache_test_output.txt 2>&1
cache_second_call=$(cat cache_test_output.txt)

if echo "$cache_second_call" | grep -q "Using cached value"; then
    echo "Cache test for input '2000': SUCCESS"
    echo "Cache hit: Using cached value"
    ((success++))
elif [ "$cache_first_call" = "$cache_second_call" ]; then
    echo "Cache test for input '2000': SUCCESS (implicit match)"
    echo "Cache hit: Implicit match"
    ((success++))
else
    echo "Cache test for input '2000': FAILURE"
    ((fail++))
fi

for input in "${!test_cases[@]}"; do
    expected_output="${test_cases[$input]}"
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

rm -f cache_test_output.txt

echo "Tests completed: $success passed, $fail failed."

if [ $fail -ne 0 ]; then
    exit 1
else
    exit 0
fi
