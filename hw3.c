#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <string.h>
#define COUNT 3

//#define MAX_NAME_LENGTH 32

#ifdef PACK
#pragma pack(push)
#pragma pack(1)
#endif

typedef struct _BUSINESS3
{
    uint32_t taxId;
    char name[27];
    char street[34];
    char direction;
    uint32_t addNo;
    char city[40];
    char state[3];
    uint32_t zip;
} BUSINESS3;

#ifdef PACK
#pragma pack(pop)
#endif


extern int32_t sumS32(const int32_t x[], int32_t count);
extern uint64_t sumU32_64(const uint32_t x[], uint32_t count);
extern uint32_t countNegative(const int32_t x[], uint32_t count);
extern void leftStringFull(char strOut[], const char strIn[], uint32_t length);
extern void leftStringTrunc(char strOut[], const char strIn[], uint32_t length);
extern uint32_t countMatches(const char strIn[], const char strMatch[]);
extern int32_t find2ndMatch(const char strIn[], const char strMatch[]);
extern void sortDecendingInPlace(int32_t x[], uint32_t count);
extern int8_t decimalStringToInt8(const char str[]);
extern uint32_t hexStringToUint32(const char str[]);
extern void uint8ToBinaryString(char str[], uint8_t x);
extern int32_t findStreet(char street[], const BUSINESS3 business[], uint32_t count); 

int main ()
{
	//a. sumS32
	uint32_t y[] = {5,5,5,5,5,5};
	int32_t count1 = 6;
	printf("part A.");
	printf("\n");
	printf("%d", sumS32(y, count1));
	printf("\n\n");
	
	
	// b. sumU32_64
	
	const uint32_t a[] = {5,5,5,5,5,5};
	uint32_t count2 = 6;
	printf("part B.");
	printf("\n");
	printf("%lld", sumU32_64(a, count2));
	printf("\n\n");
	
	// c. countNegative
	
	const int32_t x[] = {5,-10,-15,-20,25,-30};
	uint32_t count = 6;
	printf("part C.");
	printf("\n");
	printf("%d", countNegative(x,count));
	printf("\n\n");
	
	
	// d. leftstringfull
	
	int i;
	char strOut[21];
	strOut[21] = '\0';
	const char strIn[] = "Wherearemyniggasat?....";
	uint32_t length = 20;
	printf("part d.");
	printf("\n");
	leftStringFull(strOut, strIn, length);
	
	for(i=0; i<20; i++)
	{
			printf("%c", strOut[i]);
	}
	
	printf("\n\n");
	
	
	//e. leftStringTrunc
	
	printf("part e.");
	printf("\n");
	leftStringTrunc(strOut, strIn, length);
	for(i=0; i<20; i++)
	{
			printf("%c", strOut[i]);
	}
	printf("\n\n");
	
	
	//f. countMatches
	const char strMatch[] = "nigga";
	
	printf("part f.");
	printf("\n");
	printf("%d", countMatches(strIn, strMatch));
	printf("\n\n");
	
	
	//g. find2Match
	
	printf("part g.");
	printf("\n");
	printf("%d", find2ndMatch(strIn, strMatch));
	printf("\n\n");
	
	
	//h. sortDecendingInPlace
	printf("part h.");
	printf("\n");
	int32_t b[] = {6,5,3,1,2,4};
	count = 6;
	sortDecendingInPlace(b, count);
	for(i=0; i<6; i++)
	{
			printf("%d ", b[i]);
	}
	printf("\n\n");
	
	//i. decimalStringToInt8
	const char str[]="12";
	printf("part i.");
	printf("\n");
	printf("%d", decimalStringToInt8(str));
	printf("\n\n");
	
	//j. hexStringToUint32
	const char str1[]="12";
	printf("part j.");
	printf("\n");
	printf("%u", hexStringToUint32(str1));
	printf("\n\n");
	
	//k. unit8ToBinaryString
    uint8_t m = 25;
    char binary[8];
    uint8ToBinaryString(binary, m);
    
	printf("part k.");
	printf("\n");
	for(i=0; i<8; i++)
	{
		printf("%c", binary[i]);
	}
	
	printf("\n\n");
	
	//l. findStreet
	char street[] = " Lamar";
	BUSINESS3 business[COUNT] = {
      {12342332, "Home Depot", "Road to Six Flags",'W', 201, "Arlington", "TX", 76011},
      {12342333, "Kroger", "Lamar",'S', 202, "Arlington", "TX", 76012},
      {12342334, "Round1", "Cooper",'S', 203, "Arlington", "TX", 76015}, };
      
	uint32_t counter = 1;
	printf("part l.");
	printf("\n");
	//printf("%c", *business[1][3]);
	
	 /*printf("Addresses of selected record entries:\r\n");
      
      char format[] = {"%p %s\r\n"};
      printf(format, &business[0], "business[0]");
      printf(format, &business[0].taxId, "taxId");
      printf(format, &business[0].name, "name");
      printf(format, &business[0].street, "street");
      printf(format, &business[0].direction, "direction");
      printf(format, &business[0].addNo, "addNo");
      printf(format, &business[0].city, "city");
      printf(format, &business[0].state, "state");
      printf(format, &business[0].zip, "zip");
      printf(format, &business[1], "business[1]");
      printf(format, &business[2], "business[2]");
	*/
	
	printf("\n\n");
	printf("%d", findStreet(street, business, counter));
	printf("\n\n");
	
	return 0;
	
}

