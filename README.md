# Character-Frequency-Calculator-Coal-Project-
# Character Frequency Calculator

## Overview

This character frequency calculator is implemented in x86 assembly language. The program takes a user-inputted string and calculates the frequency of each character. Users can choose to display the frequency in binary, decimal, or hexadecimal format.

## File Structure

- `freq_calc.asm`: Assembly code file containing the character frequency calculator.
- `README.md` (this file): Readme file providing information about the program.

## Usage

1. Assemble and link the `freq_calc.asm` file using an appropriate x86 assembler and linker.
2. Run the resulting executable to input a string and choose the display format.

## Procedures

- `frequency`: Increments the frequency count of a character.
- `clearfreq`: Resets all character frequencies to zero.
- `decout`: Displays a decimal number.
- `binout`: Displays a binary number.
- `hexout`: Displays a hexadecimal number.

## Input

1. The user is prompted to enter a string.
2. The program then prompts the user to choose the display format (binary, decimal, or hexadecimal).

## Output

- The program displays the frequency of each character in the chosen format.
- Results are displayed with a colon (:) separator between the character and its frequency.

## Termination

- The program terminates when the user chooses to exit.

## Additional Notes

- The program uses x86 assembly language and is designed to run on DOS-like environments.
- Ensure proper setup and configuration of your assembler and linker to build and run the program.

## License

This program is provided as-is under the open-source license. Refer to the LICENSE file for more details.

## Author

- [Your Name]
- [Your Email]

## Contact

For issues or inquiries, contact the author at [Your Email].
