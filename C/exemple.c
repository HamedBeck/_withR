#include <stdio.h>

int main(int argc, char *argv[])
{
	double vint[]={2000,3000,1470,5878,1006};
	float vdbl[5];
	 

	char names[]={'B', 'b', 'k', 'a','l'};

	int sum =0;
	int i =0;

	for(i=0 ; i<5 ; ++i){
		sum += vint[i];
	}

	for(i=0; i<5 ; ++i){
		vdbl[i] = vint[i] / sum;
	}
	printf(" the sum is %d\n", sum);
	printf(" forst ratio is %f\n", vint[1]/sum);

	for(i=0; i <5 ; ++i){
		printf("%c har %f andel af data\n", names[i], vdbl[i]);
	}

	return 0;

}
		


