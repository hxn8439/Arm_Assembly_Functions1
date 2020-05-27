Assembly functions that implement the following C functions:

a. int32_t sumS32(const int32_t x[], int32_t count)
// returns sum of the values in the array (x) containing count entries, modulo
2^32.
// in other words, only the 32-bits of the sum are preserved, so the carry out is
lost

b. uint64_t sumU32_64(const uint32_t x[], uint32_t count)
// returns the 64-bit sum of the values in the array (x) containing count entries

c. uint32_t countNegative(const int32_t x[], uint32_t count)
// returns number of negative values in the array (x) containing count entries

d. void leftStringFull(char strOut[], const char strIn[], uint32_t length)
// input: array (strIn) containing the input string, and the number of characters to
extract (length)

// output: array (strOut) containing length number of strIn characters from the
start of the array or a null string if the length is too large

e. void leftStringTrunc(char strOut[], const char strIn[], uint32_t length)
// input: array (strIn) containing the input string, and the number of characters to
extract (length)

// output: array (strOut) containing up to, but not exceeding length number of
strIn characters from the start of the array

f. uint32_t countMatches(const char strIn[], const char strMatch[])
// input: array (strMatch) containing the string to match in the array (strIn)
// output: returns the number of occurences of strMatch in strIn

g. int32_t find2ndMatch(const char strIn[], const char strMatch[])
// input: array (strMatch) containing the string to find in the array (strIn)
// output: returns the offset within str of the 2nd occurrence of strMatch or -1 if
not found

h. void sortDecendingInPlace (int32_t x[], uint32_t count)
// input: array (x) containing count entries
// output: array (x), with the values sorted in descending order

i. int8_t decimalStringToInt8(const char str[])
// convert the null-terminated string (str) to a signed 8-bit integer
// treat the string as representing a decimal number
// if a character other than 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, or – is present, return 0

j. uint32_t hexStringToUint32(const char str[])
// convert the null-terminated string (str) to an unsigned 32-bit integer
// treat the string as representing a hexadecimal number
// if a character other than 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, or F is present,
return 0

k. void uint8ToBinaryString (char str[], uint8_t x)
// convert the unsigned integer (x) to a null-terminated string (str) representing a
binary number

l. int32_t findStreet (char street[], const BUSINESS3 business[], uint32_t count)
// returns the index of the first entry in the array (business) containing count
entries which matches the requested street. If the name is not found, return a
value of -1.
