# Compiler and flags
CC = gcc
CFLAGS = -Wall -g

# Directories
SRC_DIR = src
BIN_DIR = bin

# Target executable
TARGET = $(BIN_DIR)/mem_simulator

# Source and object files
SRCS = $(SRC_DIR)/main.c
OBJS = $(BIN_DIR)/$(notdir $(SRCS:.c=.obj)) # Object files in bin directory

# Default target
all: $(TARGET)

# Ensure bin directory exists and link object files to create executable
$(TARGET): $(OBJS)
	@if not exist $(BIN_DIR) mkdir $(BIN_DIR)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)

# Compile .c files into .obj files in bin directory
$(BIN_DIR)/%.obj: $(SRC_DIR)/%.c
	@if not exist $(BIN_DIR) mkdir $(BIN_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Clean build files
clean:
	del /Q $(subst /,\\,$(BIN_DIR))\\*.obj $(subst /,\\,$(TARGET)).exe
