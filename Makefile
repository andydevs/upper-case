# --------------------- PROJECT ----------------------

PROJECT = uppercase

# -------------------- DIRECTORIES -------------------

INCDIR = include
LIBDIR = lib
SRCDIR = src
OBJDIR = obj
BINDIR = bin
INSDIR = /usr/bin

# ----------------------- TEST -----------------------

# Program arguments
TESTARGS = tmp/testfile.u

# ---------------------- CONFIG ----------------------

# Shell command
SHELL = /bin/bash -O globstar

# Compiler
CC = gcc

# Flags
FLAGS = -std=c11 -Wall

# ---------------------- MAKEFILE --------------------

# File
TARGET = $(PROJECT)

# Directories
INCLUDS = $(shell ls $(INCDIR)/**/*.h)
SOURCES = $(shell ls $(SRCDIR)/**/*.c)
OBJECTS = $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SOURCES))
BINARY  = $(BINDIR)/$(TARGET)

$(BINARY): $(LIBRARY) $(OBJECTS)
	@echo building $@
	@test -d $(@D) || mkdir -p $(@D)
	@$(CC) $^ -o $@ $(FLAGS) -L $(LIBDIR)

$(LIBDIR)/$(LIBRARY): $(LIBCOMPS)
	@echo linking library
	@test -d $(@D) || mkdir -p $(@D)
	@$(CC) -shared $^ -o $@ $(FLAGS)

$(OBJDIR)/%.o: $(SRCDIR)/%.c $(INCLUDS)
	@echo compiling $<
	@test -d $(@D) || mkdir -p $(@D)
	@$(CC) -c $< -o $@ $(FLAGS) -I $(INCDIR)

clean:
	@echo Cleaning up...
	@rm -f -r $(OBJDIR) $(BINDIR)
	@rm -f $(TARGET).exe.stackdump

install: $(BINARY)
	@echo Installing...
	@cp $(BINARY) $(INSDIR)
	@echo Installed!

uninstall:
	@echo Uninstalling...
	@rm $(INSDIR)/$(TARGET)
	@echo Uninstalled!

run: $(BINARY)
	@echo Running...
	@echo -----------------------------------------
	@$(BINARY) $(TESTARGS)
	@echo -----------------------------------------