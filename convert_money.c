#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "convert_money.h"

#define BUFFER_SIZE 512

void number_to_words(int number, char* buffer, size_t buffer_size) {
    const char* ones[] = {"", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"};
    const char* teens[] = {"ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"};
    const char* tens[] = {"", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"};

    buffer[0] = '\0';

    if (number >= 1000000) {
        snprintf(buffer + strlen(buffer), buffer_size - strlen(buffer), "%s million ", ones[number / 1000000]);
        number %= 1000000;
    }
    if (number >= 1000) {
        snprintf(buffer + strlen(buffer), buffer_size - strlen(buffer), "%s thousand ", ones[number / 1000]);
        number %= 1000;
    }
    if (number >= 100) {
        snprintf(buffer + strlen(buffer), buffer_size - strlen(buffer), "%s hundred ", ones[number / 100]);
        number %= 100;
    }
    if (number >= 20) {
        snprintf(buffer + strlen(buffer), buffer_size - strlen(buffer), "%s ", tens[number / 10]);
        number %= 10;
    }
    if (number >= 10 && number <= 19) {
        snprintf(buffer + strlen(buffer), buffer_size - strlen(buffer), "%s", teens[number - 10]);
    } else if (number > 0) {
        snprintf(buffer + strlen(buffer), buffer_size - strlen(buffer), "%s", ones[number]);
    } else if (buffer[0] == '\0') {
        snprintf(buffer, buffer_size, "zero");
    }

    size_t len = strlen(buffer);
    if (len > 0 && buffer[len - 1] == ' ') {
        buffer[len - 1] = '\0';
    }
}

char* convert_money_to_string(int cents) {
    int dollars = cents / 100;
    int remaining_cents = cents % 100;

    char dollar_words[BUFFER_SIZE];
    char cent_words[BUFFER_SIZE];

    number_to_words(dollars, dollar_words, BUFFER_SIZE);
    number_to_words(remaining_cents, cent_words, BUFFER_SIZE);

    char* result = (char*)malloc(BUFFER_SIZE);
    if (!result) {
        fprintf(stderr, "Memory allocation failed.\n");
        exit(EXIT_FAILURE);
    }

    snprintf(result, BUFFER_SIZE, "%d = %s dollar%s and %s cent%s.", cents, 
             dollar_words, dollars == 1 ? "" : "s", 
             cent_words, remaining_cents == 1 ? "" : "s");

    return result;
}
