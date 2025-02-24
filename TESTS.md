# HW_06_CacheMoney Tests

# Note: I'm aware (at least to me it seems to make more sense) that there may have been a much more efficient use of caching by storing values in the ones, tenths, hundreds place but I wasn't entirely confident in reiterating HW03 so I left the conversion functions as is.

## Test Cases:
1.  **Basic CacheMoney:**
    * Input: `123`
    * Expected Output:
        ```
        Storing result in cache for cents: 123
        123 = one dollar and twenty three cents.
        ```
    * Purpose: Check basic CacheMoney calculations.
    * SUCCESS

2. **CacheMoney with Repeated Input Part 1:**
    * Input: `2000`
    * Expected Output:
        ```
        Storing result in cache for cents: 2000
        2000 = twenty dollars and zero cents.
        ```
    * Purpose: Store a value to check if caching works when input is the same.
    * SUCCESS

2. **CacheMoney with Repeated Input Part 2:**
    * Input: `2000`
    * Expected Output:
        ```
        Using cached value for cents: 2000
        2000 = twenty dollars and zero cents.
        ```
    * Purpose: Check if caching works with repeated user inputs.
    * SUCCESS

4. **CacheMoney Near Max:**
    * Input: `150000`
    * Expected Output:
        ```
        Storing result in cache for cents: 150000
        150000 = one thousand five hindred dollars and zero cents.
        ```
    * Purpose: Check calculations close to declared max value.
    * SUCCESS

5. **Negative Values with CacheMoney**
    * Input: `-1`
    * Expected Output:
        ```
        Negative value not supported.
        ```
    * Purpose: Check how CacheMoney handles negative user inputs.
    * SUCCESS

6. **Zero with CacheMoney**
    * Input: `0`
    * Expected Output:
        ```
        0 = zero dollars and zero cents
        ```
    * Purpose: Check how CacheMoney handles 0.
    * SUCCESS

6. **Large Values with CacheMoney**
    * Input: `10000000`
    * Expected Output:
        ```
        Storing result in cache for cents: 10000000
        10000000 = one hundred thousand dollars and zero cents.
        ```
    * Purpose: Check how CacheMoney handles large numbers.
    * FAILURE

Tests completed: 6 passed, 1 failed.