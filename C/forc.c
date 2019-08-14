#include<stdio.h>


int main(int argc, char *argv[])
{
	int i;
	for(i = 0; i < argc; i++){
		printf("%s is the %d th element\n", argv[i], i);
	}

	return 0;
}	
