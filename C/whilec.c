#include<stdio.h>


int main(int argc, char *argv[])
{
	int i = 0;

	while(i != argc){
		printf("%s is the %d  element\n", argv[i], i);
		i++;
	}

	return 0;
}
