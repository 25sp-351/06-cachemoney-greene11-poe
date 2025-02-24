#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "memoization.h"
#include "convert_money.h"

#define MAX_CACHED_VALUE 150000

char* cache[MAX_CACHED_VALUE];

void initialize_memo() {
    printf("Initializing memoization...\n");
    for (int i = 0; i < MAX_CACHED_VALUE; i++) {
        cache[i] = NULL;
    }
}

char* memoize(int cents) {
    if (cents < 0) {
        return strdup("Negative value not supported.");
    }
    if (cents == 0) {
        return strdup("0 = zero dollars and zero cents.");
    }
    
    if (cents < MAX_CACHED_VALUE && cache[cents] != NULL) {
        printf("Using cached value for cents: %d\n", cents);
        return strdup(cache[cents]);
    }

    char* result = convert_money_to_string(cents);

    if (cents < MAX_CACHED_VALUE) {
        cache[cents] = strdup(result);
        printf("Storing result in cache for cents: %d\n", cents);
    }

    return result;
}

void free_cache() {
    for (int i = 0; i < MAX_CACHED_VALUE; i++) {
        if (cache[i]) {
            free(cache[i]);
            cache[i] = NULL;
        }
    }
}
