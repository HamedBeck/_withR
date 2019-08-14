#include<stdio.h>

int main(int argc, char *argv[])
{
	printf(" the number of arguments is %d \n", argc);
	printf(" argv is %s \n", argv[2]); 
	for(int i=1; i < argc-1 ; i++){
		char letter = argv[i];
		switch(letter){
			case 'N':
			case 'n':
				printf("does the %s means NO\n", argv[i]);
			case 'y':
			case 'Y':
				printf("does the %s means YES\n", argv[i]);
			default:
				printf(" %s  is neutral\n", argv[i]);
		}
	}

	return 0;

}	
			
