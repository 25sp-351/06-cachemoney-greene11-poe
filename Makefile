CC = gcc
CFLAGS = -Wall -Wextra -pedantic -g
TARGET = cacheMoney.exe
SRCS = main.c convert_money.c memoization.c
OBJS = $(SRCS:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET)

run: all
	./$(TARGET)

test: all
	./tests.sh

.PHONY: all clean run test
