#include "UpperCase/program_io.h"

#include <stdio.h>

/**
 * The main method of the program
 * 
 * @param argc the number of command line arguments (must be 2)
 * @param argv the command line arguments (second argument specifies the name of the file being read)
 *
 * @return the exit status of the program
 */
int main(int argc, char const *argv[])
{
	// Test if filename is given (print error if not)
	if (argc < 2)
	{
		printf("ERROR! Filename must be specified in arguments!\n");
		return 1;
	}

	// Open the file (return error if failed)
	if (!open_program(argv[1]))
	{
		printf("ERROR! Something went wrong when reading the file\n");
		return 1;
	}

	// Read for each character in the file
	while(next_character())
	{
		// If character is invalid, print error message and end program with exit status 1
		if (invalid_character())
		{
			printf(" --> ERROR: Invalid character! Must be an uppercase letter!\n");
			close_program();	
			return 1;
		}

		// Print character
		printf("%c\n", current_character());
	}

	// Close program and exit the program
	close_program();
	return 0;
}