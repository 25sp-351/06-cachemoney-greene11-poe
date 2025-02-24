#include <stdio.h>
#include <stdlib.h>
#include "memoization.h"

int main() {
    initialize_memo();
    
    int cents;  
    printf("Enter the number of cents: ");
    while (scanf("%d", &cents) != EOF) {
        char* result = memoize(cents);
        printf("%s\n", result);
        free(result);
    }
    
    free_cache();
    return 0;
}
