#ifndef CONVERT_MONEY_H
#define CONVERT_MONEY_H

#include <stddef.h>

void number_to_words(int number, char* buffer, size_t buffer_size);
char* convert_money_to_string(int cents);

#endif
